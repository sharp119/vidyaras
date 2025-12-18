import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../features/auth/2_application/providers/auth_providers.dart';
import '../../../features/home/2_application/notifiers/home_notifier.dart';
import '../components/buttons/primary_button.dart';
import '../components/inputs/text_input_field.dart';

/// Edit Profile Screen
/// Allows users to edit their name, bio, and avatar
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _imagePicker = ImagePicker();

  bool _isLoading = false;
  bool _isInitialized = false;
  bool _isUploadingAvatar = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _initializeForm();
      _isInitialized = true;
    }
  }

  void _initializeForm() {
    final currentUserAsync = ref.read(currentUserProvider);
    currentUserAsync.whenData((user) {
      if (user != null) {
        _nameController.text = user.name ?? '';
        _bioController.text = user.bio ?? '';
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _handleAvatarUpload() async {
    try {
      // Show bottom sheet with options
      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );

      if (source == null) return;

      setState(() => _isUploadingAvatar = true);

      // Pick image
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) {
        setState(() => _isUploadingAvatar = false);
        return;
      }

      // Upload to Supabase Storage and update profile
      final profileDataSource = ref.read(profileDataSourceProvider);
      await profileDataSource.uploadAvatar(File(image.path));

      // Refresh current user data
      ref.invalidate(currentUserProvider);
      ref.invalidate(homeNotifierProvider);

      if (mounted) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Avatar updated successfully'),
            backgroundColor: colorScheme.tertiary,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload avatar: ${e.toString()}'),
            backgroundColor: colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploadingAvatar = false);
      }
    }
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final profileDataSource = ref.read(profileDataSourceProvider);

      await profileDataSource.updateProfileViaAPI(
        name: _nameController.text.trim(),
        fullName: _nameController.text.trim(),
        bio: _bioController.text.trim().isEmpty
            ? null
            : _bioController.text.trim(),
      );

      // Refresh current user data
      ref.invalidate(currentUserProvider);
      ref.invalidate(homeNotifierProvider);

      if (mounted) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile updated successfully'),
            backgroundColor: colorScheme.tertiary,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        final colorScheme = Theme.of(context).colorScheme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: ${e.toString()}'),
            backgroundColor: colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('Edit Profile', style: theme.textTheme.headlineMedium),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Avatar Section (Coming Soon)
            Center(
              child: Stack(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final currentUserAsync = ref.watch(currentUserProvider);
                      return currentUserAsync.when(
                        data: (user) {
                          return CircleAvatar(
                            radius: 60,
                            backgroundImage: user?.avatarUrl != null
                                ? NetworkImage(user!.avatarUrl!)
                                : null,
                            child: user?.avatarUrl == null
                                ? const Icon(Icons.person, size: 60)
                                : null,
                          );
                        },
                        loading: () => const CircleAvatar(
                          radius: 60,
                          child: CircularProgressIndicator(),
                        ),
                        error: (_, __) => const CircleAvatar(
                          radius: 60,
                          child: Icon(Icons.person, size: 60),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isUploadingAvatar
                            ? colorScheme.outline
                            : colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surfaceContainerLow,
                          width: 3,
                        ),
                      ),
                      child: _isUploadingAvatar
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: colorScheme.onPrimary,
                                size: 20,
                              ),
                              onPressed: _handleAvatarUpload,
                            ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Name Field
            TextInputField(
              controller: _nameController,
              label: 'Full Name',
              hintText: 'Enter your full name',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                if (value.trim().length < 2) {
                  return 'Name must be at least 2 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Bio Field
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: 'Bio',
                hintText: 'Tell us about yourself...',
                counterText: '',
              ),
              validator: (value) {
                if (value != null && value.length > 500) {
                  return 'Bio must not exceed 500 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 8),
            Text(
              '${_bioController.text.length}/500 characters',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.right,
            ),

            const SizedBox(height: 32),

            // Save Button
            PrimaryButton(
              label: _isLoading ? 'Saving...' : 'Save Changes',
              onPressed: _isLoading ? null : _handleSave,
            ),
          ],
        ),
      ),
    );
  }
}
