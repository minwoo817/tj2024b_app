
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget{
  @override
  _UpdateState createState() {
    return _UpdateState();
  }
}
class _UpdateState extends State<Update>{
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    int id = ModalRoute.of(context)!.settings.arguments as int;
    print(id);
    fixFindById(id);
  }
  Dio dio = Dio();
  Map<String, dynamic> fix = {};
  void fixFindById(int id) async {
    try{
      final response = await dio.get("http://192.168.40.37:8080/day04/task/view?id=$id");
      final data = response.data;
      setState(() {
        fix = data;
        nameController.text = data['name'];
        descriptionController.text = data['description'];

      });
      print(fix);
    }catch(e){print(e);}
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  void fixUpdate() async{
    try{
      final sendData = {
        "id" : fix['id'],
        "name" : nameController.text,
        "description" : descriptionController.text,
        "quantity" : quantityController.text ,
      };
      final response = await dio.put("http://192.168.40.37:8080/day04/task" , data: sendData);
      final data = response.data;
      if(data != null){
        Navigator.pushNamed(context, "/");
      }
    }catch(e){print(e);}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("수정 화면"),),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "이름"),
              maxLength: 30,
            ),
            SizedBox(height: 20,),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "설명"),
              maxLines: 3,
            ),
            SizedBox(height: 20,),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: "수량"),
              maxLength: 30,
            ),
            SizedBox(height: 20,),
            OutlinedButton(onPressed: fixUpdate, child: Text("수정하기"))
          ],
        ),
      ),
    );
  }

}