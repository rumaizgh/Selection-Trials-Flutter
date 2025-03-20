import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Coach/chat_with_player.dart';
import 'package:selectiontrialsnew/Coach/edit_certificate.dart';
import 'package:selectiontrialsnew/Coach/send_complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'coc_home.dart';

void main() {
  runApp(const ViewVideo(title: '',));
}

class ViewVideo extends StatelessWidget {
  const ViewVideo({super.key, req, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Certificate',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewVideoPage(title: 'View Certificate'),
    );
  }
}

class ViewVideoPage extends StatefulWidget {
  const ViewVideoPage({super.key, required this.title});

  final String title;

  @override
  State<ViewVideoPage> createState() => _ViewVideoPageState();
}

class _ViewVideoPageState extends State<ViewVideoPage> {

  _ViewVideoPageState(){
    ViewVideo();
  }

  List<String> id_ = <String>[];
  List<String> date_= <String>[];
  List<String> video_title_= <String>[];
  List<String> video_details_= <String>[];
  List<String> video_= <String>[];

  Future<void> ViewVideo() async {
    List<String> id = <String>[];
    List<String> date= <String>[];
    List<String> video_title= <String>[];
    List<String> video_details= <String>[];
    List<String> video= <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/coc_view_videos/';

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
        video_title.add(arr[i]['videotitle'].toString());
        video_details.add(arr[i]['videodetails'].toString());
        video.add(sh.getString('imgurl').toString()+arr[i]['videofile']);

      }

      setState(() {
        id_ = id;
        date_ = date;
        video_title_ = video_title;
        video_details_ = video_details;
        video_ = video;

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
              MaterialPageRoute(builder: (context) => CoachHomePage(title: 'Chat Page',)),);

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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Video Title"),
                                        Text(video_title_[index]),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Issued Date"),

                                        Text(date_[index]),
                                      ],
                                    ),
                                  ),Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Issued Date"),

                                        Text(date_[index]),
                                      ],
                                    ),
                                  ),Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Video Details"),

                                        Text(video_details_[index]),
                                      ],
                                    ),
                                  ),


                                  ElevatedButton(
                                      onPressed: () async {
                                        final url=video_[index];
                                        // Launch the URL
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      }, child: Text("video"),),
                                  ElevatedButton(
                                      onPressed: () async {

                                        SharedPreferences sh = await SharedPreferences.getInstance();
                                        String url = sh.getString('url').toString();
                                        String lid = sh.getString('lid').toString();

                                        final urls = Uri.parse('$url/coc_delete_video/');
                                        try {
                                          final response = await http.post(urls, body: {

                                            'id':id_[index],



                                          });
                                          if (response.statusCode == 200) {
                                            String status = jsonDecode(response.body)['status'];
                                            if (status=='ok') {
                                              Fluttertoast.showToast(msg: 'Deleted Successfully');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => ViewVideoPage(title: 'View Videos',)));
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


                                      }, child: Text("delete"),)

                                ],
                              )

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
