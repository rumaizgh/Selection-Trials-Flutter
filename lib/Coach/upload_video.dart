// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const Myvideopage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class Myvideopage extends StatefulWidget {
//   const Myvideopage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<Myvideopage> createState() => _MyvideopageState();
// }
//
// class _MyvideopageState extends State<Myvideopage> {
//
//   TextEditingController DateController=TextEditingController();
//   TextEditingController VideotitleController=TextEditingController();
//   TextEditingController VideofileController=TextEditingController();
//   TextEditingController VideodetailsController=TextEditingController();
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//
//             TextFormField(controller: DateController,decoration: InputDecoration(border: OutlineInputBorder(), label: Text('Name ')),),
//             SizedBox(height: 20),
//             TextFormField(controller:VideotitleController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
//             SizedBox(height: 20),
//             TextFormField(controller:VideofileController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
//             SizedBox(height: 20),
//             TextFormField(controller:VideodetailsController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
//             SizedBox(height: 20),
//
//
//
//             ElevatedButton(onPressed: (){}, child: Text('Submit'))
//           ],
//         ),
//       ),
//
//     );
//   }
// }
