import 'package:flutter/material.dart';
import 'dart:convert';
import 'edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



void main() {
  runApp(const ViewCertificateCoach());
}

class ViewCertificateCoach extends StatelessWidget {
  const ViewCertificateCoach({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewCertificateCoachPage(title: 'View Profile'),
    );
  }
}

class ViewCertificateCoachPage extends StatefulWidget {
  const ViewCertificateCoachPage({super.key, required this.title});

  final String title;

  @override
  State<ViewCertificateCoachPage> createState() => _ViewCertificateCoachPageState();
}

class _ViewCertificateCoachPageState extends State<ViewCertificateCoachPage> {

  _ViewCertificateCoachPageState()
  {
    _send_data();
  }
  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[


              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(certificate_type_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(file_),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(date_),
                  ),

                ],
              ),


            ],
          ),
        ),
      ),
    );
  }


  String certificate_type_="";
  String file_="";
  String date_="";


  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/ply_view_certificate_of_coach/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String certificate_type=jsonDecode(response.body)['certificate_type'];
          String file=jsonDecode(response.body)['file'];
          String date=jsonDecode(response.body)['date'];


          setState(() {

            certificate_type_= certificate_type;
            file_= file;
            date_= date;

          });





        }else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
