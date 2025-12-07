import 'package:flutter/material.dart';
//import 'game_page.dart';
import 'home_page.dart';

class LosePage extends StatelessWidget {
  final int correctNumber;

  const LosePage({super.key, required this.correctNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '😢 خسرت!',
              style: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 20),
            Text('الرقم الصحيح كان: $correctNumber',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
              child: const Text('جرب مرة أخرى'),
            ),
          ],
        ),
      ),
    );
  }
}
