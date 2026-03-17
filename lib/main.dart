import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/main_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: const ProductivityApp(),
    ),
  );
}

class ProductivityApp extends StatelessWidget {
  const ProductivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sviroxk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9B59B6),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0D0D1A),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const MainScreen(),
    );
  }
}
