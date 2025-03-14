import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      home: const Mycertificatepage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Mycertificatepage extends StatefulWidget {
  const Mycertificatepage({super.key, required this.title});


  final String title;

  @override
  State<Mycertificatepage> createState() => _MycertificatepageState();
}

class _MycertificatepageState extends State<Mycertificatepage> {


  List<String> id_ = <String>[];
  List<String> certificate_type_= <String>[];
  List<String> file_= <String>[];
  List<String> date_= <String>[];
  List<String> coachid_= <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> certificate_type = <String>[];
    List<String> file = <String>[];
    List<String> date = <String>[];
    List<String> coachid = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/myapp/user_viewreply/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date']);
        coachid.add(arr[i]['Coach name']);
        file.add(arr[i]['file']);
        certificate_type.add(arr[i]['certificate type']);
      }

      setState(() {
        id_ = id;
        date_ = date;
        certificate_type_ = certificate_type;
        file_ = file;
        coachid_ = coachid;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:
      ListView.builder(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.all(5.0),
        // shrinkWrap: true,
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onLongPress: () {
              print("long press" + index.toString());
            },
            title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      child:
                      Row(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(date_[index]),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(certificate_type_[index]),
                                ),    Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(file_[index]),
                                ),  Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(coachid_[index]),
                                ),
                              ],
                            ),

                          ]
                      ),

                      elevation: 8,
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                )),
          );
        },
      ),

    );
  }


}
