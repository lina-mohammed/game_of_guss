import 'package:flutter/material.dart';
import 'pages/splash_page.dart'; // ✅ استدعاء صفحة الـ Splash

void main() {
  runApp(const GuessGameApp());
}

class GuessGameApp extends StatelessWidget {
  const GuessGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لعبة تخمين الرقم 🎯',
     
      home: const SplashPage(), // ✅ هنا الصفحة التي تظهر أولاً
    );
  }
}
