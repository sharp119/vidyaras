


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE OR REPLACE FUNCTION "public"."calculate_quiz_accuracy"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NEW.is_completed = true AND NEW.total_marks > 0 THEN
    NEW.accuracy := (NEW.score::NUMERIC / NEW.total_marks::NUMERIC) * 100;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."calculate_quiz_accuracy"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_role"() RETURNS "text"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  user_role TEXT;
BEGIN
  SELECT role INTO user_role
  FROM public.profiles
  WHERE id = auth.uid();
  
  RETURN user_role;
END;
$$;


ALTER FUNCTION "public"."get_my_role"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_course_chat_room"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
    INSERT INTO public.chat_rooms (course_id, name, type)
    VALUES (NEW.id, NEW.title, 'course');
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_course_chat_room"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  user_full_name text;
  user_avatar text;
BEGIN
  -- Extract metadata safely
  user_full_name := COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'name', 'New User');
  user_avatar := NEW.raw_user_meta_data->>'avatar_url';

  INSERT INTO public.profiles (id, email, full_name, name, avatar_url, role)
  VALUES (
    NEW.id, 
    NEW.email, 
    user_full_name,
    user_full_name, -- Populate the required 'name' column with the same value
    user_avatar, 
    'student'
  );
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
  begin
    new.updated_at = now();
    return new;
  end;
  $$;


ALTER FUNCTION "public"."handle_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = auth.uid() AND role = 'admin'
  );
END;
$$;


ALTER FUNCTION "public"."is_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."merge_user_accounts"("phone_number_input" "text") RETURNS "jsonb"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
  current_user_id UUID;
  legacy_user_id UUID;
  legacy_user_record RECORD;
  result_summary JSONB;
BEGIN
  -- Get the ID of the currently logged-in user (The Google User)
  current_user_id := auth.uid();
  
  IF current_user_id IS NULL THEN
    RAISE EXCEPTION 'Not authenticated';
  END IF;

  -- 1. Check if this phone number is already linked to ANOTHER secure account
  -- (i.e., another Google user already claimed it)
  IF EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE phone_number = phone_number_input 
    AND id != current_user_id 
    AND id IN (SELECT id FROM auth.users) -- Only check real auth users
  ) THEN
    RAISE EXCEPTION 'Phone number already linked to another account';
  END IF;

  -- 2. Find the "Legacy" User (Phone-only user)
  -- We assume legacy users might exist in profiles but NOT have a corresponding auth.users entry
  -- OR they have an auth.users entry but it's a "phone" provider one that we are abandoning.
  -- For this logic, we look for a profile with this phone number that IS NOT the current user.
  SELECT id INTO legacy_user_id 
  FROM public.profiles 
  WHERE phone_number = phone_number_input 
  AND id != current_user_id
  LIMIT 1;

  -- 3. If Legacy User Found -> MERGE DATA
  IF legacy_user_id IS NOT NULL THEN
    
    -- Move Enrollments
    UPDATE public.enrollments 
    SET user_id = current_user_id 
    WHERE user_id = legacy_user_id;

    -- Move Quiz Attempts
    UPDATE public.quiz_attempts 
    SET user_id = current_user_id 
    WHERE user_id = legacy_user_id;

    -- Move Lecture Completions
    UPDATE public.lecture_completions 
    SET user_id = current_user_id 
    WHERE user_id = legacy_user_id;

    -- Move Course Creators (if any)
    UPDATE public.course_creators 
    SET user_id = current_user_id 
    WHERE user_id = legacy_user_id;

    -- Delete the old legacy profile to prevent future conflicts
    DELETE FROM public.profiles WHERE id = legacy_user_id;
    
    result_summary := jsonb_build_object(
      'status', 'merged',
      'legacy_id', legacy_user_id,
      'message', 'Successfully merged legacy account data.'
    );

  ELSE
    result_summary := jsonb_build_object(
      'status', 'linked',
      'message', 'Phone number linked. No legacy account found.'
    );
  END IF;

  -- 4. Update Current User Profile with Phone Number
  UPDATE public.profiles 
  SET 
    phone_number = phone_number_input,
    updated_at = NOW()
  WHERE id = current_user_id;

  RETURN result_summary;

EXCEPTION WHEN OTHERS THEN
  RAISE EXCEPTION 'Merge failed: %', SQLERRM;
END;
$$;


ALTER FUNCTION "public"."merge_user_accounts"("phone_number_input" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."set_attempt_number"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Count existing completed attempts for this user and quiz
  SELECT COALESCE(MAX(attempt_number), 0) + 1
  INTO NEW.attempt_number
  FROM quiz_attempts
  WHERE user_id = NEW.user_id 
    AND quiz_id = NEW.quiz_id
    AND id != NEW.id;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."set_attempt_number"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."backup_chat_messages_20251206" (
    "id" "uuid",
    "room_id" "uuid",
    "user_id" "uuid",
    "content" "text",
    "message_type" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone
);


ALTER TABLE "public"."backup_chat_messages_20251206" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."backup_lecture_completions_20251206" (
    "id" "uuid",
    "user_id" "uuid",
    "lecture_id" "uuid",
    "completed_at" timestamp with time zone,
    "watched_seconds" integer,
    "created_at" timestamp with time zone
);


ALTER TABLE "public"."backup_lecture_completions_20251206" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."backup_question_analytics_20251206" (
    "id" "uuid",
    "attempt_id" "uuid",
    "question_id" "uuid",
    "time_spent_seconds" integer,
    "is_bookmarked" boolean,
    "visit_count" integer,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone
);


ALTER TABLE "public"."backup_question_analytics_20251206" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."backup_quiz_attempts_20251206" (
    "id" "uuid",
    "user_id" "uuid",
    "quiz_id" "uuid",
    "score" integer,
    "total_marks" integer,
    "percentage" numeric(5,2),
    "time_taken_seconds" integer,
    "started_at" timestamp with time zone,
    "completed_at" timestamp with time zone,
    "is_completed" boolean,
    "created_at" timestamp with time zone,
    "attempt_number" integer,
    "rank" integer,
    "percentile" numeric(5,2),
    "accuracy" numeric(5,2)
);


ALTER TABLE "public"."backup_quiz_attempts_20251206" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."backup_user_answers_20251206" (
    "id" bigint,
    "attempt_id" "uuid",
    "question_id" "uuid",
    "selected_option_id" integer,
    "is_correct" boolean,
    "marks_awarded" integer,
    "answered_at" timestamp with time zone
);


ALTER TABLE "public"."backup_user_answers_20251206" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."backup_users_20251206" (
    "id" "uuid",
    "phone_number" "text",
    "name" "text",
    "email" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone
);


ALTER TABLE "public"."backup_users_20251206" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chat_messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "room_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "content" "text" NOT NULL,
    "message_type" "text" DEFAULT 'text'::"text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "chat_messages_message_type_check" CHECK (("message_type" = ANY (ARRAY['text'::"text", 'image'::"text", 'file'::"text"])))
);


