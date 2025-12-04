-- Enable Supabase Realtime on chat_messages table
-- Run this in your Supabase SQL Editor

-- First, check if realtime is already enabled
-- If not, run these commands:

-- Enable realtime publication for chat_messages
ALTER PUBLICATION supabase_realtime ADD TABLE chat_messages;

-- Verify it's enabled
SELECT * FROM pg_publication_tables WHERE pubname = 'supabase_realtime';
