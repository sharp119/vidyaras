-- Fix RLS policies for custom auth (no Supabase Auth session)
-- The app uses phone auth with local storage, so auth.uid() returns null.
-- These updated policies check user existence in the users table instead.

-- Drop existing INSERT policies
DROP POLICY IF EXISTS "Authenticated users can post in global chat" ON public.chat_messages;
DROP POLICY IF EXISTS "Enrolled users can post in course chat" ON public.chat_messages;

-- New policy: Allow insert if user_id exists in users table (global chat)
CREATE POLICY "Users can post in global chat" 
ON public.chat_messages FOR INSERT 
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.users WHERE users.id = chat_messages.user_id
    ) AND
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'global'
    )
);

-- New policy: Allow insert if user is enrolled in course (for course chats)
CREATE POLICY "Enrolled users can post in course chat" 
ON public.chat_messages FOR INSERT 
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.users WHERE users.id = chat_messages.user_id
    ) AND
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        JOIN public.enrollments ON chat_rooms.course_id = enrollments.course_id
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'course'
        AND enrollments.user_id = chat_messages.user_id
        AND enrollments.status = 'active'
    )
);

-- Also update SELECT policies to not require auth.uid()
DROP POLICY IF EXISTS "Global chat messages are viewable by everyone" ON public.chat_messages;
DROP POLICY IF EXISTS "Course chat messages are viewable by enrolled users" ON public.chat_messages;

-- Allow anyone to view global chat messages
CREATE POLICY "Global chat messages are viewable by everyone" 
ON public.chat_messages FOR SELECT 
USING (
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'global'
    )
);

-- Allow enrolled users to view course chat messages
CREATE POLICY "Course chat messages are viewable by enrolled users" 
ON public.chat_messages FOR SELECT 
USING (
    EXISTS (
        SELECT 1 FROM public.chat_rooms 
        JOIN public.enrollments ON chat_rooms.course_id = enrollments.course_id
        WHERE chat_rooms.id = chat_messages.room_id 
        AND chat_rooms.type = 'course'
        AND enrollments.status = 'active'
    )
);
