import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectiontrialsnew/Coach/edit_achievement.dart';
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
      home: const MyViewAchievementPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyViewAchievementPage extends StatefulWidget {
  const MyViewAchievementPage({super.key, required this.title});


  final String title;

  @override
  State<MyViewAchievementPage> createState() => _MyViewAchievementPageState();
}

class _MyViewAchievementPageState extends State<MyViewAchievementPage> {
  int _counter = 0;

  _MyViewAchievementPageState() {
    view();
  }

  List<String> id_ = <String>[];
  List<String> achievement_= <String>[];
  List<String> event_= <String>[];

  Future<void> view() async {
    List<String> id = <String>[];
    List<String> achievement= <String>[];
    List<String> event= <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/coc_view_achievement/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        achievement.add(arr[i]['achievement'].toString());
        event.add(arr[i]['event'].toString());
      }

      setState(() {
        id_ = id;
        achievement_ = achievement;
        event_ = event;
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
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Achievement"),
                                Text(achievement_[index]),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Event Name"),

                                Text(event_[index]),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async{

                              SharedPreferences sh = await SharedPreferences.getInstance();

                              sh.setString("achid", id_[index]);


                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAchievementPage(title: ''),
                                ),
                              );
                            },
                            child: Text('Edit'),
                          )



                        ],
                      )


                      ,
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
