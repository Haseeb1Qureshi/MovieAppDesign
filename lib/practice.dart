import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'User.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyScreen(),
    );
  }
}
class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);
  @override
  State<MyScreen> createState() => _MyScreenState();
}
class _MyScreenState extends State<MyScreen> {
  @override

  List<User> userList = [];
  Future<List<User>> getUserApi ()async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var mydata = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in mydata){
        userList.add(User.fromJson(i));
      }
      return userList;
    }
    return userList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: "AppBar".text.bold.black.make(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<User>> snapshot) {
                  if(snapshot.hasError){
                    return Center(child: CircularProgressIndicator());
                  }
                  else if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  ResuableRow(title: '1. Name', value: snapshot.data![index].name.toString()),
                                  ResuableRow(title: '2. Username', value: snapshot.data![index].username.toString()),
                                  ResuableRow(title: '3. Email', value: snapshot.data![index].email.toString()),
                                  ResuableRow(title: '4. Phone', value: snapshot.data![index].phone.toString()),
                                  ResuableRow(title: '5. Company', value: snapshot.data![index].company.toString()),
                                ],
                              ),
                            ),
                          );
                        },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            CircularProgressIndicator(),
                          ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              "Loading...".text.make(),
                              FaIcon(FontAwesomeIcons.faceSmile),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
            ),
          ),
        ],
      ),
    );
  }
}
class ResuableRow extends StatelessWidget {
  String title, value;
  ResuableRow({required this.title,required this.value, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
        Text(value),
        ],
      ),
    );
  }
}


