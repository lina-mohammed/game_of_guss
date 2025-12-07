import 'package:flutter/material.dart';
import 'level_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🎯 لعبة تخمين الرقم!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                 
                ),
              ),
              const SizedBox(height: 20),
              const Text('حاول تخمين الرقم السري 🤫'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LevelPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                 
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                child: const Text('ابدأ اللعبة', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
