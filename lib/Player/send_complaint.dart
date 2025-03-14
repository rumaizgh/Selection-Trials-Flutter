import 'package:flutter/material.dart';

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
      home: const MyLoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});


  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {


  TextEditingController Datecontroller=TextEditingController();
  TextEditingController Complcontroller=TextEditingController();
  TextEditingController Statuscontroller=TextEditingController();
  TextEditingController Replycontroller=TextEditingController();




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


            TextFormField(controller: Datecontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Complaint ')),),
            SizedBox(height: 20),
            TextFormField(controller: Complcontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Complaint ')),),
            SizedBox(height: 20),
            TextFormField(controller: Statuscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Complaint ')),),
            SizedBox(height: 20),
            TextFormField(controller: Replycontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Complaint ')),),
            SizedBox(height: 20),



            ElevatedButton(onPressed: (){}, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
}