ALTER TABLE "public"."chat_messages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."chat_rooms" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "course_id" "uuid",
    "name" "text" NOT NULL,
    "type" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "chat_rooms_type_check" CHECK (("type" = ANY (ARRAY['global'::"text", 'course'::"text"])))
);


ALTER TABLE "public"."chat_rooms" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."course_materials" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "course_id" "uuid" NOT NULL,
    "title" "text" NOT NULL,
    "type" "text" DEFAULT 'pdf'::"text" NOT NULL,
    "file_url" "text" NOT NULL,
    "file_size_mb" numeric(5,2),
    "section_id" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "course_materials_type_check" CHECK (("type" = ANY (ARRAY['pdf'::"text", 'video'::"text", 'doc'::"text", 'image'::"text", 'other'::"text"])))
);


ALTER TABLE "public"."course_materials" OWNER TO "postgres";


COMMENT ON TABLE "public"."course_materials" IS 'Stores downloadable course materials like PDFs, videos, documents';



COMMENT ON COLUMN "public"."course_materials"."section_id" IS 'Optional: which section this material belongs to (e.g., s1, s2)';



CREATE TABLE IF NOT EXISTS "public"."courses" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "thumbnail_url" "text",
    "category" "text",
    "is_premium" boolean DEFAULT false NOT NULL,
    "price" numeric(10,2),
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "instructor" "text",
    "rating" numeric(2,1) DEFAULT 0.0,
    "review_count" integer DEFAULT 0,
    "enrolled_count" integer DEFAULT 0,
    "duration" "text",
    "is_live" boolean DEFAULT false,
    "is_recorded" boolean DEFAULT false,
    "has_free_trial" boolean DEFAULT false,
    "language" "text" DEFAULT 'Bilingual (Hindi + English)'::"text",
    "has_certificate" boolean DEFAULT true,
    "has_quizzes" boolean DEFAULT true,
    "has_materials" boolean DEFAULT true,
    "access_days" integer,
    "status" "text" DEFAULT 'draft'::"text",
    "created_by" "uuid",
    "what_you_learn" "text"[] DEFAULT '{}'::"text"[],
    "course_includes" "text"[] DEFAULT '{}'::"text"[],
    "prerequisites" "text"[] DEFAULT '{}'::"text"[],
    "original_price" numeric,
    CONSTRAINT "courses_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'published'::"text", 'archived'::"text"])))
);


ALTER TABLE "public"."courses" OWNER TO "postgres";


COMMENT ON TABLE "public"."courses" IS 'Stores course information for the learning platform';



COMMENT ON COLUMN "public"."courses"."is_premium" IS 'Whether this course requires paid subscription';



COMMENT ON COLUMN "public"."courses"."price" IS 'Course price in INR (null if free or included in subscription)';



COMMENT ON COLUMN "public"."courses"."instructor" IS 'Course instructor name';



COMMENT ON COLUMN "public"."courses"."is_live" IS 'Course has live sessions';



COMMENT ON COLUMN "public"."courses"."is_recorded" IS 'Course has recorded lectures';



COMMENT ON COLUMN "public"."courses"."access_days" IS 'Days of access for recorded courses (null = lifetime)';



CREATE TABLE IF NOT EXISTS "public"."enrollments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "course_id" "uuid" NOT NULL,
    "enrolled_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "status" "text" DEFAULT 'active'::"text" NOT NULL,
    "last_accessed_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "completed_at" timestamp with time zone,
    "progress_percentage" integer DEFAULT 0,
    CONSTRAINT "enrollments_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'completed'::"text", 'expired'::"text"])))
);


ALTER TABLE "public"."enrollments" OWNER TO "postgres";


COMMENT ON TABLE "public"."enrollments" IS 'Tracks which users are enrolled in which courses';



COMMENT ON COLUMN "public"."enrollments"."status" IS 'active = currently enrolled, completed = finished course, expired = enrollment ended';



CREATE TABLE IF NOT EXISTS "public"."lecture_completions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "lecture_id" "uuid" NOT NULL,
    "completed_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "watched_seconds" integer,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."lecture_completions" OWNER TO "postgres";


COMMENT ON TABLE "public"."lecture_completions" IS 'Tracks which lectures each user has completed';



COMMENT ON COLUMN "public"."lecture_completions"."watched_seconds" IS 'Total seconds watched (for video resume functionality)';



CREATE TABLE IF NOT EXISTS "public"."lectures" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "course_id" "uuid" NOT NULL,
    "section_id" "text" NOT NULL,
    "section_title" "text" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "order_index" integer NOT NULL,
    "type" "text" DEFAULT 'video'::"text" NOT NULL,
    "duration_minutes" integer,
    "video_url" "text",
    "required_quiz_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "module_id" "uuid",
    CONSTRAINT "lectures_type_check" CHECK (("type" = ANY (ARRAY['video'::"text", 'live'::"text", 'reading'::"text", 'practice'::"text"])))
);


ALTER TABLE "public"."lectures" OWNER TO "postgres";


COMMENT ON TABLE "public"."lectures" IS 'Stores individual lectures/lessons within courses';



COMMENT ON COLUMN "public"."lectures"."section_id" IS 'Section identifier (e.g., s1, s2, s3)';



COMMENT ON COLUMN "public"."lectures"."order_index" IS 'Order of lecture within course curriculum';



COMMENT ON COLUMN "public"."lectures"."required_quiz_id" IS 'Quiz that must be completed to unlock next lecture';



CREATE TABLE IF NOT EXISTS "public"."lesson_contents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "lesson_id" "uuid",
    "type" "text" NOT NULL,
    "title" "text" NOT NULL,
    "url" "text",
    "file_type" "text",
    "duration" integer,
    "scheduled_at" timestamp with time zone,
    "order_index" integer DEFAULT 0,
    "prerequisite_quiz_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."lesson_contents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."lessons" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "module_id" "uuid" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "content_type" "text",
    "video_url" "text",
    "pdf_url" "text",
    "duration" integer,
    "order_index" integer DEFAULT 0,
    "is_free_preview" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "lessons_content_type_check" CHECK (("content_type" = ANY (ARRAY['video'::"text", 'pdf'::"text", 'text'::"text", 'quiz'::"text"])))
);


