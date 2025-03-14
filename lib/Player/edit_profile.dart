import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selectiontrialsnew/Player/view_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Coach/view_profile.dart';

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

  TextEditingController Namecontroller=TextEditingController();
  TextEditingController DOBcontroller=TextEditingController();
  TextEditingController Heightcontroller=TextEditingController();
  TextEditingController h_namecontroller=TextEditingController();
  TextEditingController Weightcontroller=TextEditingController();
  TextEditingController Addresscontroller=TextEditingController();
  TextEditingController Placecontroller=TextEditingController();
  TextEditingController Citycontroller=TextEditingController();
  TextEditingController Statecontroller=TextEditingController();
  TextEditingController Countrycontroller=TextEditingController();
  TextEditingController Emailcontroller=TextEditingController();
  TextEditingController PhoneNocontroller=TextEditingController();


  String gender = 'Male';
  String photo='';
  String uphoto='';




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

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

              TextFormField(controller: Namecontroller,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Name ')),),
              SizedBox(height: 20),

              RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
              RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
              RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
              SizedBox(height: 20),
              TextFormField(controller:Heightcontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
              SizedBox(height: 20),
              TextFormField(controller:Weightcontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Weight')),),
              SizedBox(height: 20),
              TextFormField(controller:DOBcontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('DOB')),),
              SizedBox(height: 20),
              TextFormField(controller:h_namecontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('h_name')),),
              SizedBox(height: 20),
              TextFormField(controller: Placecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Place')),),
              SizedBox(height: 20),
              TextFormField(controller: PhoneNocontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Phone NO ')),),
              SizedBox(height: 20),
              TextFormField(controller: Citycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('City ')),),
              SizedBox(height: 20),
              TextFormField(controller: Statecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('State ')),),
              SizedBox(height: 20),
              TextFormField(controller: Countrycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Country ')),),
              SizedBox(height: 20),
              TextFormField(controller: Emailcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Email ')),),
              SizedBox(height: 20),



              ElevatedButton(onPressed: (){
                _send_data1();
              }, child: Text('Submit'))
            ],
          ),
        ),
      ),

    );
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

  void _get_data() async{



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
          String height=jsonDecode(response.body)['height'].toString();
          String weight=jsonDecode(response.body)['weight'].toString();
          String gender_=jsonDecode(response.body)['gender'].toString();
          String dob=jsonDecode(response.body)['dob'].toString();
          String h_name=jsonDecode(response.body)['h_name'].toString();
          String email=jsonDecode(response.body)['email'].toString();
          String phone=jsonDecode(response.body)['phone'].toString();
          String state=jsonDecode(response.body)['state'].toString();
          String city=jsonDecode(response.body)['city'].toString();
          String place=jsonDecode(response.body)['place'].toString();
          String country=jsonDecode(response.body)['country'].toString();
          String photo=sh.getString("imgurl").toString()+jsonDecode(response.body)['photo'];

          setState(() {

            Namecontroller.text= name;
            Heightcontroller.text= height;
            Weightcontroller.text= weight;
            DOBcontroller.text= dob;
            Placecontroller.text= place;
            PhoneNocontroller.text= phone;
            h_namecontroller.text= h_name;
            Citycontroller.text= city;
            Statecontroller.text= state;
            Countrycontroller.text= country;
            Emailcontroller.text= email;
            uphoto= photo;
            gender=gender_;
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


  void _send_data1() async{


    String name=Namecontroller.text;
    String genders=gender;
    String dob=DOBcontroller.text;
    String height=Heightcontroller.text;
    String h_name=h_namecontroller.text;
    String weight=Weightcontroller.text;
    String address=Addresscontroller.text;
    String place=Placecontroller.text;
    String city=Citycontroller.text;
    String state=Statecontroller.text;
    String country=Countrycontroller.text;
    String email=Emailcontroller.text;
    String phone=PhoneNocontroller.text;




    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/ply_edit_profile/');
    try {
      final response = await http.post(urls, body: {
        'name':name,
        'dob':dob,
        'gender':genders,
        'photo':photo,
        'height':height,
        'weight':weight,
        'address':address,
        'h_name':h_name,
        'place':place,
        'city':city,
        'state':state,
        'country':country,
        'email':email,
        'phone':phone,
        'lid':lid,

      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Sign up successfull');
          Navigator.push(context , MaterialPageRoute(
            builder: (context) => ViewPlayerProfile(title: "Submit"),));
        }else {
          Fluttertoast.showToast(msg: 'Email Already exists');
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
