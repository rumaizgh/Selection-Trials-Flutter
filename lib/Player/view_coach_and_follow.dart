import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Coach/send_complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'player_home.dart';

void main() {
  runApp(const ViewFollowCoach(title: '',));
}

class ViewFollowCoach extends StatelessWidget {
  const ViewFollowCoach({super.key, req, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Coaches to Chat',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewCoachFollowPage(title: 'View Reply'),
    );
  }
}

class ViewCoachFollowPage extends StatefulWidget {
  const ViewCoachFollowPage({super.key, required this.title});

  final String title;

  @override
  State<ViewCoachFollowPage> createState() => _ViewCoachFollowPageState();
}

class _ViewCoachFollowPageState extends State<ViewCoachFollowPage> {

  _ViewCoachFollowPageState(){
    ViewFollowCoach();
  }

  List<String> id_ = <String>[];
  List<String> name_= <String>[];
  List<String> dob_= <String>[];
  List<String> gender_= <String>[];
  List<String> photo_= <String>[];
  List<String> hname_= <String>[];
  List<String> city_= <String>[];
  List<String> place_= <String>[];
  List<String> state_= <String>[];
  List<String> email_= <String>[];
  List<String> country_= <String>[];
  List<String> phone_= <String>[];
  List<String> LOGIN_id_= <String>[];

  Future<void> ViewFollowCoach() async {
    List<String> id = <String>[];
    List<String> name= <String>[];
    List<String> dob= <String>[];
    List<String> gender= <String>[];
    List<String> photo= <String>[];
    List<String> hname= <String>[];
    List<String> city= <String>[];
    List<String> place= <String>[];
    List<String> state= <String>[];
    List<String> email= <String>[];
    List<String> country= <String>[];
    List<String> phone= <String>[];
    List<String> LOGIN_id= <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/ply_view_chat_coach/';

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
        dob.add(arr[i]['dob'].toString());
        gender.add(arr[i]['gender'].toString());
        photo.add(sh.getString('imgurl').toString()+arr[i]['photo']);
        hname.add(arr[i]['hname'].toString());
        city.add(arr[i]['city'].toString());
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
        dob_ = dob;
        gender_ = gender;
        photo_ = photo;
        hname_ = hname;
        city_ = city;
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

                              Image(image: NetworkImage(photo_[index]),height: 100,width: 100,),
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
                                    child: Text(dob_[index]),
                                  ),    Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(gender_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(hname_[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(city_[index]),
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
                                    String url = sh.getString('url').toString();
                                    String lid = sh.getString('lid').toString();
                                    String cid = sh.getString('cid').toString();

                                    final urls = Uri.parse('$url/ply_view_coach_and_follow/');
                                    try {
                                      final response = await http.post(urls, body: {
                                        'cid':id_[index],
                                        'lid':lid,


                                      });
                                      if (response.statusCode == 200) {
                                        String status = jsonDecode(response.body)['status'];
                                        if (status=='ok') {
                                          Fluttertoast.showToast(msg: 'Followed');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => PlayerHome(title: 'Player Home ',)));
                                        }else {
                                          Fluttertoast.showToast(msg: 'Incorrect Password');
                                        }
                                      }
                                      else {
                                        Fluttertoast.showToast(msg: 'Network Error');
                                      }
                                    }
                                    catch (e){
                                      Fluttertoast.showToast(msg: e.toString());
                                    }


                                  }, child: Text("Follow")),





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
