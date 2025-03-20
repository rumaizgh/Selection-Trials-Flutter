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
import 'package:http_parser/http_parser.dart'; // Added import for MediaType
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UploadVideoPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class UploadVideoPage extends StatefulWidget {
  const UploadVideoPage({super.key, required this.title});

  final String title;

  @override
  State<UploadVideoPage> createState() => _UploadVideoPageState();
}

class _UploadVideoPageState extends State<UploadVideoPage> {
  File? _selectedVideo;
  VideoPlayerController? _videoController;
  String? _encodedVideo;
  TextEditingController videoTitleController = TextEditingController();
  TextEditingController videoDetailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
            // Display video player or placeholder
            if (_selectedVideo != null) ...[
              InkWell(
                child: Container(
                  height: 400,
                  width: double.infinity,
                  child: VideoPlayer(_videoController!),
                ),
                onTap: _checkPermissionAndChooseVideo,
              ),
            ] else ...[
              InkWell(
                onTap: _checkPermissionAndChooseVideo,
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),
                      height: 200,
                      width: 200,
                    ),
                    Text(
                      'Select Video',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],

            // Text fields for video title and details
            TextFormField(
              controller: videoTitleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Video Title')),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: videoDetailsController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Video Details')),
            ),
            SizedBox(height: 20),

            // Submit button
            ElevatedButton(
                onPressed: () {
                  sendData();
                },
                child: Text('Submit')),
          ],
        ),
      ),
    );
  }

  Future<void> sendData() async {
    String videoTitle = videoTitleController.text;
    String videoDetails = videoDetailsController.text;

    if (_selectedVideo == null) {
      Fluttertoast.showToast(msg: 'Please select a video first');
      return;
    }

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final uri = Uri.parse('$url/coc_upload_videos/');
    var request = http.MultipartRequest('POST', uri);

    // Add text fields
    request.fields['videotitle'] = videoTitle;
    request.fields['videodetails'] = videoDetails;
    request.fields['lid'] = lid;

    // Add video file
    request.files.add(await http.MultipartFile.fromPath(
      'videofile', // This key must match what your server expects
      _selectedVideo!.path,
      contentType: MediaType('video', 'mp4'), // Now works with http_parser import
    ));

    try {
      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(respStr);

      if (response.statusCode == 200 && jsonResponse['status'] == 'ok') {
        Fluttertoast.showToast(msg: 'Video Uploaded Successfully');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ViewCertificatePage(title: 'View Labour')),
        );
      } else {
        Fluttertoast.showToast(msg: 'Error: ${jsonResponse['status']}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }

  Future<void> _checkPermissionAndChooseVideo() async {
    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadVideo();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please grant permission to access videos.',
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

  Future<void> _chooseAndUploadVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      setState(() {
        _selectedVideo = File(pickedVideo.path);
        _videoController?.dispose(); // Dispose previous controller if exists
        _videoController = VideoPlayerController.file(_selectedVideo!)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      });
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    videoTitleController.dispose();
    videoDetailsController.dispose();
    super.dispose();
  }
}