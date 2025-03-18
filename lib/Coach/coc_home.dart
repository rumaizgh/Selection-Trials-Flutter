//ok


import 'package:flutter/material.dart';
import 'package:selectiontrialsnew/Coach/add_achievement.dart';
import 'package:selectiontrialsnew/Coach/add_certificate.dart';
import 'package:selectiontrialsnew/Coach/add_experience.dart';
import 'package:selectiontrialsnew/Coach/add_tips.dart';
import 'package:selectiontrialsnew/Coach/change_password.dart';
import 'package:selectiontrialsnew/Coach/send_complaint.dart';
import 'package:selectiontrialsnew/Coach/view_achievement.dart';
import 'package:selectiontrialsnew/Coach/view_certificate.dart';
import 'package:selectiontrialsnew/Coach/view_experience.dart';
import 'package:selectiontrialsnew/Coach/view_players_chat.dart';
import 'package:selectiontrialsnew/Coach/view_profile.dart';
import 'package:selectiontrialsnew/Coach/view_reply.dart';
import 'package:selectiontrialsnew/Coach/view_review.dart';
import 'package:selectiontrialsnew/Coach/view_tips.dart';


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
      home: const CoachHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CoachHomePage extends StatefulWidget {
  const CoachHomePage({super.key, required this.title});

  final String title;

  @override
  State<CoachHomePage> createState() => _CoachHomePage();
}

class _CoachHomePage extends State<CoachHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer( // This is the Drawer widget
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Text(
                'Coach Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text("Change Password"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ChangePasswordCoach(title: "Change Password",)
                ));
              },
            ),
            ListTile(
              title: const Text("View Profile"),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewCoachProfilePage(title: "View Profile",)
                ));
              },
            ),

            ListTile(
              
              title: const Text('View Review'),
              onTap: (){

                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewReviewPage(title: "View Review",)
                ));
              },
            ),


            ListTile(
              title: const Text('View Tips'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Close the drawer

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyViewTipsPage(title: "View Tips ",)
                ));
              },
            ),

            ListTile(
              title: const Text('View Players to Chat'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context);

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewChatPlayer(title: "View Player to Chat",)
                ));
                // Close the drawer
              },
            ),



            ListTile(
              title: const Text('Add Tips'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddTipsPage(title: "Add Tips",)
                ));// ose the drawer
              },
            ),
            ListTile(
              title: const Text('View Reply'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewReplyPage(title: "View Reply",)
                ));// ose the drawer
              },
            ),

            ListTile(
              title: const Text('View Experience'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Myexperiencepage(title: "View Experience",)
                ));// ose the drawer
              },
            ),
            ListTile(
              title: const Text('Send Complaint'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MySendComplaintPage(title: "Send Complaint",)
                ));// ose the drawer
              },
            ),
            ListTile(
              title: const Text('Add Experience'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddExperiencePage(title: "Add Experience",)
                ));// ose the drawer
              },
            ),ListTile(
              title: const Text('Add Achievement'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyAddAchievementPage(title: "Add Achievement",)
                ));// ose the drawer
              },
            ),ListTile(
              title: const Text('View Achievement'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyViewAchievementPage(title: "View Achievement",)
                ));// ose the drawer
              },
            ),ListTile(
              title: const Text('Add Certificate'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddCertificatePage(title: "Add Certificate",)
                ));// ose the drawer
              },
            ),ListTile(
              title: const Text('View Certificate'),
              onTap: () {
                // Update the UI or navigate to another screen
                Navigator.pop(context); // Cl

                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewCertificatePage(title: "View Certificate",)
                ));// ose the drawer
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Labour Home"),

            SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}













