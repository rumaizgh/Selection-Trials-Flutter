import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selectiontrialsnew/Player/player_home.dart';
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
      home: const PlayerSignup(title: 'Flutter Demo Home Page'),
    );
  }
}

class PlayerSignup extends StatefulWidget {
  const PlayerSignup({super.key, required this.title});


  final String title;

  @override
  State<PlayerSignup> createState() => _PlayerSignupState();
}

class _PlayerSignupState extends State<PlayerSignup> {
  String gender = "Male";
  File? uploadimage;
  String photo = '';

  TextEditingController Namecontroller=TextEditingController();
  TextEditingController DOBcontroller=TextEditingController();
  TextEditingController Heightcontroller=TextEditingController();
  TextEditingController Weightcontroller=TextEditingController();
  TextEditingController Addresscontroller=TextEditingController();
  TextEditingController Hnamecontroller=TextEditingController();
  TextEditingController Placecontroller=TextEditingController();
  TextEditingController Citycontroller=TextEditingController();
  TextEditingController Statecontroller=TextEditingController();
  TextEditingController Nationalitycontroller=TextEditingController();
  TextEditingController Emailcontroller=TextEditingController();
  TextEditingController Countrycontroller=TextEditingController();
  TextEditingController PhoneNocontroller=TextEditingController();
  TextEditingController Passwordocontroller=TextEditingController();
  TextEditingController Confirmcontroller=TextEditingController();




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        // child: SingleChildScrollView(
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
                        Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
                        Text('Select Image',style: TextStyle(color: Colors.cyan))
                      ],
                    ),
                  ),
                },
                TextFormField(controller: Namecontroller,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Name ')),),
                SizedBox(height: 20),
                TextFormField(controller:Heightcontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
                SizedBox(height: 20),
                TextFormField(controller:Weightcontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Weight')),),
                SizedBox(height: 20),
                TextFormField(controller: Addresscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Address')),),
                SizedBox(height: 20,),

                RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
                RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
                RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),

                TextFormField(controller:DOBcontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('DOB')),),
                SizedBox(height: 20),
                TextFormField(controller: Placecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Place')),),
                SizedBox(height: 20),
                TextFormField(controller: PhoneNocontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Phone NO ')),),
                SizedBox(height: 20),
                TextFormField(controller: Hnamecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('h_name')),),
                SizedBox(height: 20),
                TextFormField(controller: Citycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('City ')),),
                SizedBox(height: 20),
                TextFormField(controller: Statecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('State ')),),
                SizedBox(height: 20),
                TextFormField(controller: Countrycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Country ')),),
                SizedBox(height: 20),
                TextFormField(controller:Nationalitycontroller ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Nationality ')),),
                SizedBox(height: 20),
                TextFormField(controller: Emailcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Email ')),),
                SizedBox(height: 20),
                TextFormField(controller: Passwordocontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Password ')),),
                SizedBox(height: 20),
                TextFormField(controller: Confirmcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Confirm Password ')),),
                SizedBox(height: 20),
            
            
            
                ElevatedButton(onPressed: (){
            
                  _send_data();
                }, child: Text('Submit'))
              ],
            ),
          ),
      )
    );

  }

  void _send_data() async{


    String name=Namecontroller.text;
    String genders=gender;
    String dob=DOBcontroller.text;
    String height=Heightcontroller.text;
    String h_name=Hnamecontroller.text;
    String weight=Weightcontroller.text;
    String address=Addresscontroller.text;
    String place=Placecontroller.text;
    String city=Citycontroller.text;
    String country=Countrycontroller.text;
    String state=Statecontroller.text;
    String nationality=Nationalitycontroller.text;
    String email=Emailcontroller.text;
    String phone=PhoneNocontroller.text;
    String passw=Passwordocontroller.text;
    String confirm=Confirmcontroller.text;



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/ply_signup/');
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
        'nationality':nationality,
        'email':email,
        'phone':phone,
        'password':passw,
        'confirmpassword':confirm,

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



}


