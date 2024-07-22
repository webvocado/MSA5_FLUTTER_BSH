import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nicknameController = TextEditingController();
  final _validNicknames = ['user1', 'user2', 'user3']; // 유효한 닉네임 리스트

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _startGame() {
    String nickname = _nicknameController.text;
    // if (_validNicknames.contains(nickname)) {
    //   Navigator.pushNamed(context, "/main");
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('유효하지 않은 닉네임입니다.')),
    //   );
    // }
    Navigator.pushNamed(context, "/main");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rock paper scissors"),
      ),
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Image.asset(
              'image/logo.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임 입력',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _startGame,
              child: Text("게임 시작"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 76, 186, 87),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("닉네임이 없으신가요? "),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/create");
              },
              child: Text(
                "닉네임 생성",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
