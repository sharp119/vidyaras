import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// API Client Provider
/// Provides a configured Dio instance for API calls
///
/// NOTE: Update the base URL based on environment:
/// - Development: http://localhost:3000 (or your Next.js dev server)
/// - Production: https://admin.vidyaras.com (or your production API URL)
final apiClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      // Production API URL
      // For local development, change to: http://localhost:3000
      baseUrl: 'https://vidyaras-admin.vercel.app',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptor to attach auth token to all requests
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get current session token from Supabase
        final session = Supabase.instance.client.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        // Log errors for debugging
        // TODO: Replace with proper logging solution (e.g., logger package)
        // print('API Error: ${error.response?.statusCode} - ${error.message}');
        return handler.next(error);
      },
    ),
  );

  return dio;
});
