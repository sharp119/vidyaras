-- Chat Rooms Table
CREATE TABLE IF NOT EXISTS public.chat_rooms (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    course_id uuid REFERENCES public.courses(id) ON DELETE CASCADE, -- NULL for global chat
    name text NOT NULL,
    type text NOT NULL CHECK (type IN ('global', 'course')),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now(),
    UNIQUE(course_id) -- One chat room per course
);

-- Enable RLS on chat_rooms
ALTER TABLE public.chat_rooms ENABLE ROW LEVEL SECURITY;

-- Chat Messages Table
CREATE TABLE IF NOT EXISTS public.chat_messages (
    id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
    room_id uuid REFERENCES public.chat_rooms(id) ON DELETE CASCADE NOT NULL,
    user_id uuid REFERENCES public.users(id) ON DELETE CASCADE NOT NULL,
    content text NOT NULL,
    message_type text DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'file')),
    created_at timestamptz DEFAULT now(),
    updated_at timestamptz DEFAULT now()
);

-- Enable RLS on chat_messages
ALTER TABLE public.chat_messages ENABLE ROW LEVEL SECURITY;

-- RLS Policies for Chat Rooms

-- Everyone can view the global chat room
CREATE POLICY "Global chat room is viewable by everyone" 
ON public.chat_rooms FOR SELECT 
USING (type = 'global');

-- Users can view chat rooms for courses they are enrolled in
CREATE POLICY "Course chat rooms are viewable by enrolled users" 
ON public.chat_rooms FOR SELECT 
USING (
    type = 'course' AND 
    EXISTS (
        SELECT 1 FROM public.enrollments 
        WHERE enrollments.course_id = chat_rooms.course_id 
        AND enrollments.user_id = auth.uid() 
        AND enrollments.status = 'active'
    )
);

-- RLS Policies for Chat Messages

-- Users can view messages in the global chat
CREATE POLICY "Global chat messages are viewable by everyone" 
ON public.chat_messages FOR SELECT 
USING (
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'global'
    )
);

-- Users can insert messages in the global chat (authenticated)
CREATE POLICY "Authenticated users can post in global chat" 
ON public.chat_messages FOR INSERT 
WITH CHECK (
    auth.uid() = user_id AND
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'global'
    )
);

-- Users can view messages in course chats they are enrolled in
CREATE POLICY "Course chat messages are viewable by enrolled users" 
ON public.chat_messages FOR SELECT 
USING (
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        JOIN public.enrollments ON chat_rooms.course_id = enrollments.course_id
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'course'
        AND enrollments.user_id = auth.uid()
        AND enrollments.status = 'active'
    )
);

-- Users can insert messages in course chats they are enrolled in
CREATE POLICY "Enrolled users can post in course chat" 
ON public.chat_messages FOR INSERT 
WITH CHECK (
    auth.uid() = user_id AND
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        JOIN public.enrollments ON chat_rooms.course_id = enrollments.course_id
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'course'
        AND enrollments.user_id = auth.uid()
        AND enrollments.status = 'active'
    )
);

-- Function to automatically create a chat room when a course is created
CREATE OR REPLACE FUNCTION public.handle_new_course_chat_room() 
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.chat_rooms (course_id, name, type)
    VALUES (NEW.id, NEW.title, 'course');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger for new course creation
DROP TRIGGER IF EXISTS on_course_created_create_chat_room ON public.courses;
CREATE TRIGGER on_course_created_create_chat_room
    AFTER INSERT ON public.courses
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_course_chat_room();

-- Insert Global Chat Room if it doesn't exist
INSERT INTO public.chat_rooms (id, name, type)
VALUES ('00000000-0000-0000-0000-000000000000', 'VidyaRas Community', 'global')
ON CONFLICT DO NOTHING;

-- Backfill chat rooms for existing courses
INSERT INTO public.chat_rooms (course_id, name, type)
SELECT id, title, 'course'
FROM public.courses
WHERE id NOT IN (SELECT course_id FROM public.chat_rooms WHERE type = 'course');
