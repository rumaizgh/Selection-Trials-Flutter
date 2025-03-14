import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectiontrialsnew/Coach/view_experience.dart';
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
      home: const AddExperiencePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AddExperiencePage extends StatefulWidget {
  const AddExperiencePage({super.key, required this.title});


  final String title;

  @override
  State<AddExperiencePage> createState() => _AddExperiencePageState();
}

class _AddExperiencePageState extends State<AddExperiencePage> {

  TextEditingController AcademynameController=TextEditingController();
  TextEditingController FromyearController=TextEditingController();
  TextEditingController ToyearController=TextEditingController();
  TextEditingController PositionController=TextEditingController();




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

            TextFormField(controller: AcademynameController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Name ')),),
            SizedBox(height: 20),
            TextFormField(controller:FromyearController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('From Year ')),),
            SizedBox(height: 20),
            TextFormField(controller:ToyearController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('To Year ')),),
            SizedBox(height: 20),
            TextFormField(controller:PositionController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Position ')),),
            SizedBox(height: 20),


            ElevatedButton(onPressed: (){
              add_experience();
            }, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
  Future<void> add_experience() async {
    String name = AcademynameController.text;
    String fromyear = FromyearController.text;
    String toyear = ToyearController.text;
    String position = PositionController.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/coc_add_experience/');
    try {
      final response = await http.post(urls, body: {
        'name':name,
        'fromyear':fromyear,
        'toyear':toyear,
        'position':position,
        'lid':lid,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Added Successfully');
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Myexperiencepage(title: 'View Experience ',)));
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