ALTER TABLE "public"."lessons" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."live_classes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "course_id" "uuid" NOT NULL,
    "lecture_id" "uuid",
    "title" "text" NOT NULL,
    "description" "text",
    "scheduled_at" timestamp with time zone NOT NULL,
    "duration_minutes" integer DEFAULT 120 NOT NULL,
    "zoom_link" "text" NOT NULL,
    "meeting_id" "text",
    "passcode" "text",
    "recording_url" "text",
    "status" "text" DEFAULT 'upcoming'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "live_classes_status_check" CHECK (("status" = ANY (ARRAY['completed'::"text", 'upcoming'::"text", 'live'::"text"])))
);


ALTER TABLE "public"."live_classes" OWNER TO "postgres";


COMMENT ON TABLE "public"."live_classes" IS 'Stores scheduled live class sessions with Zoom links';



COMMENT ON COLUMN "public"."live_classes"."recording_url" IS 'Available after class completes for replay';



COMMENT ON COLUMN "public"."live_classes"."status" IS 'completed = finished with recording, upcoming = not yet started, live = currently happening';



CREATE TABLE IF NOT EXISTS "public"."live_session_courses" (
    "session_id" "uuid" NOT NULL,
    "course_id" "uuid" NOT NULL
);


ALTER TABLE "public"."live_session_courses" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."live_sessions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "instructor_name" "text",
    "start_time" timestamp with time zone NOT NULL,
    "end_time" timestamp with time zone NOT NULL,
    "meeting_url" "text",
    "platform" "text" DEFAULT 'zoom'::"text",
    "status" "text" DEFAULT 'Scheduled'::"text",
    "attendees_count" integer DEFAULT 0,
    "recording_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "live_sessions_status_check" CHECK (("status" = ANY (ARRAY['Scheduled'::"text", 'Live'::"text", 'Completed'::"text", 'Cancelled'::"text"])))
);


ALTER TABLE "public"."live_sessions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."migration_metadata" (
    "created_at" timestamp with time zone DEFAULT "now"(),
    "total_users" integer,
    "total_quiz_attempts" integer,
    "total_lecture_completions" integer,
    "total_chat_messages" integer,
    "note" "text"
);


ALTER TABLE "public"."migration_metadata" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."modules" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "course_id" "uuid" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "order_index" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "prerequisite_quiz_id" "uuid"
);


ALTER TABLE "public"."modules" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "phone_number" "text",
    "name" "text" NOT NULL,
    "email" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "role" "text" DEFAULT 'student'::"text" NOT NULL,
    "avatar_url" "text",
    "full_name" "text",
    "is_onboarded" boolean DEFAULT false,
    "preferences" "jsonb" DEFAULT '{}'::"jsonb",
    "bio" "text",
    "referral_points" integer DEFAULT 0,
    CONSTRAINT "phone_required_for_onboarding" CHECK ((("is_onboarded" = false) OR (("is_onboarded" = true) AND ("phone_number" IS NOT NULL)))),
    CONSTRAINT "profiles_bio_check" CHECK (("char_length"("bio") <= 500)),
    CONSTRAINT "profiles_role_check" CHECK (("role" = ANY (ARRAY['student'::"text", 'teacher'::"text", 'admin'::"text", 'super_admin'::"text"]))),
    CONSTRAINT "valid_phone_number" CHECK (("phone_number" ~ '^\+[1-9]\d{1,14}$'::"text"))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


COMMENT ON TABLE "public"."profiles" IS 'Single source of truth for all users. Links to auth.users via FK. Phone binding mandatory after Google OAuth.';



COMMENT ON CONSTRAINT "phone_required_for_onboarding" ON "public"."profiles" IS 'Enforces mandatory phone verification before onboarding completion.';



CREATE TABLE IF NOT EXISTS "public"."question_analytics" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "attempt_id" "uuid" NOT NULL,
    "question_id" "uuid" NOT NULL,
    "time_spent_seconds" integer DEFAULT 0 NOT NULL,
    "is_bookmarked" boolean DEFAULT false,
    "visit_count" integer DEFAULT 1,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."question_analytics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."questions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "quiz_id" "uuid" NOT NULL,
    "order_index" integer NOT NULL,
    "options" "jsonb" NOT NULL,
    "correct_option_id" integer NOT NULL,
    "marks" integer DEFAULT 1 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "question_text" "text" NOT NULL,
    "question_type" "text" DEFAULT 'text'::"text",
    "image_url" "text",
    "explanation" "text",
    CONSTRAINT "options_is_array" CHECK (("jsonb_typeof"("options") = 'array'::"text"))
);


ALTER TABLE "public"."questions" OWNER TO "postgres";


COMMENT ON TABLE "public"."questions" IS 'Stores quiz questions with flexible JSONB content for text, LaTeX, images, etc.';



COMMENT ON COLUMN "public"."questions"."options" IS 'Array of option objects: [{"id": 0, "data": {"type": "text", "content": "..."}}, ...]';



COMMENT ON COLUMN "public"."questions"."correct_option_id" IS 'Index of the correct option in the options array (0-based)';



COMMENT ON COLUMN "public"."questions"."marks" IS 'Marks awarded for this question';



CREATE TABLE IF NOT EXISTS "public"."quiz_attempts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "quiz_id" "uuid" NOT NULL,
    "score" integer DEFAULT 0 NOT NULL,
    "total_marks" integer NOT NULL,
    "percentage" numeric(5,2) GENERATED ALWAYS AS (
CASE
    WHEN ("total_marks" > 0) THEN ((("score")::numeric / ("total_marks")::numeric) * (100)::numeric)
    ELSE (0)::numeric
END) STORED,
    "time_taken_seconds" integer,
    "started_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "completed_at" timestamp with time zone,
    "is_completed" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "attempt_number" integer DEFAULT 1,
    "rank" integer,
    "percentile" numeric(5,2),
    "accuracy" numeric(5,2)
);


ALTER TABLE "public"."quiz_attempts" OWNER TO "postgres";


COMMENT ON TABLE "public"."quiz_attempts" IS 'Tracks every quiz attempt by users';



