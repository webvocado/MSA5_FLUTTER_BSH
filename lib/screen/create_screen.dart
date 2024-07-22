import 'package:bsh_app/models/record.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController = TextEditingController();

  // 닉네임 등록 요청
  Future<bool> insert() async {
    var url = "http://10.0.2.2:8080/user";
    try {
      // post( url, headers, body )
      var response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type" : "application/json"
        }, 
        body: jsonEncode({
          'nickname': _nicknameController.text,
        }
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('닉네임 생성 성공!!'),
          backgroundColor: Colors.blueAccent,
        ),
      );
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, "/first");
      return true;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('닉네임 생성 실패!'),
            backgroundColor: Colors.redAccent,
          ),
      );
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Nickname"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '닉네임 입력',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: insert,
                child: const Text("닉네임 생성"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 186, 87),
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
