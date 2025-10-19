-- =====================================================
-- VidyaRas Supabase Setup - Complete Reset & Create
-- =====================================================
-- Run this in Supabase SQL Editor
-- (Dashboard → SQL Editor → New Query → Paste & Run)
-- =====================================================

-- STEP 1: DROP EVERYTHING (Clean Slate)
-- =====================================================

-- Drop existing tables
DROP TABLE IF EXISTS users CASCADE;

-- Drop existing policies (if any)
DROP POLICY IF EXISTS "Public Access" ON users;

-- =====================================================
-- STEP 2: CREATE USERS TABLE
-- =====================================================

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    phone_number TEXT UNIQUE NOT NULL,
    name TEXT,
    email TEXT,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- Create index for faster phone number lookups
CREATE INDEX idx_users_phone_number ON users(phone_number);

-- =====================================================
-- STEP 3: DISABLE ROW LEVEL SECURITY (Public Access)
-- =====================================================

-- Disable RLS to make table publicly accessible
ALTER TABLE users DISABLE ROW LEVEL SECURITY;

-- =====================================================
-- STEP 4: INSERT TEST DATA (Optional)
-- =====================================================

-- Insert a test user for testing existing user flow
INSERT INTO users (phone_number, name, email)
VALUES ('+911234567890', 'Test User', 'test@example.com');

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Check if table was created successfully
SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name = 'users';

-- Check RLS status (should show: false)
SELECT tablename, rowsecurity
FROM pg_tables
WHERE schemaname = 'public'
AND tablename = 'users';

-- View all users (should show the test user)
SELECT * FROM users;

-- =====================================================
-- DONE!
-- =====================================================
-- Your table is ready to use
-- No authentication required
-- App can now insert/update/select freely
-- =====================================================
