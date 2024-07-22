import 'package:bsh_app/screen/create_screen.dart';
import 'package:bsh_app/screen/first_screen.dart';
import 'package:bsh_app/screen/main_screen.dart';
import 'package:bsh_app/screen/rank_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 76, 186, 87)),
        useMaterial3: true,
      ),
      initialRoute: '/first',
      routes: {
        '/first' : (context) => const FirstScreen(),
        '/rank' : (context) => const RankScreen(),
        '/create' : (context) => const CreateScreen(),
        '/main' : (context) => const MainScreen(),
      },
    );
  }
}