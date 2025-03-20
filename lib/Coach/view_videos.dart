import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Coach/chat_with_player.dart';
import 'package:selectiontrialsnew/Coach/edit_certificate.dart';
import 'package:selectiontrialsnew/Coach/send_complaint.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'coc_home.dart';

void main() {
  runApp(const ViewVideo(title: '',));
}

class ViewVideo extends StatelessWidget {
  const ViewVideo({super.key, req, required String title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Certificate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewVideoPage(title: 'View Certificate'),
    );
  }
}

class ViewVideoPage extends StatefulWidget {
  const ViewVideoPage({super.key, required this.title});

  final String title;

  @override
  State<ViewVideoPage> createState() => _ViewVideoPageState();
}

class _ViewVideoPageState extends State<ViewVideoPage> {

  // State variables for storing video data
  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> video_detail_ = <String>[];
  List<String> video_title_ = <String>[];
  List<String> video_ = <String>[];

  // Function to load videos from the backend
  Future<void> viewVideo() async {
    try {
      // Show a loading spinner or some indication that the data is being loaded
      Fluttertoast.showToast(msg: "Loading videos... Please wait.", toastLength: Toast.LENGTH_SHORT);

      // Get shared preferences
      SharedPreferences sh = await SharedPreferences.getInstance();
      String baseUrl = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String imgUrl = sh.getString('imgurl') ?? '';

      // Construct the API endpoint
      String url = '$baseUrl/coc_view_videos/';

      // Make the HTTP POST request
      var response = await http.post(
        Uri.parse(url),
        body: {'lid': lid},
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Decode the JSON response
        var jsonData = json.decode(response.body);
        String status = jsonData['status'];

        if (status == "success") {
          var videoData = jsonData["data"];

          // Temporary lists to store video data
          List<String> tempIds = [];
          List<String> tempDates = [];
          List<String> tempTitles = [];
          List<String> tempDetails = [];
          List<String> tempVideos = [];

          // Populate the lists with video data
          for (var item in videoData) {
            tempIds.add(item['id'].toString());
            tempDates.add(item['date'].toString());
            tempTitles.add(item['videotitle'].toString());
            tempDetails.add(item['videodetails'].toString());
            tempVideos.add('$imgUrl${item['videofile']}');
          }

          // Update state with new data
          setState(() {
            id_ = tempIds;
            date_ = tempDates;
            video_title_ = tempTitles;
            video_detail_ = tempDetails;
            video_ = tempVideos;
          });

          Fluttertoast.showToast(msg: "Videos loaded successfully.", toastLength: Toast.LENGTH_SHORT);
        } else {
          Fluttertoast.showToast(
            msg: "Failed to load videos: ${jsonData['message']}",
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Network Error: Failed to retrieve data.",
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      print("Error loading videos: $e");
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    viewVideo();  // Call to load the videos when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async { return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CoachHomePage(title: 'Chat Page',)),
            );
          }),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Card(
                      child: Row(
                        children: [
                          Image(image: NetworkImage(video_[index]), height: 100, width: 100,),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Title"),
                                    Text(video_title_[index]),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Details"),
                                    Text(video_detail_[index]),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences sh = await SharedPreferences.getInstance();
                                  sh.setString("achid", id_[index]);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditCertificate(title: ''),
                                    ),
                                  );
                                },
                                child: Text('Edit'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      elevation: 8,
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MySendComplaintPage(title: 'SendComplaint')),
            );
          },
          child: Icon(Icons.plus_one),
        ),
      ),
    );
  }
}
