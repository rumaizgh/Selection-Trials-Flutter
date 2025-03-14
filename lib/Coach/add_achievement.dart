import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectiontrialsnew/Coach/coc_home.dart';
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
      home: const MyAddAchievementPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyAddAchievementPage extends StatefulWidget {
  const MyAddAchievementPage({super.key, required this.title});


  final String title;

  @override
  State<MyAddAchievementPage> createState() => _MyAddAchievementPageState();
}

class _MyAddAchievementPageState extends State<MyAddAchievementPage> {

  TextEditingController AchievementController=TextEditingController();
  TextEditingController EventController=TextEditingController();




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:
      Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            TextFormField(controller: AchievementController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Achievement ')),),
            SizedBox(height: 20),
            TextFormField(controller:EventController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('event ')),),
            SizedBox(height: 20),




            ElevatedButton(onPressed: (){
              _send_data();
            }, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
  void _send_data() async{


    String achievement=AchievementController.text;
    String event=EventController.text;





    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/coc_add_achievement/');
    try {
      final response = await http.post(urls, body: {
        'achievement':achievement,
        'event':event,
        'lid':lid,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Added Successfully');
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CoachHomePage(title: 'Coach Home ',)));
        }else {
          Fluttertoast.showToast(msg: 'Incorrect Password');
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
