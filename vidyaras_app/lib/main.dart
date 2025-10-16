import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'src/shared/presentation/theme/app_theme.dart';
import 'src/shared/presentation/routing/app_router.dart';
import 'src/shared/presentation/theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure system UI overlay (status bar and navigation bar)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // Status bar color (Android) - using app's primary color
      statusBarColor: AppColors.primary,
      // Status bar icon brightness (Android)
      statusBarIconBrightness: Brightness.light,
      // Status bar brightness (iOS)
      statusBarBrightness: Brightness.dark,
      // Navigation bar color (Android)
      systemNavigationBarColor: AppColors.background,
      // Navigation bar icon brightness (Android)
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
    const ProviderScope(
      child: VidyaRasApp(),
    ),
  );
}

class VidyaRasApp extends StatelessWidget {
  const VidyaRasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'VidyaRas - JanJeevan',
    );
  }
}
