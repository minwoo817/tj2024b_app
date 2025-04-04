// DART 언어는 단일 스레드 기반

// 1. Dio 객체 생성 , dart : 클래스명()
// 2. 파일 상단에 import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
final dio = Dio(); // final : 상수 키워드
void main(){ // main 함수가 스레드를 갖고 코드 시작점
  print("dart start");
  getHttp();
  postHttp();
}

// 3. (1) 비동기 통신
// dio.HTTP메소드명("URL")
void getHttp() async {
  try {
    final response = await dio.get("http://localhost:8080/day03/task/course");
    print(response.data);
  }catch(e){print(e);}
}
void postHttp() async {
  try {
    final sendData = {"cname": "수학"};
    final response = await dio.post(
        "http://localhost:8080/day03/task/course", data: sendData);
    print(response.data);
  }catch(e){print(e);}
}