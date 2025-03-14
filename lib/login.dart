import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectiontrialsnew/Player/player_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Coach/add_tips.dart';
import 'Coach/coc_home.dart';
import 'Coach/signup.dart';
import 'Player/signup.dart';

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
      home: const myloginpage(title: 'Flutter Demo Home Page'),
    );
  }
}

class myloginpage extends StatefulWidget {
  const myloginpage({super.key, required this.title});


  final String title;

  @override
  State<myloginpage> createState() => _myloginpageState();
}

class _myloginpageState extends State<myloginpage> {

  TextEditingController usernamecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();


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

            TextFormField(
              controller: usernamecontroller,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Username')),),
            TextFormField(
              controller: passwordcontroller,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Password')),),
            ElevatedButton(onPressed: (){
              _send_data();

            },
                child: Text('Login')),
            TextButton( onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PlayerSignup(title: 'Sign up',)));
            },
              child : const Text('Player Signup'),
            ),

            TextButton( onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CoachSignup(title: 'Sign up',)));
            },
              child : const Text('Coach Signup'),
            ),
          ],
        ),
      ),

    );
  }
  void _send_data() async{


    String uname=usernamecontroller.text;
    String passw=passwordcontroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/ply_login/');
    try {
      final response = await http.post(urls, body: {
        'username': uname,
        'password': passw,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String lid = jsonDecode(response.body)['lid'];
          sh.setString("lid", lid);

          String type = jsonDecode(response.body)['type'];
          sh.setString("type", type);

          if (type == 'player') {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => PlayerHome(title: "Player Home"),));
          }
          if (type == 'coach') {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => CoachHomePage(title: "Coach Home"),));
          }
          else {
            Fluttertoast.showToast(msg: 'Not Found');
          }
        }
        else {
          Fluttertoast.showToast(msg: 'Network Error');
        }
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

