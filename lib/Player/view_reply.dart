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
      home: const PlayerViewReplyPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class PlayerViewReplyPage extends StatefulWidget {
  const PlayerViewReplyPage({super.key, required this.title});

  final String title;

  @override
  State<PlayerViewReplyPage> createState() => _PlayerViewReplyPageState();
}

class _PlayerViewReplyPageState extends State<PlayerViewReplyPage> {
  int _counter = 0;

  _PlayerViewReplyPageState() {
    PlayerViewReply();
  }


  List<String> id_ = <String>['id'];
  List<String> date_ = <String>['date'];
  List<String> complaint_ = <String>['complaint'];
  List<String> reply_ = <String>['reply'];
  List<String> status_ = <String>['status'];

  Future<void> PlayerViewReply() async {

    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> complaint = <String>[];
    List<String> reply = <String>[];
    List<String> status = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/ply_view_reply/';

      var data = await http.post(Uri.parse(url), body: {
        'lid':lid
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        complaint.add(arr[i]['complaint'].toString());
        reply.add(arr[i]['reply'].toString());
        status.add(arr[i]['status'].toString());


      }

      setState(() {
        id_ = id;
        date_ = date;
        complaint_ = complaint;
        reply_ = reply;
        status_ = status;

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
                                  Text("date"),
                                  Text(date_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Complaint"),

                                  Text(complaint_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Reply"),
                                  Text(reply_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("status"),
                                  Text(status_[index]),
                                ],
                              ),
                            ),



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




