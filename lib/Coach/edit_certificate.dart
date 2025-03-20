import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:selectiontrialsnew/Coach/view_certificate.dart';
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
      home: const EditCertificate(title: 'Flutter Demo Home Page'),
    );
  }
}

class EditCertificate extends StatefulWidget {
  const EditCertificate({super.key, required this.title});



  final String title;

  @override
  State<EditCertificate> createState() => _EditCertificateState();
}

class _EditCertificateState extends State<EditCertificate> {

  _EditCertificateState(){
    _view_data();
  }
  TextEditingController CertificateTypeController = TextEditingController();
  TextEditingController PhotoController = TextEditingController();



  String name_="";
  String cphoto_="";

  void _view_data() async{



    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String id = sh.getString('achid').toString();

    final urls = Uri.parse('$url/coc_edit_certificate_get/');
    try {
      final response = await http.post(urls, body: {
        'lid':lid,
        'id':id



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          String name=jsonDecode(response.body)['name'].toString();
          String photo=sh.getString("imgurl").toString()+jsonDecode(response.body)['photo'];

          setState(() {

            CertificateTypeController.text= name;
            cphoto_= photo;
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
  
  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //
  //     _counter++;
  //   });
  // }
  String lphoto='';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(

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
                      Image(image: NetworkImage(cphoto_),height: 200,width: 200,),
                      Text('Select Image',style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },
              TextFormField(decoration: InputDecoration(labelText: 'name',
                  border: OutlineInputBorder
                    (borderRadius: BorderRadius.circular(20))),controller: CertificateTypeController,),
              SizedBox(height: 30,),


              ElevatedButton(onPressed: (){
                _send_data();
              }, child: Text('Update'))

            ],
          ),
        ),
      ),

      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  // Future<void> addlab() async {
  //   String name = CertificateTypeController.text;
  //
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   String url = sh.getString('url').toString();
  //   String lid = sh.getString('lid').toString();
  //
  //
  //
  //
  //
  //   photo = sh.getString('photo').toString();
  //   name = sh.getString('name').toString();
  //
  //
  //
  //
  //
  //
  //
  // }


  File? _selectedImage;
  String? _encodedImage;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo_ = _encodedImage.toString();
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

  String photo_="";






  void _send_data() async{


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String id = sh.getString('achid').toString();
    String img = sh.getString('imgurl').toString();

    final urls = Uri.parse('$url/coc_edit_certificate/');
    try {
      final response = await http.post(urls, body: {
        // 'lid':lid,
        'id':id,
        'photo':photo_,
        'name':CertificateTypeController.text,



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          // String name=jsonDecode(response.body)['name'].toString();
          // String photo=img+jsonDecode(response.body)['photo'].toString();
          //

          // setState(() {
          //
          //   CertificateTypeController.text= name;
          //   lphoto= photo;
          // });
          Fluttertoast.showToast(msg: 'Edited successfully');
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCertificatePage(title: "title")));





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
