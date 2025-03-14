import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectiontrialsnew/Player/player_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ChangePassword(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.title});


  final String title;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController CurrentPasscontroller=TextEditingController();
  TextEditingController NewPasscontroller=TextEditingController();
  TextEditingController ConfirmPasscontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextFormField(controller: CurrentPasscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Current Password')),),
            SizedBox(height: 20),
            TextFormField(controller: NewPasscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('New Password')),),
            SizedBox(height: 20,),
            TextFormField(controller: ConfirmPasscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Confirm Password')),),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              _send_data1();
            }, child: Text('Submit'))
          ],
        ),
      ),

    );
  }


  void _send_data1() async{


    String current_pass=CurrentPasscontroller.text;
    String new_pass=NewPasscontroller.text;
    String confirm_pass=ConfirmPasscontroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/ply_change_password/');
    try {
      final response = await http.post(urls, body: {
        'current_pass':current_pass,
        'new_pass':new_pass,
        'confirm_pass':confirm_pass,
        'lid':lid,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Sign up successfull');
          Navigator.push(context , MaterialPageRoute(

            builder: (context) => PlayerHome(title: "Submit"),));
        }else {
          Fluttertoast.showToast(msg: 'Email Already exists');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }



}
