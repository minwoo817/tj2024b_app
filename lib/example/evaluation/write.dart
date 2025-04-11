
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Write extends StatefulWidget{
  @override
  _WriteState createState() {
    return _WriteState();
  }
}

class _WriteState extends State<Write>{
  final TextEditingController titleController = TextEditingController();
  final TextEditingController writerController = TextEditingController();
  final TextEditingController contextController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  
  Dio dio = Dio();
  void bookSave() async{
    try{
      final sendData = {
        "title" : titleController.text,
        "writer" : writerController.text,
        "context" : contextController.text,
        "pw" : pwController.text
      };
      final response = await dio.post("http://192.168.40.37:8080/book", data: sendData);
      final data = response.data;
      if(data != null){
        Navigator.pushNamed(context, "/");
      }
    }catch(e){print(e);}
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("도서 추천 화면"),),
      body: Center(
        child: Column(
          children: [
            Text("도서 등록 하세요"),
            SizedBox(height: 30,),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "도서 제목"),
              maxLength: 30,
            ),
            SizedBox(height: 30,),
            TextField(
              controller: writerController,
              decoration: InputDecoration(labelText: "도서 저자"),
              maxLength: 30,
            ),
            SizedBox(height: 30,),
            TextField(
              controller: contextController,
              decoration: InputDecoration(labelText: "도서 소개"),
              maxLines: 3,
            ),
            SizedBox(height: 30,),
            TextField(
              controller: pwController,
              decoration: InputDecoration(labelText: "비밀번호"),
              maxLength: 30,
            ),
            SizedBox( height:  30 ,) ,
            OutlinedButton( onPressed: bookSave , child: Text("등록하기") )
          ],
        ),
      ),
    );
  }
}