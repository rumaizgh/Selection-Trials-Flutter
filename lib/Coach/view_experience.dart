import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:selectiontrialsnew/Coach/edit_experience.dart';
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
      home: const Myexperiencepage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Myexperiencepage extends StatefulWidget {
  const Myexperiencepage({super.key, required this.title});

  final String title;

  @override
  State<Myexperiencepage> createState() => _MyexperiencepageState();
}

class _MyexperiencepageState extends State<Myexperiencepage> {
  int _counter = 0;

  _MyexperiencepageState() {
    viewreply();
  }


  List<String> id_ = <String>['id'];
  List<String> name_ = <String>['name'];
  List<String> fromyear_ = <String>['fromyear'];
  List<String> toyear_ = <String>['toyear'];
  List<String> position_ = <String>['position'];

  Future<void> viewreply() async {

    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> fromyear = <String>[];
    List<String> toyear = <String>[];
    List<String> position = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/coc_view_experience/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':lid
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name'].toString());
        fromyear.add(arr[i]['fromyear'].toString());
        toyear.add(arr[i]['toyear'].toString());
        position.add(arr[i]['position'].toString());


      }

      setState(() {
        id_ = id;
        name_ = name;
        fromyear_ = fromyear;
        toyear_ = toyear;
        position_ = position;

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
                                  Text("name"),
                                  Text(name_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("From Year"),

                                  Text(fromyear_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("To Year"),
                                  Text(toyear_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Position"),
                                  Text(position_[index]),
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
                                    builder: (context) => EditExperiencePage(title: ''),
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




