import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() {
    return _UpdateState();
  }
}

class _UpdateState extends State<Update> {
  Dio dio = Dio();
  Map<String, dynamic> book = {};



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of(context)!.settings.arguments as int;
    print(id);
    bookFindById(id);
  }

  void bookFindById(int id) async {
    try {
      final response = await dio.get("http://192.168.40.37:8080/book/view?id=$id");
      final data = response.data;
      setState(() {
        book = data;

      });
      print(book);
    } catch (e) {
      print(e);
    }
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController contextController = TextEditingController();
  void bookUpdate(String pw) async {
    final sendData = {
      "id": book['id'],
      "title": titleController.text,
      "writer": writerController.text,
      "context": contextController.text,
      "pw": pw,
    };
    print("보내는 데이터: $sendData");

    try {
      final response = await dio.put("http://192.168.40.37:8080/book", data: sendData);
      final data = response.data;
      print("서버 응답: $data");
      if (data != null) {
        Navigator.pushNamed(context, "/");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("비밀번호가 일치하지 않습니다.")));
      }
    } catch (e) {
      print("에러: $e");
    }
  }


  void showPasswordDialog() {
    String pw = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("비밀번호 확인"),
          content: TextField(
            obscureText: true,
            onChanged: (value) {
              pw = value;
            },
            decoration: InputDecoration(labelText: "비밀번호 입력"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                bookUpdate(pw);
              },
              child: Text("수정"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("수정 화면")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "제목"),
                maxLength: 30,
              ),
              SizedBox(height: 20),
              TextField(
                controller: writerController,
                decoration: InputDecoration(labelText: "저자"),
                maxLength: 30,
              ),
              SizedBox(height: 20),
              TextField(
                controller: contextController,
                decoration: InputDecoration(labelText: "소개"),
                maxLength: 300,
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: showPasswordDialog, // 👉 수정 버튼이 다이얼로그 띄우도록
                child: Text("수정하기"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
