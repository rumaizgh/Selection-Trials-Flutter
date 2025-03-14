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
      home: const Mychangepasspage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Mychangepasspage extends StatefulWidget {
  const Mychangepasspage({super.key, required this.title});


  final String title;

  @override
  State<Mychangepasspage> createState() => _MychangepasspageState();
}

class _MychangepasspageState extends State<Mychangepasspage> {

  TextEditingController CurrentPasscontroller=TextEditingController();
  TextEditingController NewPasscontroller=TextEditingController();
  TextEditingController ConfirmPasscontroller=TextEditingController();


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

            TextFormField(controller: CurrentPasscontroller, decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Current Password')),),
            SizedBox(height: 20),
            TextFormField(controller: NewPasscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('New Password')),),
            SizedBox(height: 20,),
            TextFormField(controller: ConfirmPasscontroller,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Confirm Password')),),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){}, child: Text('Submit'))
          ],
        ),
      ),

    );
  }




}
