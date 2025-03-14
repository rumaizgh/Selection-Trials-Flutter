import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Player/player_home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewAchievementCoach());
}

class ViewAchievementCoach extends StatelessWidget {
  const ViewAchievementCoach({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewAchievementCoachPage(title: 'View Reply'),
    );
  }
}

class ViewAchievementCoachPage extends StatefulWidget {
  const ViewAchievementCoachPage({super.key, required this.title});

  final String title;

  @override
  State<ViewAchievementCoachPage> createState() => _ViewAchievementCoachPageState();
}

class _ViewAchievementCoachPageState extends State<ViewAchievementCoachPage> {

  _ViewAchievementCoachPageState(){
    ViewAchievementCoach();
  }

  List<String> id_ = <String>[];
  List<String> coach_name_= <String>[];
  List<String> achievement_= <String>[];
  List<String> event_= <String>[];


  Future<void> ViewAchievementCoach() async {
    List<String> id = <String>[];
    List<String> coach_name = <String>[];
    List<String> achievement = <String>[];
    List<String> event = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/ply_view_achievement_of_coach/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        coach_name.add(arr[i]['coach_name'].toString());
        achievement.add(arr[i]['achievement'].toString());
        event.add(arr[i]['event'].toString());

      }

      setState(() {
        id_ = id;
        coach_name_ = coach_name;
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



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home',)),);

          },),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
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
                                  Text("Coach Name"),
                                  Text(coach_name_[index]),
                                ],
                              ),
                            ),
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
        floatingActionButton: FloatingActionButton(onPressed: () {

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => MySendtip_description()));

        },
          child: Icon(Icons.plus_one),
        ),


      ),
    );
  }
}
