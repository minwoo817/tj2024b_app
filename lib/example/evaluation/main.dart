
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/evaluation/detail.dart';
import 'package:tj2024b_app/example/evaluation/home.dart';
import 'package:tj2024b_app/example/evaluation/update.dart';
import 'package:tj2024b_app/example/evaluation/write.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/" , // 앱이 실행 했을때 초기 경로 설정
      routes: {
         "/" : (context) => Home(),
         "/write" : (context) => Write(),
         "/detail" : (context) => Detail(),
         "/update" : (context) => Update(),
      },
    );
  }
}