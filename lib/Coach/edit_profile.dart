import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selectiontrialsnew/Coach/view_profile.dart';
import 'package:selectiontrialsnew/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


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
      home: const MyEditPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyEditPage extends StatefulWidget {
  const MyEditPage({super.key, required this.title});


  final String title;

  @override
  State<MyEditPage> createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {

  _MyEditPageState(){
    _get_data();
  }

  TextEditingController Namecontroller = TextEditingController();
  TextEditingController DOBcontroller = TextEditingController();
  TextEditingController Hnamecontroller = TextEditingController();
  TextEditingController Gendercontroller = TextEditingController();
  TextEditingController Placecontroller = TextEditingController();
  TextEditingController Citycontroller = TextEditingController();
  TextEditingController Statecontroller = TextEditingController();
  TextEditingController Countrycontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController PhoneNocontroller = TextEditingController();

  String gender='Male';
  String photo='';
  String uphoto='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: SingleChildScrollView(
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          
              if (_selectedImage != null) ...{
                InkWell(
                  child:
                  Image.file(_selectedImage!, height: 400,),
                  radius: 399,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child:Column(
                    children: [
                      Image(image: NetworkImage(uphoto),height: 200,width: 200,),
                      Text('Select Image',style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
          
              TextFormField(controller: Namecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Name ')),),
              SizedBox(height: 20),

              TextFormField(controller: Hnamecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Hname')),),
              SizedBox(height: 20,),
          
          
              RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
              RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
              RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
          
          
          
          
              SizedBox(height: 20,),
              TextFormField(controller: DOBcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('DOB')),),
              SizedBox(height: 20),
              TextFormField(controller: Placecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Place')),),
              SizedBox(height: 20),
              TextFormField(controller: PhoneNocontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Phone NO ')),),
              SizedBox(height: 20),
              TextFormField(controller: Citycontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('City ')),),
              SizedBox(height: 20),
              TextFormField(controller: Statecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('State ')),),
              SizedBox(height: 20),
              TextFormField(controller: Countrycontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Country ')),),
              SizedBox(height: 20),
              TextFormField(controller: Emailcontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text('Email ')),),
              SizedBox(height: 20),
          
          
              ElevatedButton(onPressed: () {
                _send_data();
              }, child: Text('Submit'))
            ],
          ),
        ),
      ),

    );
  }

  void _get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/coc_view_profile/');
    try {
      final response = await http.post(urls, body: {
        'lid': lid
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          String name = jsonDecode(response.body)['name'].toString();
          String dob = jsonDecode(response.body)['dob'].toString();
          String gender_ = jsonDecode(response.body)['gender'].toString();
          String email = jsonDecode(response.body)['email'].toString();
          String phone = jsonDecode(response.body)['phone'].toString();
          String place = jsonDecode(response.body)['place'].toString();
          String country = jsonDecode(response.body)['country'].toString();
          String city = jsonDecode(response.body)['city'].toString();
          String h_name = jsonDecode(response.body)['h_name'].toString();
          String state = jsonDecode(response.body)['state'].toString();
          String photo = sh.getString("imgurl").toString() + jsonDecode(response.body)['photo'];

          setState(() {
            Namecontroller.text = name;
            DOBcontroller.text = dob;
            gender = gender_;
            Emailcontroller.text = email;
            PhoneNocontroller.text = phone;
            Countrycontroller.text = country;
            Citycontroller.text = city;
            Hnamecontroller.text = h_name;
            Placecontroller.text = place;
            Statecontroller.text = state;
            uphoto = photo;
          });
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
  void _send_data() async{

    String name=Namecontroller.text;
    String dob=DOBcontroller.text;
    String address=PhoneNocontroller.text;
    String place=Citycontroller.text;
    String city=Citycontroller.text;
    String h_name=Hnamecontroller.text;
    String phone=PhoneNocontroller.text;
    String state=Statecontroller.text;
    String country=Countrycontroller.text;
    String email=Emailcontroller.text;




    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();


    final urls = Uri.parse('$url/coc_edit_profile/');
    try {
      final response = await http.post(urls, body: {
        'name':name,
        'dob':dob,
        'gender':gender,
        'address':address,
        'place':place,
        'h_name':h_name,
        'phone':phone,
        'photo':photo,
        'city':city,
        'state':state,
        'country':country,
        'email':email,
        'lid':lid,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Sign up successfull');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ViewCoachProfilePage(title: "View Profile"),));
        }else {
          Fluttertoast.showToast(msg: 'Some errors in the form');
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

  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }

  Future<void> _checkPermissionAndChooseImage() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


}

