import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Player/player_home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewExperienceCoach());
}

class ViewExperienceCoach extends StatelessWidget {
  const ViewExperienceCoach({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewExperienceCoachPage(title: 'View Experience of Coach'),
    );
  }
}

class ViewExperienceCoachPage extends StatefulWidget {
  const ViewExperienceCoachPage({super.key, required this.title});

  final String title;

  @override
  State<ViewExperienceCoachPage> createState() => _ViewExperienceCoachPageState();
}

class _ViewExperienceCoachPageState extends State<ViewExperienceCoachPage> {

  _ViewExperienceCoachPageState(){
    ViewExperienceCoach();
  }

  List<String> id_ = <String>[];
  List<String> academy_name_= <String>[];
  List<String> from_year_= <String>[];
  List<String> to_year_= <String>[];
  List<String> position_= <String>[];
  List<String> exp_of_= <String>[];


  Future<void> ViewExperienceCoach() async {
    List<String> id = <String>[];
    List<String> academy_name = <String>[];
    List<String> from_year = <String>[];
    List<String> to_year = <String>[];
    List<String> position = <String>[];
    List<String> exp_of = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/ply_view_experience/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        academy_name.add(arr[i]['academy_name'].toString());
        from_year.add(arr[i]['from_year'].toString());
        to_year.add(arr[i]['to_year'].toString());
        position.add(arr[i]['position'].toString());
        exp_of.add(arr[i]['exp_of'].toString());

      }

      setState(() {
        id_ = id;
        academy_name_ = academy_name;
        from_year_ = from_year;
        to_year_ = to_year;
        position_ = position;
        exp_of_ = exp_of;

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
                                  Text("academy_name"),
                                  Text(academy_name_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("from_year"),

                                  Text(from_year_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("to_year"),

                                  Text(to_year_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("position"),

                                  Text(position_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("exp_of"),

                                  Text(exp_of_[index]),
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
          //     MaterialPageRoute(builder: (context) => MySendfrom_year()));

        },
          child: Icon(Icons.plus_one),
        ),


      ),
    );
  }
}
