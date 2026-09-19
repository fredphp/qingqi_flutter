import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'router.dart';

class QingqiApp extends StatelessWidget {
  const QingqiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '轻启AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      builder: (context, child) {
        return MediaQuery(
          // Lock text scale to 1.0 to keep the 1:1 pixel design intact.
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
