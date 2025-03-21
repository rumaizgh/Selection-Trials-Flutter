import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Coach/chat_with_player.dart';
import 'package:selectiontrialsnew/Coach/edit_certificate.dart';
import 'package:selectiontrialsnew/Coach/send_complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'coc_home.dart';

void main() {
  runApp(const ViewCertificate(title: '',));
}

class ViewCertificate extends StatelessWidget {
  const ViewCertificate({super.key, req, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Certificate',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewCertificatePage(title: 'View Certificate'),
    );
  }
}

class ViewCertificatePage extends StatefulWidget {
  const ViewCertificatePage({super.key, required this.title});

  final String title;

  @override
  State<ViewCertificatePage> createState() => _ViewCertificatePageState();
}

class _ViewCertificatePageState extends State<ViewCertificatePage> {

  _ViewCertificatePageState(){
    ViewCertificate();
  }

  List<String> id_ = <String>[];
  List<String> date_= <String>[];
  List<String> certificate_type_= <String>[];
  List<String> photo_= <String>[];

  Future<void> ViewCertificate() async {
    List<String> id = <String>[];
    List<String> date= <String>[];
    List<String> certificate_type= <String>[];
    List<String> photo= <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/coc_view_certificate/';

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
        certificate_type.add(arr[i]['certificate_type'].toString());
        photo.add(sh.getString('imgurl').toString()+arr[i]['photo']);

      }

      setState(() {
        id_ = id;
        date_ = date;
        certificate_type_ = certificate_type;
        photo_ = photo;

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

                              Image(image: NetworkImage(photo_[index]),height: 100,width: 100,),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Certificate Name"),
                                        Text(certificate_type_[index]),
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
                                  ),


                                  ElevatedButton(
                                    onPressed: () async{

                                      SharedPreferences sh = await SharedPreferences.getInstance();

                                      sh.setString("achid", id_[index]);
                                      // sh.setString("date", date_[index]);
                                      // sh.setString("certificate_type", certificate_type_[index]);
                                      // sh.setString("photo", photo_[index]);


                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditCertificate(title: ''),
                                        ),
                                      );
                                    },
                                    child: Text('Edit'),
                                  )


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
