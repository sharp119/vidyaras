-- Student Avatar Upload Policy
-- Allows students to upload their own avatar images to the avatars bucket

-- Add policy for students to upload their own avatars
-- The avatar filename should be prefixed with their user ID for security
CREATE POLICY "Students can upload own avatar"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
    bucket_id = 'avatars' AND
    (storage.foldername(name))[1] = auth.uid()::text
);

-- Add policy for students to update their own avatars
CREATE POLICY "Students can update own avatar"
ON storage.objects FOR UPDATE
TO authenticated
USING (
    bucket_id = 'avatars' AND
    (storage.foldername(name))[1] = auth.uid()::text
);

-- Add policy for students to delete their own avatars
CREATE POLICY "Students can delete own avatar"
ON storage.objects FOR DELETE
TO authenticated
USING (
    bucket_id = 'avatars' AND
    (storage.foldername(name))[1] = auth.uid()::text
);

-- Add comment to document the policy
COMMENT ON POLICY "Students can upload own avatar" ON storage.objects IS
'Allows authenticated users to upload avatar images with their user ID as the folder prefix';
