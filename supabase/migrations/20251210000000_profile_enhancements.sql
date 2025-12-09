-- Profile Enhancements Migration
-- Adds bio and referral_points to profiles table
-- Creates user_answers table for quiz submissions

-- 1. Add missing columns to profiles table
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS bio TEXT;

-- Add constraint for bio length (max 500 characters)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint WHERE conname = 'bio_length'
    ) THEN
        ALTER TABLE public.profiles ADD CONSTRAINT bio_length CHECK (length(bio) <= 500);
    END IF;
END $$;

-- Add referral_points column with default value
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS referral_points INTEGER DEFAULT 0;

-- 2. Create user_answers table for quiz submissions
CREATE TABLE IF NOT EXISTS public.user_answers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    attempt_id UUID NOT NULL,
    question_id UUID NOT NULL,
    selected_option_id INTEGER,
    is_correct BOOLEAN DEFAULT false,
    marks_awarded INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Add index for faster lookups by attempt_id
CREATE INDEX IF NOT EXISTS idx_user_answers_attempt_id ON public.user_answers(attempt_id);

-- Add index for faster lookups by question_id
CREATE INDEX IF NOT EXISTS idx_user_answers_question_id ON public.user_answers(question_id);

-- Enable RLS on user_answers
ALTER TABLE public.user_answers ENABLE ROW LEVEL SECURITY;

-- RLS Policy: Users can view their own answers
CREATE POLICY "Users can view own answers"
ON public.user_answers FOR SELECT
USING (
    EXISTS (
        SELECT 1 FROM public.quiz_attempts
        WHERE quiz_attempts.id = user_answers.attempt_id
        AND quiz_attempts.user_id = auth.uid()
    )
);

-- RLS Policy: Users can insert their own answers
CREATE POLICY "Users can insert own answers"
ON public.user_answers FOR INSERT
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.quiz_attempts
        WHERE quiz_attempts.id = user_answers.attempt_id
        AND quiz_attempts.user_id = auth.uid()
    )
);

-- 3. Add comment to document the schema changes
COMMENT ON COLUMN public.profiles.bio IS 'User biography (max 500 characters)';
COMMENT ON COLUMN public.profiles.referral_points IS 'Points earned through referrals';
COMMENT ON TABLE public.user_answers IS 'Stores individual quiz question answers for each attempt';
