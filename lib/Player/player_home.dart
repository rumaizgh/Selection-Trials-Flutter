import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Player/change_password.dart';
import 'package:selectiontrialsnew/Player/send_complaint.dart';
import 'package:selectiontrialsnew/Player/send_review_about_academy.dart';
import 'package:selectiontrialsnew/Player/view_academy_chat.dart';
import 'package:selectiontrialsnew/Player/view_achievement_of_coach.dart';
import 'package:selectiontrialsnew/Player/view_applied_trials.dart';
import 'package:selectiontrialsnew/Player/view_certificate_of_coach.dart';
import 'package:selectiontrialsnew/Player/view_coach_and_follow.dart';
import 'package:selectiontrialsnew/Player/view_experience_of_coach.dart';
import 'package:selectiontrialsnew/Player/view_reply.dart';
import 'package:selectiontrialsnew/Player/view_tips_of_coach.dart';
import 'package:selectiontrialsnew/Player/view_coach_chat.dart';
import 'package:selectiontrialsnew/Player/view_followed_coaches.dart';
import 'package:selectiontrialsnew/Player/view_profile.dart';
import 'package:selectiontrialsnew/Player/view_trial.dart';
import 'package:selectiontrialsnew/Player/view_videos_of_coach.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(const HomeNew());
}

class HomeNew extends StatelessWidget {
  const HomeNew({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const PlayerHome(title: 'Home'),
    );
  }
}

class PlayerHome extends StatefulWidget {
  const PlayerHome({super.key, required this.title});

  final String title;

  @override
  State<PlayerHome> createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome> {


  // _PlayerHomeState() {
  //   view_notification();
  // }

  List<String> id_ = <String>[];
  List<String> name_= <String>[];
  List<String> department_= <String>[];
  List<String> gender_= <String>[];
  List<String> place_= <String>[];
  List<String> phone_= <String>[];
  List<String> photo_= <String>[];


  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> department = <String>[];
    List<String> gender = <String>[];
    List<String> place = <String>[];
    List<String> phone = <String>[];
    List<String> photo = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/myapp/user_viewdoctors/';

      var data = await http.post(Uri.parse(url), body: {


      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name']);
        department.add(arr[i]['department']);
        gender.add(arr[i]['gender']);
        place.add(arr[i]['place']);
        phone.add(arr[i]['phone']);
        photo.add(urls+ arr[i]['photo']);

      }

      setState(() {
        id_ = id;
        name_ = name;
        department_ = department;
        gender_ = gender;
        place_ = place;
        phone_ = phone;
        photo_ =  photo;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }







  String uname_="";
  String email_="";
  String uphoto_="";


  _PlayerHomeState()
  {

    a();
    view_notification();

  }

  a()
  async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String name = sh.getString('name').toString();
    String email = sh.getString('email').toString();
    String photo = sh.getString('photo').toString();


    setState(() {
      uname_=name;
      email_=email;
      uphoto_=photo;

    });

  }

  TextEditingController unameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 82, 98),

          title: Text(widget.title),
        ),
        body:
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 210,
              childAspectRatio: 10/10,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,

            ),
            padding: const EdgeInsets.all(8.0),

            itemCount: name_.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 18, 82, 98),
                      borderRadius: BorderRadius.circular(15)),
                  child:  Column(
                      children: [
                        SizedBox(height: 5.0),
                        InkWell(
                          onTap: () async {
                            final pref =await SharedPreferences.getInstance();
                            pref.setString("did", id_[index]);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => ViewSchedule()),);
                          },
                          child: CircleAvatar(
                              radius: 50,backgroundImage: NetworkImage(photo_[index])),
                        ),
                        // SizedBox(height: 5.0),
                        // CircleAvatar(radius: 50,backgroundImage: NetworkImage(photo_[index])),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(1),
                              child: Text(name_[index],style: TextStyle(color: Colors.white,fontSize: 18)),
                            ),],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Text(department_[index],style: TextStyle(color: Colors.white)),
                            ),],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(1),
                              child: Text(phone_[index],style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),

                      ]
                  )
              );
            }),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 82, 98),
                ),
                child:
                Column(children: [

                  Text(
                    'Player Home',
                    style: TextStyle(fontSize: 20,color: Colors.white),

                  ),


                ])


                ,
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
                },
              ),

              ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' View Profile '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPlayerProfile(title: 'View Profile',),));
                },
              ),ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' Change Password '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(title: 'Change Password ',),));
                },
              ),
              ListTile(
                leading: Icon(Icons.person_pin),
                title: const Text(' View Followed Coaches '),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewFollowedCoachPage(title: 'View Followed Coaches',),));
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.home),
              //   title: const Text('Chat with Coach'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCoachChatPage(title: 'View Coach to Chat'),));
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Follow Coach'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCoachFollowPage(title:  'View Coach to Follow'),));
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Chat with Academy'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAcademyChatPage(title: 'View Academy to Chat'),));
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('New Trials'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAcademyChatPage(title: 'View Academy to Chat'),));
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Trials'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTrialPage(title: 'View Trials to apply'),));
                },
              ),ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Applied Trials'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAppliedTrialsPage(title: 'View Applied Trials to apply'),));
                },
              ),ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Certificate of coach'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCertificateCoach(),));
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Tips of coach'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTipsCoachPage(title: 'View Tips of Coach'),));
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Experience of coach'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewExperienceCoach(),));
                },
              ),


              ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Achievement of Coach'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAchievementCoach(),));
                },
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Videos of coach'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewVideoOfCoach(title: 'View videos of coach'),));
                },
              ),ListTile(
                leading: Icon(Icons.home),
                title: const Text('Send Complaint'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerSendComplaintPage(title: 'Send Complaint',),));
                },
              ),ListTile(
                leading: Icon(Icons.home),
                title: const Text('View Reply'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerViewReplyPage(title: 'View Reply',),));
                },
              ),

              // ListTile(
              //   leading: Icon(Icons.person_pin_outlined),
              //   title: const Text(' View Doctors '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewDoctors(title: "Doctors",),));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.book_outlined),
              //   title: const Text(' View Booking Details '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewBookingDetailsPage(title: "Booking Details",),));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.note_alt_rounded),
              //   title: const Text(' View Prescription Details '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPrescriptionPage(title: "Prescription Details",),));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.medical_services_outlined),
              //   title: const Text(' View Test Details '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTestDetailsPage(title: "Test Details",),));
              //   },
              // ),
              //
              //
              // ListTile(
              //   leading: Icon(Icons.local_pharmacy),
              //   title: const Text(' View Pharmacy '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPharmacy(title: "Pharmacy",),));
              //   },
              //
              // ),
              //
              // ListTile(
              //   leading: Icon(Icons.medical_information_outlined),
              //   title: const Text(' View Medicine Orders '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMedicineOrderPage(title: "Medicine Order Details",),));
              //   },
              // ),ListTile(
              //   leading: Icon(Icons.shopping_cart_sharp),
              //   title: const Text(' View Cart'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart(),));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.feed_outlined),
              //   title: const Text('Complaint '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplyPage(title: "View Complaint",),));
              //   },
              // ),
              //
              // ListTile(
              //   leading: Icon(Icons.change_circle),
              //   title: const Text(' Change Password '),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => MyChangePasswordPage(title: "Change Password",),));
              //   },
              // ),
              // ListTile(
              //   leading: Icon(Icons.logout),
              //   title: const Text('LogOut'),
              //   onTap: () {
              //
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              //   },
              // ),
            ],
          ),
        ),





      ),
    );
  }


  
}