COMMENT ON COLUMN "public"."quiz_attempts"."percentage" IS 'Auto-calculated percentage score';



COMMENT ON COLUMN "public"."quiz_attempts"."time_taken_seconds" IS 'Total time taken to complete the quiz in seconds';



COMMENT ON COLUMN "public"."quiz_attempts"."is_completed" IS 'Whether the quiz was completed or abandoned';



CREATE OR REPLACE VIEW "public"."quiz_leaderboard" AS
 SELECT "quiz_id",
    "user_id",
    "score",
    "percentage",
    "time_taken_seconds",
    "completed_at",
    "attempt_number",
    "row_number"() OVER (PARTITION BY "quiz_id" ORDER BY "score" DESC, "time_taken_seconds") AS "rank",
    ("percent_rank"() OVER (PARTITION BY "quiz_id" ORDER BY "score" DESC) * (100)::double precision) AS "percentile"
   FROM "public"."quiz_attempts" "qa"
  WHERE ("is_completed" = true);


ALTER VIEW "public"."quiz_leaderboard" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."quiz_statistics" AS
 SELECT "quiz_id",
    "count"(DISTINCT "user_id") AS "total_unique_users",
    "count"(*) AS "total_attempts",
    "avg"("score") AS "avg_score",
    "avg"("percentage") AS "avg_percentage",
    "max"("score") AS "highest_score",
    "min"("score") AS "lowest_score",
    "avg"("time_taken_seconds") AS "avg_time_seconds",
    "percentile_cont"((0.5)::double precision) WITHIN GROUP (ORDER BY (("score")::double precision)) AS "median_score"
   FROM "public"."quiz_attempts"
  WHERE ("is_completed" = true)
  GROUP BY "quiz_id";


ALTER VIEW "public"."quiz_statistics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."quizzes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "course_id" "uuid",
    "full_marks" integer DEFAULT 100 NOT NULL,
    "time_limit_minutes" integer DEFAULT 30 NOT NULL,
    "is_published" boolean DEFAULT false NOT NULL,
    "is_public" boolean DEFAULT true NOT NULL,
    "difficulty_level" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "related_lecture_id" "uuid",
    "is_required" boolean DEFAULT false,
    "passing_score" integer DEFAULT 70,
    "module_id" "uuid",
    "lesson_id" "uuid",
    CONSTRAINT "quizzes_difficulty_level_check" CHECK (("difficulty_level" = ANY (ARRAY['beginner'::"text", 'intermediate'::"text", 'advanced'::"text"])))
);


ALTER TABLE "public"."quizzes" OWNER TO "postgres";


COMMENT ON TABLE "public"."quizzes" IS 'Stores quiz information with flexible course linking';



COMMENT ON COLUMN "public"."quizzes"."course_id" IS 'Links to a course (null means standalone/public quiz)';



COMMENT ON COLUMN "public"."quizzes"."full_marks" IS 'Total marks for the quiz';



COMMENT ON COLUMN "public"."quizzes"."time_limit_minutes" IS 'Time limit in minutes';



COMMENT ON COLUMN "public"."quizzes"."is_published" IS 'Toggle to show/hide quiz from students';



COMMENT ON COLUMN "public"."quizzes"."is_public" IS 'If true, available to all users; if false, only for paid/enrolled users';



COMMENT ON COLUMN "public"."quizzes"."related_lecture_id" IS 'Which lecture this quiz belongs to';



COMMENT ON COLUMN "public"."quizzes"."is_required" IS 'If true, blocks next lecture until quiz is passed';



COMMENT ON COLUMN "public"."quizzes"."passing_score" IS 'Minimum percentage (0-100) needed to pass this quiz';



CREATE TABLE IF NOT EXISTS "public"."user_answers" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "attempt_id" "uuid" NOT NULL,
    "question_id" "uuid" NOT NULL,
    "selected_option_id" integer NOT NULL,
    "is_correct" boolean NOT NULL,
    "marks_awarded" integer DEFAULT 0 NOT NULL,
    "answered_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."user_answers" OWNER TO "postgres";


COMMENT ON TABLE "public"."user_answers" IS 'Stores individual answers for each question in a quiz attempt';



COMMENT ON COLUMN "public"."user_answers"."marks_awarded" IS 'Marks awarded for this answer (can be partial marks in future)';



CREATE SEQUENCE IF NOT EXISTS "public"."user_answers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."user_answers_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."user_answers_id_seq" OWNED BY "public"."user_answers"."id";



CREATE OR REPLACE VIEW "public"."user_best_attempts" AS
 SELECT DISTINCT ON ("user_id", "quiz_id") "id",
    "user_id",
    "quiz_id",
    "score",
    "total_marks",
    "percentage",
    "time_taken_seconds",
    "started_at",
    "completed_at",
    "is_completed",
    "created_at",
    "attempt_number",
    "rank",
    "percentile",
    "accuracy"
   FROM "public"."quiz_attempts"
  WHERE ("is_completed" = true)
  ORDER BY "user_id", "quiz_id", "score" DESC, "time_taken_seconds";


ALTER VIEW "public"."user_best_attempts" OWNER TO "postgres";


ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chat_rooms"
    ADD CONSTRAINT "chat_rooms_course_id_key" UNIQUE ("course_id");



ALTER TABLE ONLY "public"."chat_rooms"
    ADD CONSTRAINT "chat_rooms_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."course_materials"
    ADD CONSTRAINT "course_materials_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."courses"
    ADD CONSTRAINT "courses_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_user_id_course_id_key" UNIQUE ("user_id", "course_id");



ALTER TABLE ONLY "public"."lecture_completions"
    ADD CONSTRAINT "lecture_completions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lecture_completions"
    ADD CONSTRAINT "lecture_completions_user_id_lecture_id_key" UNIQUE ("user_id", "lecture_id");



ALTER TABLE ONLY "public"."lectures"
    ADD CONSTRAINT "lectures_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lesson_contents"
    ADD CONSTRAINT "lesson_contents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lessons"
    ADD CONSTRAINT "lessons_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."live_classes"
    ADD CONSTRAINT "live_classes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."live_session_courses"
    ADD CONSTRAINT "live_session_courses_pkey" PRIMARY KEY ("session_id", "course_id");



ALTER TABLE ONLY "public"."live_sessions"
    ADD CONSTRAINT "live_sessions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."modules"
    ADD CONSTRAINT "modules_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_phone_number_unique" UNIQUE ("phone_number");



