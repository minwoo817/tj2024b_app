
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget{
  @override
  _DetailState createState() {
    return _DetailState();
  }
}

class _DetailState extends State<Detail>{
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of(context)!.settings.arguments as int;
    fixFindById(id);
  }

  Dio dio = Dio();
  Map<String, dynamic> fix = {};
  void fixFindById(id) async{
    try{
      final response = await dio.get("http://192.168.40.37:8080/day04/task/view?id=$id");
      final data = response.data;
      setState(() {
        fix = data;
      });
      print(fix);
    }catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("상세 화면"),),
      body: Center(
        child: Column(
          children: [
            Text("이름 : ${fix['name']}", style: TextStyle(fontSize: 25),),
            SizedBox(height: 8,),
            Text("설명 : ${fix['description']}", style: TextStyle(fontSize: 20),),
            SizedBox(height: 8,),
            Text("수량 : ${fix['quantity']}", style: TextStyle(fontSize: 15),),
            SizedBox(height: 8,),
            Text("비품 등록일 : ${fix['createAt']}", style: TextStyle(fontSize: 15),),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}