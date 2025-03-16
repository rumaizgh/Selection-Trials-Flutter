import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selectiontrialsnew/Coach/view_certificate.dart';
import 'package:selectiontrialsnew/Player/view_certificate_of_coach.dart';
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
      home: const AddCertificatePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class AddCertificatePage extends StatefulWidget {
  const AddCertificatePage({super.key, required this.title});


  final String title;


  @override
  State<AddCertificatePage> createState() => _AddCertificatePageState();
}

class _AddCertificatePageState extends State<AddCertificatePage> {

  File? uploadimage;


  TextEditingController CertificatetypeController=TextEditingController();




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(





        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            if (_selectedImage != null) ...{
              InkWell(
                child:
                Image.file(_selectedImage!, height: 400,),
                radius: 399,
                onTap: _checkPermissionAndChooseImage,
              ),
            } else ...{
              InkWell(
                onTap: _checkPermissionAndChooseImage,
                child:Column(
                  children: [
                    Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
                    Text('Select Image',style: TextStyle(color: Colors.red))
                  ],
                ),
              ),
            },


            TextFormField(controller: CertificatetypeController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Name ')),),
            SizedBox(height: 20),



            ElevatedButton(onPressed: (){
              send_data();
            }, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
  Future<void> send_data() async {
    String certificate_type = CertificatetypeController.text;




    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/coc_add_certificate/');
    try {
      final response = await http.post(urls, body: {
        'certificate_type':certificate_type,
        'file':file,
        'lid':lid,



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Added Successfully');
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewCertificatePage(title: 'View Labour ',)));
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
        file = _encodedImage.toString();
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
  String file = '';
}

