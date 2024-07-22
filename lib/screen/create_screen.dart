import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _createNickname() {
    String nickname = _nicknameController.text;
    if (nickname.isNotEmpty) {
      // 닉네임 생성 로직을 추가하세요. 예를 들어, 서버에 닉네임 저장 요청을 보낼 수 있습니다.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('닉네임 $nickname 생성되었습니다.')),
      );
      Navigator.pop(context); // 생성 후 이전 화면으로 이동
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('닉네임을 입력해주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Nickname"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임 입력',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createNickname,
                child: Text("닉네임 생성"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 76, 186, 87),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