COMMENT ON CONSTRAINT "profiles_phone_number_unique" ON "public"."profiles" IS 'Ensures one phone number per Google account. Prevents duplicate phone binding across users.';



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."question_analytics"
    ADD CONSTRAINT "question_analytics_attempt_id_question_id_key" UNIQUE ("attempt_id", "question_id");



ALTER TABLE ONLY "public"."question_analytics"
    ADD CONSTRAINT "question_analytics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."questions"
    ADD CONSTRAINT "questions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."quiz_attempts"
    ADD CONSTRAINT "quiz_attempts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."quizzes"
    ADD CONSTRAINT "quizzes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."user_answers"
    ADD CONSTRAINT "unique_answer_per_question_per_attempt" UNIQUE ("attempt_id", "question_id");



ALTER TABLE ONLY "public"."questions"
    ADD CONSTRAINT "unique_question_number_per_quiz" UNIQUE ("quiz_id", "order_index");



ALTER TABLE ONLY "public"."user_answers"
    ADD CONSTRAINT "user_answers_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_course_materials_course_id" ON "public"."course_materials" USING "btree" ("course_id");



CREATE INDEX "idx_course_materials_type" ON "public"."course_materials" USING "btree" ("type");



CREATE INDEX "idx_courses_category" ON "public"."courses" USING "btree" ("category");



CREATE INDEX "idx_courses_created_by" ON "public"."courses" USING "btree" ("created_by");



CREATE INDEX "idx_courses_is_premium" ON "public"."courses" USING "btree" ("is_premium");



CREATE INDEX "idx_courses_status" ON "public"."courses" USING "btree" ("status");



CREATE INDEX "idx_enrollments_course_id" ON "public"."enrollments" USING "btree" ("course_id");



CREATE INDEX "idx_enrollments_status" ON "public"."enrollments" USING "btree" ("status");



CREATE INDEX "idx_enrollments_user_id" ON "public"."enrollments" USING "btree" ("user_id");



CREATE INDEX "idx_lecture_completions_lecture_id" ON "public"."lecture_completions" USING "btree" ("lecture_id");



CREATE INDEX "idx_lecture_completions_user_id" ON "public"."lecture_completions" USING "btree" ("user_id");



CREATE INDEX "idx_lecture_completions_user_lecture" ON "public"."lecture_completions" USING "btree" ("user_id", "lecture_id");



CREATE INDEX "idx_lectures_course_id" ON "public"."lectures" USING "btree" ("course_id");



CREATE INDEX "idx_lectures_module_id" ON "public"."lectures" USING "btree" ("module_id");



CREATE INDEX "idx_lectures_order" ON "public"."lectures" USING "btree" ("course_id", "order_index");



CREATE INDEX "idx_lectures_order_index" ON "public"."lectures" USING "btree" ("order_index");



CREATE INDEX "idx_lectures_section_id" ON "public"."lectures" USING "btree" ("section_id");



CREATE INDEX "idx_lesson_contents_lesson_id" ON "public"."lesson_contents" USING "btree" ("lesson_id");



CREATE INDEX "idx_live_classes_course_id" ON "public"."live_classes" USING "btree" ("course_id");



CREATE INDEX "idx_live_classes_scheduled_at" ON "public"."live_classes" USING "btree" ("scheduled_at");



CREATE INDEX "idx_live_classes_status" ON "public"."live_classes" USING "btree" ("status");



CREATE INDEX "idx_modules_course_id" ON "public"."modules" USING "btree" ("course_id");



CREATE INDEX "idx_modules_order" ON "public"."modules" USING "btree" ("course_id", "order_index");



CREATE INDEX "idx_profiles_email" ON "public"."profiles" USING "btree" ("email");



CREATE UNIQUE INDEX "idx_profiles_phone_unique" ON "public"."profiles" USING "btree" ("phone_number") WHERE ("phone_number" IS NOT NULL);



CREATE INDEX "idx_profiles_role" ON "public"."profiles" USING "btree" ("role");



CREATE INDEX "idx_question_analytics_attempt" ON "public"."question_analytics" USING "btree" ("attempt_id");



CREATE INDEX "idx_question_analytics_question" ON "public"."question_analytics" USING "btree" ("question_id");



CREATE INDEX "idx_questions_question_number" ON "public"."questions" USING "btree" ("quiz_id", "order_index");



CREATE INDEX "idx_questions_quiz_id" ON "public"."questions" USING "btree" ("quiz_id");



CREATE INDEX "idx_quiz_attempts_completed" ON "public"."quiz_attempts" USING "btree" ("is_completed");



CREATE INDEX "idx_quiz_attempts_created_at" ON "public"."quiz_attempts" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_quiz_attempts_quiz_id" ON "public"."quiz_attempts" USING "btree" ("quiz_id");



CREATE INDEX "idx_quiz_attempts_user_id" ON "public"."quiz_attempts" USING "btree" ("user_id");



CREATE INDEX "idx_quiz_attempts_user_quiz" ON "public"."quiz_attempts" USING "btree" ("user_id", "quiz_id");



CREATE INDEX "idx_quizzes_course_id" ON "public"."quizzes" USING "btree" ("course_id");



CREATE INDEX "idx_quizzes_created_at" ON "public"."quizzes" USING "btree" ("created_at" DESC);



CREATE INDEX "idx_quizzes_is_public" ON "public"."quizzes" USING "btree" ("is_public");



CREATE INDEX "idx_quizzes_is_published" ON "public"."quizzes" USING "btree" ("is_published");



CREATE INDEX "idx_quizzes_related_lecture_id" ON "public"."quizzes" USING "btree" ("related_lecture_id");



CREATE INDEX "idx_user_answers_attempt_id" ON "public"."user_answers" USING "btree" ("attempt_id");



CREATE INDEX "idx_user_answers_is_correct" ON "public"."user_answers" USING "btree" ("is_correct");



CREATE INDEX "idx_user_answers_question_id" ON "public"."user_answers" USING "btree" ("question_id");



CREATE INDEX "profiles_created_at_idx" ON "public"."profiles" USING "btree" ("created_at");



CREATE INDEX "profiles_phone_number_idx" ON "public"."profiles" USING "btree" ("phone_number");



CREATE OR REPLACE TRIGGER "on_course_created_create_chat_room" AFTER INSERT ON "public"."courses" FOR EACH ROW EXECUTE FUNCTION "public"."handle_new_course_chat_room"();



