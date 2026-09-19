import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home_page.dart';
import 'theme/app_colors.dart';

/// 轻启AI — 让工具更简单 · 让生活更轻松
/// 入口：配置全局视觉、状态栏、首页路由
class QingAiApp extends StatelessWidget {
  const QingAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '轻启AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          surface: AppColors.background,
        ),
        fontFamilyFallback: const ['PingFang SC', 'Noto Sans SC', 'Roboto'],
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

void main() => runApp(const QingAiApp());
