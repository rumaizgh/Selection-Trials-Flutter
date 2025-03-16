import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:selectiontrialsnew/Player/player_home.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const ViewReview());
}

class ViewReview extends StatelessWidget {
  const ViewReview({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewReviewPage(title: 'View Reply'),
    );
  }
}

class ViewReviewPage extends StatefulWidget {
  const ViewReviewPage({super.key, required this.title});

  final String title;

  @override
  State<ViewReviewPage> createState() => _ViewReviewPageState();
}

class _ViewReviewPageState extends State<ViewReviewPage> {

  _ViewReviewPageState(){
    ViewReview();
  }

  List<String> id_ = <String>[];
  List<String> review_= <String>[];
  List<String> rating_= <String>[];
  List<String> date_= <String>[];
  List<String> player_= <String>[];


  Future<void> ViewReview() async {
    List<String> id = <String>[];
    List<String> review= <String>[];
    List<String> rating= <String>[];
    List<String> date= <String>[];
    List<String> player= <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/coc_view_reviews/';

      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        review.add(arr[i]['review'].toString());
        rating.add(arr[i]['rating'].toString());
        date.add(arr[i]['date'].toString());
        player.add(arr[i]['player'].toString());

      }

      setState(() {
        id_ = id;
        review_ = review;
        rating_ = rating;
        date_ = date;
        player_ = player;

      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }




  @override
  Widget build(BuildContext context) {



    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton( onPressed:() {

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeNewPage(title: 'Home',)),);

          },),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
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
                        child:
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Review"),
                                  Text(review_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Rating "),

                                  Text(rating_[index]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Date"),

                                  Text(date_[index]),
                                ],
                              ),
                            ), Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Player Name"),

                                  Text(player_[index]),
                                ],
                              ),
                            ),



                          ],
                        )


                        ,
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  )),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => MySendtip_description()));

        },
          child: Icon(Icons.plus_one),
        ),


      ),
    );
  }
}
