import 'package:flutter/material.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'screens/auth/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sub800',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppTheme.appTheme,
        scaffoldBackgroundColor: AppTheme.appTheme,
      ),
      home: const LoadingScreen(),
      routes: Routes.getRoutes(),
    );
  }
}