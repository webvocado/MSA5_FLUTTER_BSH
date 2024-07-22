import 'package:bsh_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nicknameController = TextEditingController();
  List<String?> _validNicknames = []; // 유효한 닉네임 리스트

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<bool> _fetchUsers() async {
    try {
      var users = await getUserAll();
      setState(() {
        _validNicknames = users.map((user) => user.nickname).toList();
      });
      return true;
    } catch (e) {
      print('Error fetching users: $e');
      return false; 
    }
  }

  void _startGame() {
    String nickname = _nicknameController.text;
    if (_validNicknames.contains(nickname)) {
      Navigator.pushNamed(context, "/main", arguments: nickname);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('유효하지 않은 닉네임입니다.')),
      );
    }
  }


  // 회원 전체 조회
  Future<List<User>> getUserAll() async {
    var url = "http://10.0.2.2:8080/user";
    try {
      var response = await http.get(Uri.parse(url));
      // UTF-8 디코딩
      var utf8Decoded = utf8.decode(response.bodyBytes);
      // JSON 디코딩
      var usersJson = jsonDecode(utf8Decoded) as List;
      return usersJson.map((userJson) => User(
        nickname: userJson['nickname'],
        userNo: userJson['userNo'],
      )).toList();
    } catch (e) {
      print(e);
      throw Exception('Failed to load users');
    }
  }

  // 회원 조회
  // Future<List<User>> getUser() async {
  //   String nickname = _nicknameController.text;
  //   var url = "http://10.0.2.2:8080/user/$nickname";
  //   try {
  //     var response = await http.get(Uri.parse(url));
  //     // UTF-8 디코딩
  //     var utf8Decoded = utf8.decode(response.bodyBytes);
  //     // JSON 디코딩
  //     var usersJson = jsonDecode(utf8Decoded) as List;
  //     return usersJson.map((userJson) => User(
  //       nickname: userJson['nickname'],
  //       userNo: userJson['userNo'],
  //     )).toList();
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Failed to load users');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rock paper scissors"),
      ),
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Image.asset(
              'image/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임 입력',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _startGame,
              child: const Text("게임 시작"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 76, 186, 87),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("닉네임이 없으신가요? "),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/create");
              },
              child: const Text(
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
