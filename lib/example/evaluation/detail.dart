import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Dio dio = Dio();
  Map<String, dynamic> book = {};
  List<Map<String, dynamic>> reviews = [];
  int? bookId;

  TextEditingController reviewController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bookId = ModalRoute.of(context)!.settings.arguments as int;
    bookFindById(bookId);
    fetchReviews(bookId);
  }

  void bookFindById(int? id) async {
    try {
      final response = await dio.get("http://192.168.40.37:8080/book/view?id=$id");
      setState(() {
        book = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  void fetchReviews(int? id) async {
    try {
      final response = await dio.get("http://192.168.40.37:8080/review?id=$id");
      setState(() {
        reviews = List<Map<String, dynamic>>.from(response.data);
      });
    } catch (e) {
      print(e);
    }
  }

  void submitReview() async {
    try {
      final sendData = {
        "reviews": reviewController.text,
        "rpw": pwController.text,
        "id": bookId
      };
      final response = await dio.post("http://192.168.40.37:8080/review", data: sendData);
      reviewController.clear();
      pwController.clear();
      fetchReviews(bookId); // 등록 후 새로고침
    } catch (e) {
      print(e);
    }
  }

  void deleteReview(int rid) async {
    String rpw = "";
    await showDialog(
      context: context,
      builder: (context) {
        TextEditingController pwInput = TextEditingController();
        return AlertDialog(
          title: Text("리뷰 삭제"),
          content: TextField(
            controller: pwInput,
            obscureText: true,
            decoration: InputDecoration(labelText: "비밀번호 입력"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                rpw = pwInput.text;
                Navigator.pop(context);
              },
              child: Text("확인"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("취소"),
            ),
          ],
        );
      },
    );

    if (rpw.isNotEmpty) {
      try {
        final response = await dio.delete(
          "http://192.168.40.37:8080/review",
          queryParameters: {"rid": rid, "rpw": rpw},
        );
        if (response.data == true) {
          fetchReviews(bookId);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("비밀번호가 일치하지 않습니다.")),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상세 화면")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("제목 : ${book['title'] ?? ''}", style: TextStyle(fontSize: 25)),
            SizedBox(height: 8),
            Text("저자 : ${book['writer'] ?? ''}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text("소개 : ${book['context'] ?? ''}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 8),
            Text("도서 등록일 : ${book['createAt'] ?? ''}", style: TextStyle(fontSize: 15)),
            Divider(height: 30),

            // 리뷰 작성 영역
            Text("리뷰 작성", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: reviewController,
              decoration: InputDecoration(labelText: "리뷰"),
            ),
            TextField(
              controller: pwController,
              obscureText: true,
              decoration: InputDecoration(labelText: "비밀번호"),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: submitReview, child: Text("리뷰 등록")),

            Divider(height: 30),
            Text("리뷰 목록", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ...reviews.map((r) => ListTile(
              title: Text(r['reviews']),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteReview(r['rid']),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
