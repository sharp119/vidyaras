import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Import Supabase
import 'src/shared/presentation/theme/app_theme.dart';
import 'src/shared/presentation/routing/app_router.dart';
import 'src/shared/presentation/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase with your provided credentials
  await Supabase.initialize(
    url: 'https://cyenulvcedlzccorgkkx.supabase.co',
    anonKey: 'sb_publishable_1bNMSWq_hWRg00wXfxkxNA_sJ65jFux',
  );

  // Configure system UI overlay (status bar and navigation bar)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.primary,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Hive for local storage
  await Hive.initFlutter();

  runApp(
    // Wrap app with ProviderScope for Riverpod state management
    const ProviderScope(child: VidyaRasApp()),
  );
}

// Helper to get the Supabase client instance
final supabase = Supabase.instance.client;

class VidyaRasApp extends StatelessWidget {
  const VidyaRasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'VidyaRas',
    );
  }
}
