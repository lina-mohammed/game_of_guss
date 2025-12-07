import 'package:flutter/material.dart';
import 'game_page.dart';

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: const Text('اختر المستوى 🎮'),
        centerTitle: true,
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LevelButton(
              level: 'سهل',
              maxRange: 10,
              maxAttempts: 10,
              baseScore: 10,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 16),
            LevelButton(
              level: 'متوسط',
              maxRange: 50,
              maxAttempts: 7,
              baseScore: 20,
              color: Colors.yellowAccent,
            ),
            const SizedBox(height: 16),
            LevelButton(
              level: 'صعب',
              maxRange: 100,
              maxAttempts: 5,
              baseScore: 30,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class LevelButton extends StatelessWidget {
  final String level;
  final int maxRange;
  final int maxAttempts;
  final int baseScore;
  final Color color;

  const LevelButton({
    super.key,
    required this.level,
    required this.maxRange,
    required this.maxAttempts,
    required this.baseScore,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GamePage(
                maxRange: maxRange,
                maxAttempts: maxAttempts,
                baseScore: baseScore,
                levelColor: color,
              ),
            ),
          );
        },
        child: Text(level, style: const TextStyle(fontSize: 22, color: Colors.black)),
      ),
    );
  }
}
