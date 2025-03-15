import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectiontrialsnew/Coach/view_experience.dart';
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
      home: const AddTipsPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AddTipsPage extends StatefulWidget {
  const AddTipsPage({super.key, required this.title});


  final String title;

  @override
  State<AddTipsPage> createState() => _AddTipsPageState();
}

class _AddTipsPageState extends State<AddTipsPage> {

  TextEditingController TiptitleController=TextEditingController();
  TextEditingController TipdescriptionController=TextEditingController();




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

            TextFormField(controller: TiptitleController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Tips ')),),
            SizedBox(height: 20),
            TextFormField(controller:TipdescriptionController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Tip Description ')),),
            SizedBox(height: 20),



            ElevatedButton(onPressed: (){
              add_tips();
            }, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
  Future<void> add_tips() async {
    String tip_title = TiptitleController.text;
    String tip_description = TipdescriptionController.text;




    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/coc_add_tips/');
    try {
      final response = await http.post(urls, body: {
        'tip_title':tip_title,
        'tip_description':tip_description,
        'lid':lid,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Added Successfully');
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyViewTipsPage(title: 'View Tips ',)));
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



//riss

// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyLoginPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyLoginPage extends StatefulWidget {
//   const MyLoginPage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<MyLoginPage> createState() => _MyLoginPageState();
// }
//
// class _MyLoginPageState extends State<MyLoginPage> {
//
//   TextEditingController TiptitleController=TextEditingController();
//   TextEditingController TipdescriptionController=TextEditingController();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//             TextFormField(controller: TiptitleController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('tip_title ')),),
//             SizedBox(height: 20),
//             TextFormField(controller:TipdescriptionController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
//             SizedBox(height: 20),
//
//
//
//             ElevatedButton(onPressed: (){}, child: Text('Submit'))
//           ],
//         ),
//       ),
//
//     );
//   }
// }
