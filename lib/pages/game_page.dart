import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'win_page.dart';
import 'lose_page.dart';

class GamePage extends StatefulWidget {
  final int maxRange;
  final int maxAttempts;
  final int baseScore;
  final Color levelColor;

  const GamePage({
    super.key,
    required this.maxRange,
    required this.maxAttempts,
    required this.baseScore,
    required this.levelColor,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final TextEditingController _controller = TextEditingController();
  late int _target;
  int _attempts = 0;
  int _score = 0;
  String _message = '';

  final AudioPlayer _sfxPlayer = AudioPlayer(); // لتشغيل أصوات التأثير
  final AudioPlayer _bgPlayer = AudioPlayer(); // الموسيقى الخلفية
  bool isSoundOn = true; // للتحكم بالأصوات
  bool isMusicOn = true; // للتحكم بالموسيقى الخلفية

  @override
  void initState() {
    super.initState();
    _target = Random().nextInt(widget.maxRange) + 1;

    // تشغيل الموسيقى الخلفية عند بدء اللعبة
    _startBackgroundMusic();
  }

  void _startBackgroundMusic() async {
    await _bgPlayer.setReleaseMode(ReleaseMode.loop);
    if (isMusicOn) {
      await _bgPlayer.play(AssetSource('sounds/background_music.mp3'));
    }
  }

  void _toggleMusic() {
    setState(() {
      isMusicOn = !isMusicOn;
      if (isMusicOn) {
        _bgPlayer.resume();
      } else {
        _bgPlayer.pause();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _sfxPlayer.dispose();
    _bgPlayer.dispose();
    super.dispose();
  }

  Color getBackgroundColor(Color levelColor) {
    if (levelColor == Colors.greenAccent) return Colors.green[50]!;
    if (levelColor == Colors.yellowAccent) return Colors.yellow[50]!;
    if (levelColor == Colors.redAccent) return Colors.red[50]!;
    return Colors.white;
  }

  void playSound(String path) {
    if (isSoundOn) {
      _sfxPlayer.play(AssetSource(path));
    }
  }

  void checkGuess() {
    int guess = int.tryParse(_controller.text) ?? 0;
    _controller.clear();
    setState(() {
      _attempts++;
    });

    if (guess == _target) {
      playSound('sounds/correct-answer.mp3');
      _score = widget.baseScore - (_attempts - 1);
      if (_score < 0) _score = 0;

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WinPage(
              score: _score,
              attempts: _attempts,
            ),
          ),
        );
      }
    } else {
      playSound('sounds/wrong-answer.mp3');
      setState(() {
        _message = guess < _target
            ? "الرقم صغير جدًا! 📉"
            : "الرقم كبير جدًا! 📈";
      });

      if (_attempts >= widget.maxAttempts) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LosePage(
                correctNumber: _target,
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(widget.levelColor),
      appBar: AppBar(
        title: const Text('لعبة تخمين الرقم'),
        backgroundColor: widget.levelColor,
        actions: [
          // زر الأصوات
        
          // زر الموسيقى الخلفية
          IconButton(
            icon: Icon(isMusicOn ? Icons.music_note : Icons.music_off),
            onPressed: _toggleMusic,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'أدخل رقم بين 1 و ${widget.maxRange}:',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'رقم تخمينك',
                ),
                onSubmitted: (_) => checkGuess(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: checkGuess,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.levelColor,
                ),
                child: const Text('تحقق'),
              ),
              const SizedBox(height: 20),
              Text(
                _message,
                style: const TextStyle(fontSize: 18, color: Colors.purple),
              ),
              const SizedBox(height: 10),
              Text('المحاولات: $_attempts / ${widget.maxAttempts}'),
            ],
          ),
        ),
      ),
    );
  }
}
