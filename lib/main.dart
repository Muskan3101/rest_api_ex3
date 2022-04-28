import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:rest_api_ex3/model_class.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Future Builder"),
      ),
      body: FutureBuilder<List<Student>>(
        future: getListOfStudents(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );

          }return ListView(
            padding: EdgeInsets.all(20.0),

            children: snapshot.data!.map((value) =>

            ListTile(

              horizontalTitleGap: 10,
              minVerticalPadding:10.0,
              contentPadding: EdgeInsets.symmetric(vertical: 16.0),

              onTap: (){
                Fluttertoast.showToast(
                    msg: value.name.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 12.0
                );
              },
            title: Text(value.name + "    " +value.id,style: TextStyle(fontSize: 20),),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)
                  )),
              selectedTileColor: Colors.orange[100],
              selected: true,
            )).toList(),
          );
        },
      ),
    );
  }
  Future<List<Student>> getListOfStudents() async {
    var uri = Uri.parse("https://applore-123-default-rtdb.firebaseio.com/student.json");
    var response = await http.get(uri);
    // print(response.body);
    // print(response.statusCode);
    if(response.statusCode == 200){ // 200 error comes when the methods works successfully.
      //print(response.body);
      final data = json.decode(response.body);
      //print(data);
      List<Student> studentList = data.map<Student>((map){
        return Student.fromJson(map);
      }).toList();

      return studentList;
    }
    else{
      throw Exception("Error Found");
    }
  }
}


