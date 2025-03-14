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

  TextEditingController CertificatetypeController=TextEditingController();
  TextEditingController FileController=TextEditingController();
  TextEditingController DateController=TextEditingController();




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

            TextFormField(controller: CertificatetypeController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Name ')),),
            SizedBox(height: 20),
            TextFormField(controller:FileController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
            SizedBox(height: 20),
            TextFormField(controller:DateController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
            SizedBox(height: 20),


            ElevatedButton(onPressed: (){}, child: Text('Submit'))
          ],
        ),
      ),

    );
  }
}
