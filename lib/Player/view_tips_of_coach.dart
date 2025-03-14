import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Player/player_home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewTipsCoach());
}

class ViewTipsCoach extends StatelessWidget {
  const ViewTipsCoach({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewTipsCoachPage(title: 'View Reply'),
    );
  }
}

class ViewTipsCoachPage extends StatefulWidget {
  const ViewTipsCoachPage({super.key, required this.title});

  final String title;

  @override
  State<ViewTipsCoachPage> createState() => _ViewTipsCoachPageState();
}

class _ViewTipsCoachPageState extends State<ViewTipsCoachPage> {

  _ViewTipsCoachPageState(){
    ViewTipsCoach();
  }

  List<String> id_ = <String>[];
  List<String> tip_title_= <String>[];
  List<String> tip_description_= <String>[];
  List<String> tip_of_= <String>[];


  Future<void> ViewTipsCoach() async {
    List<String> id = <String>[];
    List<String> tip_title = <String>[];
    List<String> tip_description = <String>[];
    List<String> tip_of = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/ply_view_tips/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        tip_title.add(arr[i]['tip_title'].toString());
        tip_description.add(arr[i]['tip_description'].toString());
        tip_of.add(arr[i]['tip_of'].toString());

      }

      setState(() {
        id_ = id;
        tip_title_ = tip_title;
        tip_description_ = tip_description;
        tip_of_ = tip_of;

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
                                  Text("tip_title"),
                                  Text(tip_title_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("tip_description"),

                                  Text(tip_description_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("tip_of"),

                                  Text(tip_of_[index]),
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
