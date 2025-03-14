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


  TextEditingController DateController=TextEditingController();
  TextEditingController ReviewController=TextEditingController();
  TextEditingController RatingController=TextEditingController();




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


            TextFormField(controller: DateController,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Review about academy')),),
            SizedBox(height: 20),
            TextFormField(controller: ReviewController,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Review about academy')),),
            SizedBox(height: 20),
            TextFormField(controller: RatingController,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Review about academy')),),
            SizedBox(height: 20),



            ElevatedButton(onPressed: (){}, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
}
