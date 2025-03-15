import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:selectiontrialsnew/Coach/edit_experience.dart';
import 'package:selectiontrialsnew/Coach/edit_tips.dart';
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
      home: const MyViewTipsPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyViewTipsPage extends StatefulWidget {
  const MyViewTipsPage({super.key, required this.title});

  final String title;

  @override
  State<MyViewTipsPage> createState() => _MyViewTipsPageState();
}

class _MyViewTipsPageState extends State<MyViewTipsPage> {
  int _counter = 0;

  _MyViewTipsPageState() {
    viewtips();
  }


  List<String> id_ = <String>['id'];
  List<String> tip_title_ = <String>['tip_title'];
  List<String> tip_description_ = <String>['tip_description'];

  Future<void> viewtips() async {

    List<String> id = <String>[];
    List<String> tip_title = <String>[];
    List<String> tip_description = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/coc_view_tips/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':lid
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        tip_title.add(arr[i]['tip_title'].toString());
        tip_description.add(arr[i]['tip_description'].toString());


      }

      setState(() {
        id_ = id;
        tip_title_ = tip_title;
        tip_description_ = tip_description;


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
          leading: BackButton( ),

          backgroundColor: Theme.of(context).colorScheme.primary,

          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),

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
                                  Text("Tip Title"),
                                  Text(tip_title_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tip Description"),

                                  Text(tip_description_[index]),
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
                                    builder: (context) => EditTipsPage(title: ''),
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
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




