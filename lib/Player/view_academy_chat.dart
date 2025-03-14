import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Coach/chat_with_player.dart';
import 'package:selectiontrialsnew/Coach/send_complaint.dart';
import 'package:selectiontrialsnew/Player/chat_with_academy.dart';
import 'package:selectiontrialsnew/Player/view_academy_chat.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'player_home.dart';

void main() {
  runApp(const ViewChatAcademy(title: '',));
}

class ViewChatAcademy extends StatelessWidget {
  const ViewChatAcademy({super.key, req, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Academy to Chat',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewAcademyChatPage(title:  'View Academy chat'),
    );
  }
}

class ViewAcademyChatPage extends StatefulWidget {
  const ViewAcademyChatPage({super.key, required this.title});

  final String title;

  @override
  State<ViewAcademyChatPage> createState() => _ViewAcademyChatPageState();
}

class _ViewAcademyChatPageState extends State<ViewAcademyChatPage> {

  _ViewAcademyChatPageState(){
    ViewChatAcademy();
  }

  List<String> id_ = <String>[];
  List<String> name_= <String>[];
  List<String> since_= <String>[];
  List<String> proof_= <String>[];
  List<String> logo_= <String>[];
  List<String> district_= <String>[];
  List<String> place_= <String>[];
  List<String> state_= <String>[];
  List<String> email_= <String>[];
  List<String> insta_id_= <String>[];
  List<String> website_= <String>[];
  List<String> country_= <String>[];
  List<String> phone_= <String>[];
  List<String> LOGIN_id_= <String>[];

  Future<void> ViewChatAcademy() async {
    List<String> id = <String>[];
    List<String> name= <String>[];
    List<String> since= <String>[];
    List<String> proof= <String>[];
    List<String> logo= <String>[];
    List<String> district= <String>[];
    List<String> place= <String>[];
    List<String> state= <String>[];
    List<String> email= <String>[];
    List<String> country= <String>[];
    List<String> website= <String>[];
    List<String> insta_id= <String>[];
    List<String> phone= <String>[];
    List<String> LOGIN_id= <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/ply_view_chat_acd/';

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
        since.add(arr[i]['since'].toString());
        website.add(arr[i]['website'].toString());
        logo.add(sh.getString('imgurl').toString()+arr[i]['logo']);
        proof.add(sh.getString('imgurl').toString()+arr[i]['proof']);
        insta_id.add(arr[i]['insta_id'].toString());
        district.add(arr[i]['district'].toString());
        place.add(arr[i]['place'].toString());
        state.add(arr[i]['state'].toString());
        email.add(arr[i]['email'].toString());
        country.add(arr[i]['country'].toString());
        phone.add(arr[i]['phone'].toString());
        LOGIN_id.add(arr[i]['LOGIN_id'].toString());
      }

      setState(() {
        id_ = id;
        name_ = name;
        since_ = since;
        website_ = website;
        insta_id_ = insta_id;
        proof_ = proof;
        logo_ = logo;
        district_ = district;
        place_ = place;
        state_ = state;
        email_ = email;
        country_ = country;
        phone_ = phone;
        LOGIN_id_ = LOGIN_id;
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

                              Image(image: NetworkImage(proof_[index]),height: 100,width: 100,),
                              Image(image: NetworkImage(logo_[index]),height: 100,width: 100,),
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
                                    child: Text(since_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(website_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(insta_id_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(district_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(place_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(state_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(email_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(country_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(phone_[index]),
                                  ),

                                  ElevatedButton(onPressed: () async {
                                    SharedPreferences sh = await SharedPreferences.getInstance();
                                    sh.setString('aid', LOGIN_id_[index]);
                                    sh.setString('name', name_[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ChatWithAcademy(title: '')));





                                  }, child: Text("Chat")),


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
