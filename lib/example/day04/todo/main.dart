// main.dart : 앱 실행의 최초 파일
// 1. main 함수 이용한 앱 실행
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day04/todo/detail.dart';
import 'package:tj2024b_app/example/day04/todo/home.dart';
import 'package:tj2024b_app/example/day04/todo/update.dart';
import 'package:tj2024b_app/example/day04/todo/write.dart';
void main(){
  runApp( MyApp() ); // 라우터를 갖는 위젯이 최소 화면
}
// 2. 라우터를 갖는 클래스/위젯
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/" , // 앱이 실행 했을때 초기 경로 설정
      routes: {
        "/" : (context) => Home(), // 만약에 "/" 해당 경로를 호출하면 Home 위젯이 열린다.
        "/write" : (context) => Write(), // 추후에 위젯 만들고 주석 풀기 http://localhost:52803/#/write
        "/detail" : (context) => Detail(), // http://localhost:52803/#/detail
        "/update" : (context) => Update(), // http://localhost:52803/#/update
      },
    );
  }
}

// 안드로이드 : apk 라는 확장자 파일로 만들기
// 1. 터미널 창 열기 (현재 프로젝트명 오른쪽 클릭) -> open in -> terminal
// 2. flutter build apk --release --target=lib/example/day04/todo/main.dart --target-platform=android-arm64
// * -- flutter build apk --release --target=lib/example/day04/todo/main.dart 생략시 자동으로 lib에 가져온 main.dart 빌드

// 방법 2
// 상단메뉴 -> build -> flutter -> build apk

// -->

// IOS : ipa 라는 확장자 파일로 만들기
// 1. 터미널 창 열기
// 2. flutter build ios --release --target=lib/example/day04/todo/main.dart --target-platform=android-arm64

