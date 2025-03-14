import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selectiontrialsnew/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coc_home.dart';

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
      home: const CoachSignup(title: 'Flutter Demo Home Page'),
    );
  }
}

class CoachSignup extends StatefulWidget {
  const CoachSignup({super.key, required this.title});


  final String title;

  @override
  State<CoachSignup> createState() => _CoachSignupState();
}

class _CoachSignupState extends State<CoachSignup> {
  String gender = "Male";
  File? uploadimage;


  TextEditingController Namecontroller=TextEditingController();
  TextEditingController Addresscontroller=TextEditingController();
  TextEditingController DOBcontroller=TextEditingController();
  TextEditingController Placecontroller=TextEditingController();
  TextEditingController PhoneNocontroller=TextEditingController();
  TextEditingController Citycontroller=TextEditingController();
  TextEditingController Countrycontroller=TextEditingController();
  TextEditingController Nationalitycontroller=TextEditingController();
  TextEditingController Passwordcontroller=TextEditingController();
  TextEditingController ConfirmPasscontroller=TextEditingController();
  TextEditingController Statecontroller=TextEditingController();
  TextEditingController Emailcontroller=TextEditingController();
  TextEditingController h_namecontroller=TextEditingController();





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
                Image.file(_selectedImage! , height: 400,),
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
                    Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
                    Text('Select Image',style: TextStyle(color: Colors.cyan))
                  ],
                ),
              ),
            },

            TextFormField(controller: Namecontroller, decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Name ')),),
            SizedBox(height: 20),
            RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
            RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
            RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),

            TextFormField(controller: Addresscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Address')),),
            SizedBox(height: 20,),
            TextFormField(controller: Passwordcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Password')),),
            SizedBox(height: 20,),
            TextFormField(controller: ConfirmPasscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Confirm Password')),),
            SizedBox(height: 20,),
            TextFormField(controller: DOBcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('DOB')),),
            SizedBox(height: 20),
            TextFormField(controller: Placecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Place')),),
            SizedBox(height: 20),
            TextFormField(controller: PhoneNocontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Phone NO ')),),
            SizedBox(height: 20),
            TextFormField(controller: Citycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('City ')),),
            SizedBox(height: 20),
            TextFormField(controller: Countrycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Country ')),),
            SizedBox(height: 20),
            TextFormField(controller: Statecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('State ')),),
            SizedBox(height: 20),
            TextFormField(controller: Nationalitycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Nationality ')),),
            SizedBox(height: 20),
            TextFormField(controller: Emailcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Email ')),),
            SizedBox(height: 20),
            TextFormField(controller: h_namecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Hanme ')),),
            SizedBox(height: 20),



            ElevatedButton(onPressed: (){

              _send_data();
            }, child: Text('Submit'))
          ],
        ),
      ),

    ),
    );
  }
  void _send_data() async{

    String name=Namecontroller.text;
    String dob=DOBcontroller.text;
    String address=PhoneNocontroller.text;
    String place=Citycontroller.text;
    String city=Citycontroller.text;
    String genders=gender;
    String h_name=h_namecontroller.text;
    String phone=PhoneNocontroller.text;
    String state=Statecontroller.text;
    String country=Countrycontroller.text;
    String password=Passwordcontroller.text;
    String confirmpassword=ConfirmPasscontroller.text;
    String nationality=Nationalitycontroller.text;
    String email=Emailcontroller.text;
    



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/coc_signup/');
    try {
      final response = await http.post(urls, body: {
        'name':name,
        'dob':dob,
        'gender':genders,
        'address':address,
        'place':place,
        'h_name':h_name,
        'phone':phone,
        'city':city,
        'state':state,
        'country':country,
        'photo':photo,
        'nationality':nationality,
        'password':password,
        'confirmpassword':confirmpassword,
        'email':email,


      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Sign up successfull');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => myloginpage(title: "Login"),));
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

String photo = "";
}
