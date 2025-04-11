import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  Dio dio = Dio();
  List<dynamic> booklist = [];

  void bookFindAll() async {
    try {
      final response = await dio.get("http://192.168.40.37:8080/book");
      final data = response.data;
      setState(() {
        booklist = data;
      });
      print(booklist);
    } catch (e) {
      print(e);
    }
  }

  // 비밀번호 입력 후 삭제 시도
  void bookDelete(int id, String pw) async {
    try {
      final response = await dio.delete(
        "http://192.168.40.37:8080/book",
        queryParameters: {
          "id": id,
          "pw": pw,
        },
      );
      final data = response.data;
      if (data == true) {
        bookFindAll();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("삭제되었습니다.")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("비밀번호가 일치하지 않습니다.")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("삭제 중 오류가 발생했습니다.")));
    }
  }

  // 비밀번호 입력 다이얼로그
  void showDeleteDialog(int id) {
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                bookDelete(id, pw);
              },
              child: Text("삭제"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bookFindAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("메인 페이지 : 도서"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => {Navigator.pushNamed(context, "/write")},
              child: Text("도서 추가"),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView(
                children: booklist.map((book) {
                  return Card(
                    child: ListTile(
                      title: Text(book['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("도서 저자 : ${book['writer']}"),
                          Text("도서 소개: ${book['context']}"),
                          Text("등록일 : ${book['createAt']}"),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => {
                              Navigator.pushNamed(context, "/update", arguments: book['id'])
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => {
                              Navigator.pushNamed(context, "/detail", arguments: book['id'])
                            },
                            icon: Icon(Icons.info),
                          ),
                          IconButton(
                            onPressed: () => showDeleteDialog(book['id']),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