//rizz

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'package:selectiontrialsnew/Coach/upload_video.dart';
// import 'package:selectiontrialsnew/Coach/view_certificate.dart';
// import 'package:selectiontrialsnew/Coach/view_experience.dart';
// import 'package:selectiontrialsnew/Coach/view_players_chat.dart';
// import 'package:selectiontrialsnew/Coach/view_profile.dart';
// import 'package:selectiontrialsnew/Coach/view_review.dart';
// import 'package:selectiontrialsnew/Coach/view_tips.dart';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Player/view_achievement_of_coach.dart';
// import '../Player/view_reply.dart';
// import '../login.dart';
// import '../main.dart';
// import 'add_achievement.dart';
// import 'view_achievement.dart';
// import 'change_password.dart';
// import 'add_certificate.dart';
// import 'add_experience.dart';
// import 'add_tips.dart';
// import 'chat_with_player.dart';
// import 'edit_achievement.dart';
// import 'edit_certificate.dart';
// import 'edit_experience.dart';
// import 'edit_profile.dart';
// import 'edit_tips.dart';
// import 'send_complaint.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// void main() {
//   runApp(const HomeNew());
// }
//
// class HomeNew extends StatelessWidget {
//   const HomeNew({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Home',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
//         useMaterial3: true,
//       ),
//       home: const CoachHome(title: 'Home'),
//     );
//   }
// }
//
// class CoachHome extends StatefulWidget {
//   const CoachHome({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<CoachHome> createState() => _CoachHomeState();
// }
//
// class _CoachHomeState extends State<CoachHome> {
//
//
//   // // _CoachHomeState() {
//   // //   view_notification();
//   // // }
//   //
//   // List<String> id_ = <String>[];
//   // List<String> name_= <String>[];
//   // List<String> department_= <String>[];
//   // List<String> gender_= <String>[];
//   // List<String> place_= <String>[];
//   // List<String> phone_= <String>[];
//   // List<String> photo_= <String>[];
//   //
//   //
//   // Future<void> view_notification() async {
//   //   List<String> id = <String>[];
//   //   List<String> name = <String>[];
//   //   List<String> department = <String>[];
//   //   List<String> gender = <String>[];
//   //   List<String> place = <String>[];
//   //   List<String> phone = <String>[];
//   //   List<String> photo = <String>[];
//   //
//   //
//   //   try {
//   //     SharedPreferences sh = await SharedPreferences.getInstance();
//   //     String urls = sh.getString('url').toString();
//   //     String url = '$urls/myapp/';
//   //
//   //     var data = await http.post(Uri.parse(url), body: {
//   //
//   //
//   //     });
//   //     var jsondata = json.decode(data.body);
//   //     String statuss = jsondata['status'];
//   //
//   //     var arr = jsondata["data"];
//   //
//   //     print(arr.length);
//   //
//   //     for (int i = 0; i < arr.length; i++) {
//   //       id.add(arr[i]['id'].toString());
//   //       name.add(arr[i]['name']);
//   //       department.add(arr[i]['department']);
//   //       gender.add(arr[i]['gender']);
//   //       place.add(arr[i]['place']);
//   //       phone.add(arr[i]['phone']);
//   //       photo.add(urls+ arr[i]['photo']);
//   //
//   //     }
//   //
//   //     setState(() {
//   //       id_ = id;
//   //       name_ = name;
//   //       department_ = department;
//   //       gender_ = gender;
//   //       place_ = place;
//   //       phone_ = phone;
//   //       photo_ =  photo;
//   //     });
//   //
//   //     print(statuss);
//   //   } catch (e) {
//   //     print("Error ------------------- " + e.toString());
//   //     //there is error during converting file image to base64 encoding.
//   //   }
//   // }
//
//
//
//
//
//
//
//   // String uname_="";
//   // String email_="";
//   // String uphoto_="";
//
//
//   // _CoachHomeState()
//   // {
//   //
//   //   a();
//   //   view_notification();
//   //
//   // }
//   //
//   // a()
//   // async {
//   //   SharedPreferences sh = await SharedPreferences.getInstance();
//   //   String name = sh.getString('name').toString();
//   //   String email = sh.getString('email').toString();
//   //   String photo = sh.getString('photo').toString();
//   //
//   //
//   //   setState(() {
//   //     uname_=name;
//   //     email_=email;
//   //     uphoto_=photo;
//   //
//   //   });
//   //
//   //
//   // }
//
//
//   TextEditingController unameController = new TextEditingController();
//   TextEditingController passController = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: () async{ return true; },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 18, 82, 98),
//
//           title: Text(widget.title),
//         ),
//         body:
//         // GridView.builder(
//         //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         //       maxCrossAxisExtent: 210,
//         //       childAspectRatio: 10/10,
//         //       crossAxisSpacing: 10,
//         //       mainAxisSpacing: 10,
//         //
//         //     ),
//         //     padding: const EdgeInsets.all(8.0),
//         //
//         //     // itemCount: name_.length,
//         //     itemBuilder: (BuildContext ctx, index) {
//         //       return Container(
//         //           alignment: Alignment.center,
//         //           decoration: BoxDecoration(
//         //               color: Color.fromARGB(255, 18, 82, 98),
//         //               borderRadius: BorderRadius.circular(15)),
//         //           child:  Column(
//         //               children: [
//         //                 SizedBox(height: 5.0),
//         //                 Column(
//         //                   children: [
//         //                     Padding(
//         //                       padding: EdgeInsets.all(1),
//         //                       // child: Text(name_[index],style: TextStyle(color: Colors.white,fontSize: 18)),
//         //                     ),],
//         //                 ),
//         //                 Column(
//         //                   children: [
//         //                     Padding(
//         //                       padding: EdgeInsets.all(2),
//         //                       // child: Text(department_[index],style: TextStyle(color: Colors.white)),
//         //                     ),],
//         //                 ),
//         //                 Column(
//         //                   children: [
//         //                     Padding(
//         //                       padding: EdgeInsets.all(1),
//         //                       // child: Text(phone_[index],style: TextStyle(color: Colors.white)),
//         //                     ),
//         //                   ],
//         //                 ),
//         //                 //     // Padding(
//         //                 //     //   padding: EdgeInsets.all(5),
//         //                 //     //   child:  ElevatedButton(
//         //                 //     //     onPressed: () async {
//         //                 //     //
//         //                 //     //       final pref =await SharedPreferences.getInstance();
//         //                 //     //       pref.setString("did", id_[index]);
//         //                 //     //
//         //                 //     //       Navigator.push(
//         //                 //     //         context,
//         //                 //     //         MaterialPageRoute(builder: (context) => ViewSchedule()),
//         //                 //     //       );
//         //                 //     //
//         //                 //     //
//         //                 //     //
//         //                 //     //
//         //                 //     //     },
//         //                 //     //     child: Text("Schedule"),
//         //                 //     //   ),
//         //                 //     // ),
//         //                 //   ],
//         //                 // ),
//         //
//         //               ]
//         //           )
//         //       );
//         //     }),
//         // //
//         // // drawer: Drawer(
//         // //   child: ListView(
//         // //     padding: EdgeInsets.zero,
//         // //     children: [
//         // //       DrawerHeader(
//         // //         decoration: BoxDecoration(
//         // //           color: Color.fromARGB(255, 18, 82, 98),
//         // //         ),
//         // //         child:
//         // //         Column(children: [
//         // //
//         // //           Text(
//         // //             'CliniSync',
//         // //             style: TextStyle(fontSize: 20,color: Colors.white),
//         // //
//         // //           ),
//         // //           // CircleAvatar(radius: 29,backgroundImage: NetworkImage(uphoto_)),
//         // //           // Text(uname_,style: TextStyle(color: Colors.white)),
//         // //           // Text(email_,style: TextStyle(color: Colors.white)),
//         // //
//         // //
//         // //
//         // //         ])
//         // //
//         // //
//         // //         ,
//         // //       ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: const Text('Achievement'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddAchievementPage(title: 'Add Achievement',),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.person_pin),
//                 title: const Text(' View Profile '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCoachProfile(title:'ds'),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.person_pin_outlined),
//                 title: const Text(' View Tips '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTipsPage(title: "Doctors",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.book_outlined),
//                 title: const Text(' View Review '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReviewPage(),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.note_alt_rounded),
//                 title: const Text(' View Reply '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReplyPage(title: 'View Reply',),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.medical_services_outlined),
//                 title: const Text(' View Experience '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Myexperiencepage(title: "View Experience",),));
//                 },
//               ),
//
//
//               ListTile(
//                 leading: Icon(Icons.local_pharmacy),
//                 title: const Text(' View certificate '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Mycertificatepage(title: "Pharmacy",),));
//                 },
//
//               ),
//               ListTile(
//                 leading: Icon(Icons.local_pharmacy),
//                 title: const Text(' Chat with Player '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewChatPlayer(title: "Chat With Player",),));
//                 },
//
//               ),
//
//
//
//               ListTile(
//                 leading: Icon(Icons.medical_information_outlined),
//                 title: const Text(' video '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Myvideopage(title: "Medicine Order Details",),));
//                 },
//               ),ListTile(
//                 leading: Icon(Icons.shopping_cart_sharp),
//                 title: const Text(' View achievement'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyViewAchievementPage(title: '',),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.feed_outlined),
//                 title: const Text('Send Complaint '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MySendComplaintPage(title: "View Complaint",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.feed_outlined),
//                 title: const Text('Add Experience '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => AddExperiencePage(title: "Add Experience",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.feed_outlined),
//                 title: const Text('Add Certificate '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => AddCertificatePage(title: "Add Certificate",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.feed_outlined),
//                 title: const Text('Add Achievement '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddAchievementPage(title: "Add Achievement",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.change_circle),
//                 title: const Text(' Change Password '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Mychangepasspage(title: "Change Password",),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: const Text('LogOut'),
//                 onTap: () {
//
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => myloginpage(title: 'Logout/Login',),));
//                 },
//               ),
//             ],
//           ),
//         ),
//
//
//
//
//
//       ),
//     );
//   }
//
//
//
//   // void _send_data() async{
//   //
//   //
//   //   String uname=unameController.text;
//   //   String password=passController.text;
//   //
//   //
//   //   SharedPreferences sh = await SharedPreferences.getInstance();
//   //   String url = sh.getString('url').toString();
//   //
//   //   final urls = Uri.parse('$url/myapp/user_loginpost/');
//   //   try {
//   //     final response = await http.post(urls, body: {
//   //       'name':uname,
//   //       'password':password,
//   //
//   //
//   //     });
//   //     if (response.statusCode == 200) {
//   //       String status = jsonDecode(response.body)['status'];
//   //       if (status=='ok') {
//   //         String lid=jsonDecode(response.body)['lid'];
//   //         sh.setString("lid", lid);
//   //         Navigator.push(context, MaterialPageRoute(
//   //           builder: (context) => MyHomePage(title: "Home"),));
//   //       }else {
//   //         Fluttertoast.showToast(msg: 'Not Found');
//   //       }
//   //     }
//   //     else {
//   //       Fluttertoast.showToast(msg: 'Network Error');
//   //     }
//   //   }
//   //   catch (e){
//   //     Fluttertoast.showToast(msg: e.toString());
//   //   }
//   // }
//
// }
//


