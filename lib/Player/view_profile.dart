import 'package:flutter/material.dart';
import 'dart:convert';
import 'edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';



void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Profile',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewPlayerProfile(title: 'View Profile'),
    );
  }
}

class ViewPlayerProfile extends StatefulWidget {
  const ViewPlayerProfile({super.key, required this.title});

  final String title;

  @override
  State<ViewPlayerProfile> createState() => _ViewPlayerProfileState();
}

class _ViewPlayerProfileState extends State<ViewPlayerProfile> {

  _ViewPlayerProfileState()
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
                        Text("Name"),
                        Text(name_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text("Dob"),

                        Text(dob_),
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
                  // Padding(
                  //   padding: EdgeInsets.all(5),
                  //   child: Text(email_),
                  // ),
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
                        Text('Height'),
                        Text(height_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Weight'),
                        Text(weight_),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text('Phone'),
                        Text(phone_),
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
  String height_="";
  String weight_="";
  String phone_="";
  String state_="";
  String city_="";
  String country_="";
  String place_="";
  String h_name_="";
  String photo_="";

  void _send_data() async{

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/ply_view_profile/');
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
          String weight=jsonDecode(response.body)['weight'].toString();
          String height=jsonDecode(response.body)['height'].toString();
          String state=jsonDecode(response.body)['state'].toString();
          String city=jsonDecode(response.body)['city'].toString();
          String country=jsonDecode(response.body)['country'].toString();
          String phone=jsonDecode(response.body)['phone'].toString();
          String h_name=jsonDecode(response.body)['h_name'].toString();
          String place=jsonDecode(response.body)['place'].toString();
          String photo=sh.getString("imgurl").toString()+jsonDecode(response.body)['photo'];

          setState(() {

            name_= name;
            dob_= dob;
            gender_= gender;
            email_= email;
            height_= height;
            weight_= weight;
            phone_= phone;
            state_= state;
            city_= city;
            h_name_= h_name;
            country_= country;
            place_= place;
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
