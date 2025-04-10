
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{
  Dio dio = Dio();
  List<dynamic> fixlist = [];
  void fixFindAll() async{
    try{
      final response = await dio.get("http://192.168.40.37:8080/day04/task");
      final data = response.data;
      setState(() {
        fixlist = data;
      });
      print(fixlist);
    }catch(e){print(e);}
  }
  
  @override
  void initState(){
    super.initState();
    fixFindAll();
  }
  
  void fixDelete(int id) async{
    try{
      final response = await dio.delete('http://192.168.40.37:8080/day04/task?id=$id');
      final data = response.data;
      if(data == true){fixFindAll();}
    }catch(e){print(e);}
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("메인페이지 : 비품관리"),),
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: ()=>{Navigator.pushNamed(context, "/write")}, child: Text("비품 추가")),
            SizedBox(height: 30,),
            Expanded(
                child: ListView(
                  children: fixlist.map( (fix){
                    return Card(child: ListTile(
                      title: Text(fix['name']),
                      subtitle: Column(
                        children: [
                          Text("비품 설명 : ${fix['description']}"),
                          Text("비품 수량 : ${fix['quantity']}"),
                          Text("등록일 : ${fix['createAt']}")
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton( onPressed: ()=>{ Navigator.pushNamed(context , "/update" , arguments : fix['id'] ) }, icon: Icon(Icons.edit) ) ,
                          IconButton( onPressed: ()=>{ Navigator.pushNamed(context , "/detail" , arguments : fix['id'] ) }, icon: Icon(Icons.info) ) ,
                          IconButton( onPressed: ()=>{ fixDelete( fix['id'] ) } , icon: Icon( Icons.delete ) ),
                        ],
                      ),
                    ),
                    );
                    
                  } ).toList(), 
            )
            )
          ],
        ),
      ),
    );
  }
}