CREATE OR REPLACE TRIGGER "profiles_updated_at" BEFORE UPDATE ON "public"."profiles" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();



CREATE OR REPLACE TRIGGER "set_modules_updated_at" BEFORE UPDATE ON "public"."modules" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "trigger_calculate_accuracy" BEFORE UPDATE ON "public"."quiz_attempts" FOR EACH ROW WHEN ((("new"."is_completed" = true) AND ("old"."is_completed" = false))) EXECUTE FUNCTION "public"."calculate_quiz_accuracy"();



CREATE OR REPLACE TRIGGER "trigger_set_attempt_number" BEFORE INSERT ON "public"."quiz_attempts" FOR EACH ROW EXECUTE FUNCTION "public"."set_attempt_number"();



CREATE OR REPLACE TRIGGER "update_profiles_updated_at" BEFORE UPDATE ON "public"."profiles" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_room_id_fkey" FOREIGN KEY ("room_id") REFERENCES "public"."chat_rooms"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chat_messages"
    ADD CONSTRAINT "chat_messages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



COMMENT ON CONSTRAINT "chat_messages_user_id_fkey" ON "public"."chat_messages" IS 'Links chat messages to Google-authenticated profiles. Messages cascade delete with user.';



ALTER TABLE ONLY "public"."chat_rooms"
    ADD CONSTRAINT "chat_rooms_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."course_materials"
    ADD CONSTRAINT "course_materials_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."courses"
    ADD CONSTRAINT "courses_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."enrollments"
    ADD CONSTRAINT "enrollments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lecture_completions"
    ADD CONSTRAINT "lecture_completions_lecture_id_fkey" FOREIGN KEY ("lecture_id") REFERENCES "public"."lectures"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lecture_completions"
    ADD CONSTRAINT "lecture_completions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lectures"
    ADD CONSTRAINT "lectures_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lectures"
    ADD CONSTRAINT "lectures_module_id_fkey" FOREIGN KEY ("module_id") REFERENCES "public"."modules"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lectures"
    ADD CONSTRAINT "lectures_required_quiz_id_fkey" FOREIGN KEY ("required_quiz_id") REFERENCES "public"."quizzes"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."lesson_contents"
    ADD CONSTRAINT "lesson_contents_lesson_id_fkey" FOREIGN KEY ("lesson_id") REFERENCES "public"."lectures"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lesson_contents"
    ADD CONSTRAINT "lesson_contents_prerequisite_quiz_id_fkey" FOREIGN KEY ("prerequisite_quiz_id") REFERENCES "public"."quizzes"("id");



ALTER TABLE ONLY "public"."live_classes"
    ADD CONSTRAINT "live_classes_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."live_classes"
    ADD CONSTRAINT "live_classes_lecture_id_fkey" FOREIGN KEY ("lecture_id") REFERENCES "public"."lectures"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."live_session_courses"
    ADD CONSTRAINT "live_session_courses_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."live_session_courses"
    ADD CONSTRAINT "live_session_courses_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "public"."live_sessions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."question_analytics"
    ADD CONSTRAINT "question_analytics_attempt_id_fkey" FOREIGN KEY ("attempt_id") REFERENCES "public"."quiz_attempts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."question_analytics"
    ADD CONSTRAINT "question_analytics_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."questions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."questions"
    ADD CONSTRAINT "questions_quiz_id_fkey" FOREIGN KEY ("quiz_id") REFERENCES "public"."quizzes"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."quiz_attempts"
    ADD CONSTRAINT "quiz_attempts_quiz_id_fkey" FOREIGN KEY ("quiz_id") REFERENCES "public"."quizzes"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."quiz_attempts"
    ADD CONSTRAINT "quiz_attempts_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."quizzes"
    ADD CONSTRAINT "quizzes_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."quizzes"
    ADD CONSTRAINT "quizzes_related_lecture_id_fkey" FOREIGN KEY ("related_lecture_id") REFERENCES "public"."lectures"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."user_answers"
    ADD CONSTRAINT "user_answers_attempt_id_fkey" FOREIGN KEY ("attempt_id") REFERENCES "public"."quiz_attempts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."user_answers"
    ADD CONSTRAINT "user_answers_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "public"."questions"("id") ON DELETE CASCADE;



CREATE POLICY "Admins and Teachers can view all profiles" ON "public"."profiles" FOR SELECT USING (("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'super_admin'::"text", 'teacher'::"text"])));



CREATE POLICY "Admins can delete courses" ON "public"."courses" FOR DELETE USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can insert courses" ON "public"."courses" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can manage enrollments" ON "public"."enrollments" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can manage lectures" ON "public"."lectures" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can manage live classes" ON "public"."live_classes" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can manage materials" ON "public"."course_materials" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can update all profiles" ON "public"."profiles" FOR UPDATE USING (("public"."get_my_role"() = ANY (ARRAY['admin'::"text", 'super_admin'::"text"])));



CREATE POLICY "Admins can update courses" ON "public"."courses" FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can view all completions" ON "public"."lecture_completions" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can view all courses" ON "public"."courses" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Admins can view all enrollments" ON "public"."enrollments" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'super_admin'::"text"]))))));



CREATE POLICY "Allow public insert question analytics" ON "public"."question_analytics" FOR INSERT WITH CHECK (true);



CREATE POLICY "Allow public insert quiz attempts" ON "public"."quiz_attempts" FOR INSERT WITH CHECK (true);



CREATE POLICY "Allow public insert user answers" ON "public"."user_answers" FOR INSERT WITH CHECK (true);



CREATE POLICY "Allow public select question analytics" ON "public"."question_analytics" FOR SELECT USING (true);



CREATE POLICY "Allow public select quiz attempts" ON "public"."quiz_attempts" FOR SELECT USING (true);



CREATE POLICY "Allow public select user answers" ON "public"."user_answers" FOR SELECT USING (true);



CREATE POLICY "Allow public update question analytics" ON "public"."question_analytics" FOR UPDATE USING (true) WITH CHECK (true);



CREATE POLICY "Allow public update quiz attempts" ON "public"."quiz_attempts" FOR UPDATE USING (true) WITH CHECK (true);



CREATE POLICY "Anyone can view courses" ON "public"."courses" FOR SELECT USING (true);



CREATE POLICY "Anyone can view published quizzes" ON "public"."quizzes" FOR SELECT USING (("is_published" = true));



CREATE POLICY "Anyone can view questions of published quizzes" ON "public"."questions" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."quizzes"
  WHERE (("quizzes"."id" = "questions"."quiz_id") AND ("quizzes"."is_published" = true)))));



