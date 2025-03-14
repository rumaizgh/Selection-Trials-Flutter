import 'package:flutter/material.dart';
import 'package:selectiontrialsnew/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController ipcontrol = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller:ipcontrol,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text('IP Address')),),
            ElevatedButton(onPressed: (){

              send_data();
            }, child: Text('connect'))




          ],
        ),
      ),

    );
  }


    Future<void> send_data() async {
      String ip = ipcontrol.text;
      SharedPreferences sh = await SharedPreferences.getInstance();

      sh.setString("url", "http://"+ip+":8000/myapp");
      sh.setString("imgurl", "http://"+ip+":8000");

      Navigator.push(context, MaterialPageRoute(builder: (context) => myloginpage(title:'',),));
    }



}
