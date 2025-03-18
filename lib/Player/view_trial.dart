import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Coach/chat_with_player.dart';
import 'package:selectiontrialsnew/Coach/send_complaint.dart';
import 'package:selectiontrialsnew/Player/view_coach_and_follow.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'player_home.dart';

void main() {
  runApp(const ViewTrial(title: '',));
}

class ViewTrial extends StatelessWidget {
  const ViewTrial({super.key, req, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Coaches to Chat',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewTrialPage(title: 'View Reply'),
    );
  }
}

class ViewTrialPage extends StatefulWidget {
  const ViewTrialPage({super.key, required this.title});

  final String title;

  @override
  State<ViewTrialPage> createState() => _ViewTrialPageState();
}

class _ViewTrialPageState extends State<ViewTrialPage> {

  _ViewTrialPageState(){
    ViewTrial();
  }

  List<String> id_ = <String>[];
  List<String> name_= <String>[];
  List<String> date_= <String>[];
  List<String> venue_= <String>[];
  List<String> description_= <String>[];
  List<String> age_= <String>[];
  List<String> game_name_= <String>[];
  List<String> academy_name_= <String>[];

  Future<void> ViewTrial() async {
    List<String> id = <String>[];
    List<String> name= <String>[];
    List<String> date= <String>[];
    List<String> venue= <String>[];
    List<String> description= <String>[];
    List<String> age= <String>[];
    List<String> game_name= <String>[];
    List<String> academy_name= <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/ply_view_trial/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name'].toString());
        date.add(arr[i]['date'].toString());
        venue.add(arr[i]['venue'].toString());
        description.add(arr[i]['description'].toString());
        age.add(arr[i]['age'].toString());
        game_name.add(arr[i]['game_name'].toString());
        academy_name.add(arr[i]['academy_name'].toString());
      }

      setState(() {
        id_ = id;
        name_ = name;
        date_ = date;
        venue_ = venue;
        description_ = description;
        age_ = age;
        game_name_ = game_name;
        academy_name_ = academy_name;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayerHome(title: 'Chat Page',)),);

          },),
          backgroundColor: Theme.of(context).colorScheme.primary,
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
                                    child: Text(id_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(name_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(date_[index]),
                                  ),    Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(venue_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(description_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(age_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(game_name_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(academy_name_[index]),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {
                                      SharedPreferences sh = await SharedPreferences.getInstance();
                                      String url = sh.getString('url').toString();
                                      String lid = sh.getString('lid').toString();

                                      final urls = Uri.parse('$url/ply_apply_trial/');
                                      try {
                                        final response = await http.post(urls, body: {
                                          'tid': id_[index],
                                          'lid': lid,
                                        });

                                        if (response.statusCode == 200) {
                                          String status = jsonDecode(response.body)['status'];
                                          if (status == 'ok') {
                                            Fluttertoast.showToast(msg: 'Applied');

                                            // Reload the trials list after applying
                                            setState(() {
                                              ViewTrial(); // Refresh the list of trials
                                            });

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => PlayerHome(title: 'Player Home ')));
                                          } else {
                                            Fluttertoast.showToast(msg: 'Error applying for trial');
                                          }
                                        } else {
                                          Fluttertoast.showToast(msg: 'Network Error');
                                        }
                                      } catch (e) {
                                        Fluttertoast.showToast(msg: e.toString());
                                      }
                                    },
                                    child: Text("Apply"),
                                  )






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


        floatingActionButton: FloatingActionButton(onPressed: () {

          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MySendComplaintPage(title: 'SendComplaint')));

        },
          child: Icon(Icons.plus_one),
        ),


      ),
    );
  }
}