CREATE POLICY "Authenticated users can delete questions" ON "public"."questions" FOR DELETE TO "authenticated" USING (true);



CREATE POLICY "Authenticated users can insert courses" ON "public"."courses" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Authenticated users can insert questions" ON "public"."questions" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Authenticated users can insert quizzes" ON "public"."quizzes" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Authenticated users can update courses" ON "public"."courses" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated users can update questions" ON "public"."questions" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated users can update quizzes" ON "public"."quizzes" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Authenticated users can view all questions" ON "public"."questions" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Authenticated users can view all quizzes" ON "public"."quizzes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Course chat messages are viewable by enrolled users" ON "public"."chat_messages" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM ("public"."chat_rooms"
     JOIN "public"."enrollments" ON (("chat_rooms"."course_id" = "enrollments"."course_id")))
  WHERE (("chat_rooms"."id" = "chat_messages"."room_id") AND ("chat_rooms"."type" = 'course'::"text") AND ("enrollments"."status" = 'active'::"text")))));



CREATE POLICY "Course chat rooms are viewable by everyone" ON "public"."chat_rooms" FOR SELECT USING (("type" = 'course'::"text"));



CREATE POLICY "Enable read access for all users" ON "public"."lessons" FOR SELECT USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."live_session_courses" FOR SELECT USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."live_sessions" FOR SELECT USING (true);



CREATE POLICY "Enable read access for all users" ON "public"."modules" FOR SELECT USING (true);



CREATE POLICY "Enable write access for admins" ON "public"."live_session_courses" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Enable write access for admins" ON "public"."live_sessions" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Enable write access for admins and teachers" ON "public"."lessons" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'teacher'::"text"]))))));



CREATE POLICY "Enable write access for admins and teachers" ON "public"."modules" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE (("profiles"."id" = "auth"."uid"()) AND ("profiles"."role" = ANY (ARRAY['admin'::"text", 'teacher'::"text"]))))));



CREATE POLICY "Enrolled students can view lectures" ON "public"."lectures" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."enrollments" "e"
  WHERE (("e"."user_id" = "auth"."uid"()) AND ("e"."course_id" = "lectures"."course_id")))));



CREATE POLICY "Enrolled students can view live classes" ON "public"."live_classes" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."enrollments" "e"
  WHERE (("e"."user_id" = "auth"."uid"()) AND ("e"."course_id" = "live_classes"."course_id")))));



CREATE POLICY "Enrolled students can view materials" ON "public"."course_materials" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."enrollments" "e"
  WHERE (("e"."user_id" = "auth"."uid"()) AND ("e"."course_id" = "course_materials"."course_id")))));



CREATE POLICY "Enrolled users can post in course chat" ON "public"."chat_messages" FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "chat_messages"."user_id"))) AND (EXISTS ( SELECT 1
   FROM ("public"."chat_rooms"
     JOIN "public"."enrollments" ON (("chat_rooms"."course_id" = "enrollments"."course_id")))
  WHERE (("chat_rooms"."id" = "chat_messages"."room_id") AND ("chat_rooms"."type" = 'course'::"text") AND ("enrollments"."user_id" = "chat_messages"."user_id") AND ("enrollments"."status" = 'active'::"text"))))));



CREATE POLICY "Global chat messages are viewable by everyone" ON "public"."chat_messages" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."chat_rooms"
  WHERE (("chat_rooms"."id" = "chat_messages"."room_id") AND ("chat_rooms"."type" = 'global'::"text")))));



CREATE POLICY "Global chat room is viewable by everyone" ON "public"."chat_rooms" FOR SELECT USING (("type" = 'global'::"text"));



CREATE POLICY "Users can insert own completions" ON "public"."lecture_completions" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can insert own profile" ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() = "id"));



CREATE POLICY "Users can post in global chat" ON "public"."chat_messages" FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles"
  WHERE ("profiles"."id" = "chat_messages"."user_id"))) AND (EXISTS ( SELECT 1
   FROM "public"."chat_rooms"
  WHERE (("chat_rooms"."id" = "chat_messages"."room_id") AND ("chat_rooms"."type" = 'global'::"text"))))));



CREATE POLICY "Users can read own profile" ON "public"."profiles" FOR SELECT USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can update own profile" ON "public"."profiles" FOR UPDATE USING (("auth"."uid"() = "id"));



CREATE POLICY "Users can update their own answers" ON "public"."user_answers" FOR UPDATE TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."quiz_attempts"
  WHERE (("quiz_attempts"."id" = "user_answers"."attempt_id") AND ("quiz_attempts"."user_id" = "auth"."uid"()))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."quiz_attempts"
  WHERE (("quiz_attempts"."id" = "user_answers"."attempt_id") AND ("quiz_attempts"."user_id" = "auth"."uid"())))));



CREATE POLICY "Users can view own completions" ON "public"."lecture_completions" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view own enrollments" ON "public"."enrollments" FOR SELECT USING (("auth"."uid"() = "user_id"));



CREATE POLICY "Users can view own profile" ON "public"."profiles" FOR SELECT USING (("auth"."uid"() = "id"));



ALTER TABLE "public"."chat_messages" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chat_rooms" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lessons" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."live_session_courses" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."live_sessions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."modules" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."question_analytics" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."user_answers" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."chat_messages";



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

























































































































































GRANT ALL ON FUNCTION "public"."calculate_quiz_accuracy"() TO "anon";
GRANT ALL ON FUNCTION "public"."calculate_quiz_accuracy"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."calculate_quiz_accuracy"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_role"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_role"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_role"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_course_chat_room"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_course_chat_room"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_course_chat_room"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "service_role";



