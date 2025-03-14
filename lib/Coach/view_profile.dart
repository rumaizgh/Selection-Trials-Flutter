import 'package:flutter/material.dart';
import 'dart:convert';
import 'edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



void main() {
  runApp(const ViewCoachProfilePage(title: '',));
}

class ViewCoachProfilePage extends StatelessWidget {
  const ViewCoachProfilePage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewCoachProfile(title: 'View Profile'),
    );
  }
}

class ViewCoachProfile extends StatefulWidget {
  const ViewCoachProfile({super.key, required this.title});

  final String title;

  @override
  State<ViewCoachProfile> createState() => _ViewCoachProfileState();
}

class _ViewCoachProfileState extends State<ViewCoachProfile> {

  _ViewCoachProfileState()
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


              CircleAvatar(radius: 100,backgroundImage: NetworkImage(photo_),),
              Column(
                children: [
                  // Image(image: NetworkImage(photo_),height: 200,width: 200,),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Name'),
                        Text(name_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Date of Birth'),
                        Text(dob_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('House Name'),
                        Text(h_name_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('gender'),
                        Text(gender_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Email'),
                        Text(email_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Country'),
                        Text(country_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('City'),
                        Text(city_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('State'),
                        Text(state_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Place'),
                        Text(place_),
                      ],
                    ),
                  ),

                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyEditPage(title: "Edit Profile"),));
                },
                child: Text("Edit Profile"),
              ),

            ],
          ),
        ),
      ),
    );
  }


  String name_="";
  String dob_="";
  String gender_="";
  String email_="";
  String phone_="";
  String country_="";
  String city_="";
  String place_="";
  String state_="";
  String h_name_="";
  String photo_="";

  void _send_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/coc_view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)['name'].toString();
          String dob=jsonDecode(response.body)['dob'].toString();
          String gender=jsonDecode(response.body)['gender'].toString();
          String email=jsonDecode(response.body)['email'].toString();
          String phone=jsonDecode(response.body)['phone'].toString();
          String place=jsonDecode(response.body)['place'].toString();
          String country=jsonDecode(response.body)['country'].toString();
          String city=jsonDecode(response.body)['city'].toString();
          String h_name=jsonDecode(response.body)['h_name'].toString();
          String state=jsonDecode(response.body)['state'].toString();
          String photo=sh.getString("imgurl").toString()+jsonDecode(response.body)['photo'];

          setState(() {

            name_= name;
            dob_= dob;
            gender_= gender;
            email_= email;
            phone_= phone;
            country_= country;
            city_= city;
            h_name_= h_name;
            place_= place;
            state_= state;
            photo_= photo;
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
