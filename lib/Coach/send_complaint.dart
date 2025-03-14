import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectiontrialsnew/Coach/view_experience.dart';
import 'package:selectiontrialsnew/Coach/view_reply.dart';
import 'package:selectiontrialsnew/Coach/view_tips.dart';
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
      home: const MySendComplaintPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MySendComplaintPage extends StatefulWidget {
  const MySendComplaintPage({super.key, required this.title});


  final String title;

  @override
  State<MySendComplaintPage> createState() => _MySendComplaintPageState();
}

class _MySendComplaintPageState extends State<MySendComplaintPage> {

  TextEditingController ComplaintController=TextEditingController();
  



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

            TextFormField(controller: ComplaintController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('complaint ')),),
            SizedBox(height: 20),
            

            ElevatedButton(onPressed: (){
              send_complaint();
            }, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
  Future<void> send_complaint() async {
    String complaint = ComplaintController.text;
    


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/coc_send_complaint/');
    try {
      final response = await http.post(urls, body: {
        'complaint':complaint,
        'lid':lid,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Added Successfully');
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewReplyPage(title: 'View Reply ',)));
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