GRANT ALL ON FUNCTION "public"."merge_user_accounts"("phone_number_input" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."merge_user_accounts"("phone_number_input" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."merge_user_accounts"("phone_number_input" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."set_attempt_number"() TO "anon";
GRANT ALL ON FUNCTION "public"."set_attempt_number"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."set_attempt_number"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";


















GRANT ALL ON TABLE "public"."backup_chat_messages_20251206" TO "anon";
GRANT ALL ON TABLE "public"."backup_chat_messages_20251206" TO "authenticated";
GRANT ALL ON TABLE "public"."backup_chat_messages_20251206" TO "service_role";



GRANT ALL ON TABLE "public"."backup_lecture_completions_20251206" TO "anon";
GRANT ALL ON TABLE "public"."backup_lecture_completions_20251206" TO "authenticated";
GRANT ALL ON TABLE "public"."backup_lecture_completions_20251206" TO "service_role";



GRANT ALL ON TABLE "public"."backup_question_analytics_20251206" TO "anon";
GRANT ALL ON TABLE "public"."backup_question_analytics_20251206" TO "authenticated";
GRANT ALL ON TABLE "public"."backup_question_analytics_20251206" TO "service_role";



GRANT ALL ON TABLE "public"."backup_quiz_attempts_20251206" TO "anon";
GRANT ALL ON TABLE "public"."backup_quiz_attempts_20251206" TO "authenticated";
GRANT ALL ON TABLE "public"."backup_quiz_attempts_20251206" TO "service_role";



GRANT ALL ON TABLE "public"."backup_user_answers_20251206" TO "anon";
GRANT ALL ON TABLE "public"."backup_user_answers_20251206" TO "authenticated";
GRANT ALL ON TABLE "public"."backup_user_answers_20251206" TO "service_role";



GRANT ALL ON TABLE "public"."backup_users_20251206" TO "anon";
GRANT ALL ON TABLE "public"."backup_users_20251206" TO "authenticated";
GRANT ALL ON TABLE "public"."backup_users_20251206" TO "service_role";



GRANT ALL ON TABLE "public"."chat_messages" TO "anon";
GRANT ALL ON TABLE "public"."chat_messages" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_messages" TO "service_role";



GRANT ALL ON TABLE "public"."chat_rooms" TO "anon";
GRANT ALL ON TABLE "public"."chat_rooms" TO "authenticated";
GRANT ALL ON TABLE "public"."chat_rooms" TO "service_role";



GRANT ALL ON TABLE "public"."course_materials" TO "anon";
GRANT ALL ON TABLE "public"."course_materials" TO "authenticated";
GRANT ALL ON TABLE "public"."course_materials" TO "service_role";



GRANT ALL ON TABLE "public"."courses" TO "anon";
GRANT ALL ON TABLE "public"."courses" TO "authenticated";
GRANT ALL ON TABLE "public"."courses" TO "service_role";



GRANT ALL ON TABLE "public"."enrollments" TO "anon";
GRANT ALL ON TABLE "public"."enrollments" TO "authenticated";
GRANT ALL ON TABLE "public"."enrollments" TO "service_role";



GRANT ALL ON TABLE "public"."lecture_completions" TO "anon";
GRANT ALL ON TABLE "public"."lecture_completions" TO "authenticated";
GRANT ALL ON TABLE "public"."lecture_completions" TO "service_role";



GRANT ALL ON TABLE "public"."lectures" TO "anon";
GRANT ALL ON TABLE "public"."lectures" TO "authenticated";
GRANT ALL ON TABLE "public"."lectures" TO "service_role";



GRANT ALL ON TABLE "public"."lesson_contents" TO "anon";
GRANT ALL ON TABLE "public"."lesson_contents" TO "authenticated";
GRANT ALL ON TABLE "public"."lesson_contents" TO "service_role";



GRANT ALL ON TABLE "public"."lessons" TO "anon";
GRANT ALL ON TABLE "public"."lessons" TO "authenticated";
GRANT ALL ON TABLE "public"."lessons" TO "service_role";



GRANT ALL ON TABLE "public"."live_classes" TO "anon";
GRANT ALL ON TABLE "public"."live_classes" TO "authenticated";
GRANT ALL ON TABLE "public"."live_classes" TO "service_role";



GRANT ALL ON TABLE "public"."live_session_courses" TO "anon";
GRANT ALL ON TABLE "public"."live_session_courses" TO "authenticated";
GRANT ALL ON TABLE "public"."live_session_courses" TO "service_role";



GRANT ALL ON TABLE "public"."live_sessions" TO "anon";
GRANT ALL ON TABLE "public"."live_sessions" TO "authenticated";
GRANT ALL ON TABLE "public"."live_sessions" TO "service_role";



GRANT ALL ON TABLE "public"."migration_metadata" TO "anon";
GRANT ALL ON TABLE "public"."migration_metadata" TO "authenticated";
GRANT ALL ON TABLE "public"."migration_metadata" TO "service_role";



GRANT ALL ON TABLE "public"."modules" TO "anon";
GRANT ALL ON TABLE "public"."modules" TO "authenticated";
GRANT ALL ON TABLE "public"."modules" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON TABLE "public"."question_analytics" TO "anon";
GRANT ALL ON TABLE "public"."question_analytics" TO "authenticated";
GRANT ALL ON TABLE "public"."question_analytics" TO "service_role";



GRANT ALL ON TABLE "public"."questions" TO "anon";
GRANT ALL ON TABLE "public"."questions" TO "authenticated";
GRANT ALL ON TABLE "public"."questions" TO "service_role";



GRANT ALL ON TABLE "public"."quiz_attempts" TO "anon";
GRANT ALL ON TABLE "public"."quiz_attempts" TO "authenticated";
GRANT ALL ON TABLE "public"."quiz_attempts" TO "service_role";



GRANT ALL ON TABLE "public"."quiz_leaderboard" TO "anon";
GRANT ALL ON TABLE "public"."quiz_leaderboard" TO "authenticated";
GRANT ALL ON TABLE "public"."quiz_leaderboard" TO "service_role";



GRANT ALL ON TABLE "public"."quiz_statistics" TO "anon";
GRANT ALL ON TABLE "public"."quiz_statistics" TO "authenticated";
GRANT ALL ON TABLE "public"."quiz_statistics" TO "service_role";



GRANT ALL ON TABLE "public"."quizzes" TO "anon";
GRANT ALL ON TABLE "public"."quizzes" TO "authenticated";
GRANT ALL ON TABLE "public"."quizzes" TO "service_role";



GRANT ALL ON TABLE "public"."user_answers" TO "anon";
GRANT ALL ON TABLE "public"."user_answers" TO "authenticated";
GRANT ALL ON TABLE "public"."user_answers" TO "service_role";



GRANT ALL ON SEQUENCE "public"."user_answers_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."user_answers_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."user_answers_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."user_best_attempts" TO "anon";
GRANT ALL ON TABLE "public"."user_best_attempts" TO "authenticated";
GRANT ALL ON TABLE "public"."user_best_attempts" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































