import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '가위바위보 게임',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> choices = ['가위', '바위', '보'];
  final Map<String, String> images = {
    '가위': 'image/scissors.png',
    '바위': 'image/rock.png',
    '보': 'image/paper.png'
  };
  String? userChoice;
  String? computerChoice;
  String? result;
  int winStreak = 0;

  int wins = 0;
  int draws = 0;
  int lose = 0;


  void playGame(String userChoice) {
    final Random random = Random();
    computerChoice = choices[random.nextInt(3)];

    if (userChoice == computerChoice) {
      result = '비겼습니다!';
      winStreak = 0;
      draws++;

    } else if (
      (userChoice == '가위' && computerChoice == '보') ||
      (userChoice == '바위' && computerChoice == '가위') ||
      (userChoice == '보' && computerChoice == '바위')
    ) {
      result = '이겼습니다!';
      winStreak++;
      wins++;
    } else {
      result = '졌습니다!';
      winStreak = 0;
      lose++;
    }

    setState(() {
      this.userChoice = userChoice;
      this.computerChoice = computerChoice;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('가위바위보 게임'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (winStreak > 0)
              Text(
                '$winStreak연승!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            const SizedBox(height: 10),
            const Text(
              '가위바위보를 선택하세요:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: choices.map((choice) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () => playGame(choice),
                    child: Text(choice),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            if (userChoice != null && computerChoice != null)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '당신의 선택:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Image.asset(images[userChoice!]!, width: 100, height: 100),
                        ],
                      ),
                      const SizedBox(width: 40),
                      Column(
                        children: [
                          const Text(
                            '컴퓨터의 선택:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Image.asset(images[computerChoice!]!, width: 100, height: 100),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result!,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (userChoice != null && computerChoice != null)
                const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () { Navigator.pushNamed(context, "/rank"); },
                    child: const Text('랭킹'),
                  ),
                  Text(
                    '$wins승 $draws무 $lose패',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
