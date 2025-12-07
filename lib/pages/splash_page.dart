import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // بعد 3 ثواني، ينتقل تلقائيًا للصفحة الرئيسية
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return; // ✅ تحقق أن الصفحة لا تزال موجودة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2a79cb), // الخلفية بلون موحد
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الصورة الاحترافية (مربعة ومكبرة)
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/animations/another_animation.json.png'),
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(20), // شكل احترافي
              ),
            ),

            const SizedBox(height: 40),

            // نص احتفالي (اختياري يمكن حذفه)
            const Text(
              '🎉 استعد للتحدي! 🎯',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
