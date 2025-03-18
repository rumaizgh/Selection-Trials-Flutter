// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:selectiontrialsnew/Coach/coc_home.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:video_player/video_player.dart';
// // import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:path_provider/path_provider.dart';
//
//
// class Myvideopage extends StatefulWidget {
//   @override
//   _MyvideopageState createState() => _MyvideopageState();
// }
//
// class _MyvideopageState extends State<Myvideopage> {
//   // Selected media files
//   File? _selectedImage1;
//   File? _selectedImage2;
//   File? _selectedVideo;
//
//   // Video thumbnail
//   File? _videoThumbnail;
//
//   // Loading state
//   bool _isUploading = false;
//
//   // Video player controller for preview
//   VideoPlayerController? _videoController;
//   TextEditingController VideotitleController=TextEditingController();
//   TextEditingController VideodetailsController=TextEditingController();
//   bool _videoInitialized = false;
//
//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Upload Media"),
//         backgroundColor: Colors.cyan,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.white, Colors.grey.shade100],
//           ),
//         ),
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(24),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     // Title
//                     Padding(
//                       padding: EdgeInsets.only(bottom: 24),
//                       child: Text(
//                         "Upload Media",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//
//                     // Media selection section
//
//                     TextFormField(controller:VideotitleController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
//
//                     TextFormField(controller:VideodetailsController ,decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Height ')),),
//
//
//                     SizedBox(height: 24),
//
//                     // Video picker section
//                     Center(
//                       child: _buildVideoSelector(
//                         title: "Demo Video",
//                         videoFile: _selectedVideo,
//                         thumbnailFile: _videoThumbnail,
//                         onTap: _pickVideo,
//                         icon: Icons.videocam,
//                       ),
//                     ),
//
//                     SizedBox(height: 32),
//
//                     // Submit button
//                     Container(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: _isUploading ? null : _submitMedia,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.cyan,
//                           padding: EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           elevation: 2,
//                         ),
//                         child: Text(
//                           _isUploading ? 'Uploading...' : 'Submit',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Show loading indicator when uploading
//             if (_isUploading)
//               Container(
//                 color: Colors.black.withOpacity(0.3),
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         "Uploading media...",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Helper method for checking permissions and choosing image
//   Future<void> _checkPermissionAndChooseImage(int imageNum) async {
//     final PermissionStatus status = await Permission.mediaLibrary.request();
//     if (status.isGranted) {
//       if (imageNum == 1) {
//         _chooseImage1();
//       } else {
//         _chooseImage2();
//       }
//     } else {
//       try {
//         final result = await ImagePicker().pickVideo(
//           source: ImageSource.gallery,
//
//         );
//         if (result != null) {
//           final videoFile = File(result.path);
//
//           // Generate thumbnail
//           final thumbnailPath = await VideoThumbnail.thumbnailFile(
//             video: videoFile.path,
//             imageFormat: ImageFormat.JPEG,
//             quality: 75,
//           );
//
//           setState(() {
//             _selectedVideo = videoFile;
//             if (thumbnailPath != null) {
//               _videoThumbnail = File(thumbnailPath);
//             }
//           });
//
//           // Initialize video player for preview
//           _initializeVideoPlayer(videoFile);
//         }
//       } catch (e) {
//         print("Error picking video: $e");
//         Fluttertoast.showToast(msg: "Error selecting video. Please try again.");
//       }
//       // _showPermissionDialog("media library");
//     }
//   }
//
//   // Helper method for choosing first image
//   Future<void> _chooseImage1() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1024, // Limit image size for better performance
//       maxHeight: 1024,
//       imageQuality: 85, // Reduce quality slightly to save space
//     );
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage1 = File(pickedImage.path);
//       });
//     }
//   }
//
//   // Helper method for choosing second image
//   Future<void> _chooseImage2() async {
//     final picker = ImagePicker();
//     final pickedImage = await picker.pickImage(
//       source: ImageSource.gallery,
//       maxWidth: 1024,
//       maxHeight: 1024,
//       imageQuality: 85,
//     );
//
//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage2 = File(pickedImage.path);
//       });
//     }
//   }
//
//   // Helper method for picking video
//   Future<void> _pickVideo() async {
//     final status = await Permission.storage.request();
//     if (status.isGranted) {
//       try {
//         final result = await ImagePicker().pickVideo(
//           source: ImageSource.gallery,
//           maxDuration: const Duration(minutes: 2),
//         );
//         if (result != null) {
//           final videoFile = File(result.path);
//
//           // Generate thumbnail
//           final thumbnailPath = await VideoThumbnail.thumbnailFile(
//             video: videoFile.path,
//             imageFormat: ImageFormat.JPEG,
//             quality: 75,
//           );
//
//           setState(() {
//             _selectedVideo = videoFile;
//             if (thumbnailPath != null) {
//               _videoThumbnail = File(thumbnailPath);
//             }
//           });
//
//           // Initialize video player for preview
//           _initializeVideoPlayer(videoFile);
//         }
//       } catch (e) {
//         print("Error picking video: $e");
//         Fluttertoast.showToast(msg: "Error selecting video. Please try again.");
//       }
//     } else {
//       // _showPermissionDialog("storage");
//     }
//   }
//
//   // Initialize video player
//   Future<void> _initializeVideoPlayer(File videoFile) async {
//     _videoController = VideoPlayerController.file(videoFile);
//     await _videoController!.initialize();
//     setState(() {
//       _videoInitialized = true;
//     });
//   }
//
//   // Helper method for image selectors
//   Widget _buildMediaSelector({
//     required String title,
//     required File? image,
//     required String placeholder,
//     required VoidCallback onTap,
//     required IconData icon,
//   }) {
//     return Container(
//       width: 150,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(16),
//             child: Container(
//               height: 120,
//               width: 150,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: image != null
//                   ? ClipRRect(
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 child: Image.file(
//                   image,
//                   height: 120,
//                   width: 150,
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     icon,
//                     size: 40,
//                     color: Colors.cyan,
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Tap to select",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(12),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper method for video selector
//   Widget _buildVideoSelector({
//     required String title,
//     required File? videoFile,
//     required File? thumbnailFile,
//     required VoidCallback onTap,
//     required IconData icon,
//   }) {
//     return Container(
//       width: 250,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(16),
//             child: Container(
//               height: 150,
//               width: 250,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade50,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: videoFile != null
//                   ? Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Video thumbnail
//                   thumbnailFile != null
//                       ? ClipRRect(
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(16),
//                     ),
//                     child: Image.file(
//                       thumbnailFile,
//                       width: double.infinity,
//                       height: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                       : Container(
//                     color: Colors.black87,
//                     width: double.infinity,
//                     height: double.infinity,
//                   ),
//                   Icon(
//                     Icons.play_circle_fill,
//                     size: 50,
//                     color: Colors.white,
//                   ),
//                   Positioned(
//                     bottom: 8,
//                     right: 8,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.black54,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         "Video Selected",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//                   : Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     icon,
//                     size: 50,
//                     color: Colors.cyan,
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     "Tap to select video",
//                     style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(12),
//             child: Text(
//               title,
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black87,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Show permission dialog
//   // void _showPermissionDialog(String permissionType) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) =>
//   //         AlertDialog(
//   //           title: Text("Permission Required"),
//   //           content: Text(
//   //               "$permissionType permission is needed to select media from your device."),
//   //           actions: [
//   //             TextButton(
//   //               onPressed: () => Navigator.pop(context),
//   //               child: Text("OK"),
//   //             ),
//   //           ],
//   //         ),
//   //   );
//   // }
//
//   // Submit media method using multipart form data
//   Future<void> _submitMedia() async {
//     String title=VideotitleController.text;
//     String details=VideodetailsController.text;
//
//     // Validate required fields
//     if (_selectedImage1 == null || _selectedImage2 == null
//     // ||
//     // _selectedVideo == null
//     ) {
//       Fluttertoast.showToast(msg: "Please select all required media files");
//       return;
//     }
//
//     // Set uploading state
//     setState(() {
//       _isUploading = true;
//     });
//
//     try {
//       // Get stored server URL and user ID
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       if (url.isEmpty || lid.isEmpty) {
//         Fluttertoast.showToast(
//             msg: "Missing server information. Please login again.");
//         setState(() {
//           _isUploading = false;
//         });
//         return;
//       }
//
//       // Prepare the API endpoint
//
//       print(url);
//       print("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
//       final uploadUrl = Uri.parse('$url/coc_upload_videos/');
//
//
//       // Create a multipart request for all files
//       var request = http.MultipartRequest('POST', uploadUrl);
//
//       // Add text fields
//       request.fields['lid'] = lid;
//
//       // Add all files as multipart
//       request.fields['video_title']=title;
//       request.fields['video_details']=details;
//
//       request.files.add(
//           await http.MultipartFile.fromPath('video_file', _selectedVideo!.path)
//       );
//
//       try {
//         var response = await request.send();
//
//         if (response.statusCode == 200) {
//           Fluttertoast.showToast(msg: "Video uploaded successfully!");
//           print('Video uploaded successfully!');
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>CoachHomePage(title: '',)));
//         } else {
//           print('Failed to upload video: ${response.statusCode}');
//         }
//       } catch (e) {
//         print('Error uploading video: $e');
//       }
//     }
//     catch (e) {
//       print("Error picking video: $e");
//       Fluttertoast.showToast(msg: "Error selecting video. Please try again.");
//     }
//   }
// }
//
// // class Myvideopage extends StatefulWidget {
// //   @override
// //   _MyvideopageState createState() => _MyvideopageState();
// // }
// //
// // class _MyvideopageState extends State<Myvideopage> {
// //   // Selected media files
// //   File? _selectedImage1;
// //   File? _selectedImage2;
// //   File? _selectedVideo;
// //
// //   // Base64 encoded strings
// //   String? _encodedImage1;
// //   String? _encodedImage2;
// //   String? _encodedVideo;
// //
// //   // Video thumbnail
// //   File? _videoThumbnail;
// //
// //   // Loading state
// //   bool _isUploading = false;
// //
// //
// //
// //   // Video player controller for preview
// //   VideoPlayerController? _videoController;
// //   bool _videoInitialized = false;
// //
// //   @override
// //   void dispose() {
// //     _videoController?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Upload Media"),
// //         backgroundColor: Colors.cyan,
// //       ),
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [Colors.white, Colors.grey.shade100],
// //           ),
// //         ),
// //         child: Stack(
// //           children: [
// //             SingleChildScrollView(
// //               child: Padding(
// //                 padding: EdgeInsets.all(24),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: <Widget>[
// //                     // Title
// //                     Padding(
// //                       padding: EdgeInsets.only(bottom: 24),
// //                       child: Text(
// //                         "Upload Media",
// //                         style: TextStyle(
// //                           fontSize: 24,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                     ),
// //
// //
// //
// //                     // Media selection section
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                       children: [
// //                         // First image picker
// //                         _buildMediaSelector(
// //                           title: "Photo1",
// //                           image: _selectedImage1,
// //                           placeholder: 'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png',
// //                           onTap: () => _checkPermissionAndChooseImage(1),
// //                           icon: Icons.image,
// //                         ),
// //
// //                         // Second image picker
// //                         _buildMediaSelector(
// //                           title: "photo2",
// //                           image: _selectedImage2,
// //                           placeholder: 'https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png',
// //                           onTap: () => _checkPermissionAndChooseImage(2),
// //                           icon: Icons.document_scanner,
// //                         ),
// //                       ],
// //                     ),
// //
// //                     SizedBox(height: 24),
// //
// //                     // Video picker section
// //                     Center(
// //                       child: _buildVideoSelector(
// //                         title: "Demo Video",
// //                         videoFile: _selectedVideo,
// //                         thumbnailFile: _videoThumbnail,
// //                         onTap: _pickVideo,
// //                         icon: Icons.videocam,
// //                       ),
// //                     ),
// //
// //                     SizedBox(height: 32),
// //
// //                     // Submit button
// //                     Container(
// //                       width: double.infinity,
// //                       child: ElevatedButton(
// //                         onPressed: _isUploading ? null : _submitMedia,
// //                         style: ElevatedButton.styleFrom(
// //                           primary: Colors.cyan,
// //                           padding: EdgeInsets.symmetric(vertical: 16),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(12),
// //                           ),
// //                           elevation: 2,
// //                         ),
// //                         child: Text(
// //                           _isUploading ? 'Uploading...' : 'Submit',
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             // Show loading indicator when uploading
// //             if (_isUploading)
// //               Container(
// //                 color: Colors.black.withOpacity(0.3),
// //                 child: Center(
// //                   child: Column(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       CircularProgressIndicator(
// //                         valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
// //                       ),
// //                       SizedBox(height: 16),
// //                       Text(
// //                         "Uploading media...",
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Helper method for checking permissions and choosing image
// //   Future<void> _checkPermissionAndChooseImage(int imageNum) async {
// //     final PermissionStatus status = await Permission.mediaLibrary.request();
// //     if (status.isGranted) {
// //       if (imageNum == 1) {
// //         _chooseAndEncodeImage1();
// //       } else {
// //         _chooseAndEncodeImage2();
// //       }
// //     } else {
// //       _showPermissionDialog("media library");
// //     }
// //   }
// //
// //   // Helper method for choosing and encoding first image
// //   Future<void> _chooseAndEncodeImage1() async {
// //     final picker = ImagePicker();
// //     final pickedImage = await picker.pickImage(
// //       source: ImageSource.gallery,
// //       maxWidth: 1024, // Limit image size for better performance
// //       maxHeight: 1024,
// //       imageQuality: 85, // Reduce quality slightly to save space
// //     );
// //
// //     if (pickedImage != null) {
// //       setState(() {
// //         _selectedImage1 = File(pickedImage.path);
// //         _encodedImage1 = base64Encode(_selectedImage1!.readAsBytesSync());
// //       });
// //     }
// //   }
// //
// //   // Helper method for choosing and encoding second image
// //   Future<void> _chooseAndEncodeImage2() async {
// //     final picker = ImagePicker();
// //     final pickedImage = await picker.pickImage(
// //       source: ImageSource.gallery,
// //       maxWidth: 1024,
// //       maxHeight: 1024,
// //       imageQuality: 85,
// //     );
// //
// //     if (pickedImage != null) {
// //       setState(() {
// //         _selectedImage2 = File(pickedImage.path);
// //         _encodedImage2 = base64Encode(_selectedImage2!.readAsBytesSync());
// //       });
// //     }
// //   }
// //
// //   // Helper method for picking video
// //   Future<void> _pickVideo() async {
// //     final status = await Permission.storage.request();
// //     if (status.isGranted) {
// //       try {
// //         final result = await ImagePicker().pickVideo(
// //           source: ImageSource.gallery,
// //           maxDuration: const Duration(minutes: 2),
// //         );
// //         if (result != null) {
// //           final videoFile = File(result.path);
// //
// //           // Generate thumbnail
// //           final thumbnailPath = await VideoThumbnail.thumbnailFile(
// //             video: videoFile.path,
// //             imageFormat: ImageFormat.JPEG,
// //             quality: 75,
// //           );
// //
// //           setState(() {
// //             _selectedVideo = videoFile;
// //             if (thumbnailPath != null) {
// //               _videoThumbnail = File(thumbnailPath);
// //             }
// //
// //             // For smaller videos, we can encode to base64
// //             if (videoFile.lengthSync() < 10 * 1024 * 1024) { // Less than 10MB
// //               _encodedVideo = base64Encode(videoFile.readAsBytesSync());
// //             } else {
// //               _encodedVideo = null; // We'll upload larger files differently
// //             }
// //           });
// //
// //           // Initialize video player for preview
// //           _initializeVideoPlayer(videoFile);
// //         }
// //       } catch (e) {
// //         print("Error picking video: $e");
// //         Fluttertoast.showToast(msg: "Error selecting video. Please try again.");
// //       }
// //     } else {
// //       _showPermissionDialog("storage");
// //     }
// //   }
// //
// //   // Initialize video player
// //   Future<void> _initializeVideoPlayer(File videoFile) async {
// //     _videoController = VideoPlayerController.file(videoFile);
// //     await _videoController!.initialize();
// //     setState(() {
// //       _videoInitialized = true;
// //     });
// //   }
// //
// //   // Helper method for image selectors
// //   Widget _buildMediaSelector({
// //     required String title,
// //     required File? image,
// //     required String placeholder,
// //     required VoidCallback onTap,
// //     required IconData icon,
// //   }) {
// //     return Container(
// //       width: 150,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 10,
// //             spreadRadius: 1,
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           InkWell(
// //             onTap: onTap,
// //             borderRadius: BorderRadius.circular(16),
// //             child: Container(
// //               height: 120,
// //               width: 150,
// //               decoration: BoxDecoration(
// //                 color: Colors.grey.shade50,
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //                 border: Border.all(color: Colors.grey.shade200),
// //               ),
// //               child: image != null
// //                   ? ClipRRect(
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //                 child: Image.file(
// //                   image,
// //                   height: 120,
// //                   width: 150,
// //                   fit: BoxFit.cover,
// //                 ),
// //               )
// //                   : Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     icon,
// //                     size: 40,
// //                     color: Colors.cyan,
// //                   ),
// //                   SizedBox(height: 8),
// //                   Text(
// //                     "Tap to select",
// //                     style: TextStyle(
// //                       color: Colors.grey.shade600,
// //                       fontSize: 12,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: EdgeInsets.all(12),
// //             child: Text(
// //               title,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w500,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // Helper method for video selector
// //   Widget _buildVideoSelector({
// //     required String title,
// //     required File? videoFile,
// //     required File? thumbnailFile,
// //     required VoidCallback onTap,
// //     required IconData icon,
// //   }) {
// //     return Container(
// //       width: 250,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 10,
// //             spreadRadius: 1,
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         children: [
// //           InkWell(
// //             onTap: onTap,
// //             borderRadius: BorderRadius.circular(16),
// //             child: Container(
// //               height: 150,
// //               width: 250,
// //               decoration: BoxDecoration(
// //                 color: Colors.grey.shade50,
// //                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
// //                 border: Border.all(color: Colors.grey.shade200),
// //               ),
// //               child: videoFile != null
// //                   ? Stack(
// //                 alignment: Alignment.center,
// //                 children: [
// //                   // Video thumbnail
// //                   thumbnailFile != null
// //                       ? ClipRRect(
// //                     borderRadius: BorderRadius.vertical(
// //                       top: Radius.circular(16),
// //                     ),
// //                     child: Image.file(
// //                       thumbnailFile,
// //                       width: double.infinity,
// //                       height: double.infinity,
// //                       fit: BoxFit.cover,
// //                     ),
// //                   )
// //                       : Container(
// //                     color: Colors.black87,
// //                     width: double.infinity,
// //                     height: double.infinity,
// //                   ),
// //                   Icon(
// //                     Icons.play_circle_fill,
// //                     size: 50,
// //                     color: Colors.white,
// //                   ),
// //                   Positioned(
// //                     bottom: 8,
// //                     right: 8,
// //                     child: Container(
// //                       padding: EdgeInsets.symmetric(
// //                         horizontal: 8,
// //                         vertical: 4,
// //                       ),
// //                       decoration: BoxDecoration(
// //                         color: Colors.black54,
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                       child: Text(
// //                         "Video Selected",
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontSize: 12,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               )
// //                   : Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Icon(
// //                     icon,
// //                     size: 50,
// //                     color: Colors.cyan,
// //                   ),
// //                   SizedBox(height: 12),
// //                   Text(
// //                     "Tap to select video",
// //                     style: TextStyle(
// //                       color: Colors.grey.shade600,
// //                       fontSize: 14,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: EdgeInsets.all(12),
// //             child: Text(
// //               title,
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w500,
// //                 color: Colors.black87,
// //                 fontSize: 16,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // Show permission dialog
// //   void _showPermissionDialog(String permissionType) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) => AlertDialog(
// //         title: Text("Permission Required"),
// //         content: Text("$permissionType permission is needed to select media from your device."),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: Text("OK"),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // Submit media method - sends data to the server
// //   Future<void> _submitMedia() async {
// //     // Validate required fields
// //     if (_selectedImage1 == null || _selectedImage2 == null || _selectedVideo == null) {
// //       Fluttertoast.showToast(msg: "Please select all required media files");
// //       return;
// //     }
// //
// //     // Set uploading state
// //     setState(() {
// //       _isUploading = true;
// //     });
// //
// //     try {
// //       // Get stored server URL and user ID
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String url = sh.getString('url') ?? '';
// //       String lid = sh.getString('lid') ?? '';
// //
// //       if (url.isEmpty || lid.isEmpty) {
// //         Fluttertoast.showToast(msg: "Missing server information. Please login again.");
// //         setState(() {
// //           _isUploading = false;
// //         });
// //         return;
// //       }
// //
// //       // Prepare the API endpoint
// //       final uploadUrl = Uri.parse('$url/artist_manage_gallery/');
// //
// //       // Create a multipart request for all files
// //       var request = http.MultipartRequest('POST', uploadUrl);
// //
// //       // Add text fields
// //       request.fields['lid'] = lid;
// //
// //       // Add all files as multipart
// //       request.files.add(
// //           await http.MultipartFile.fromPath('photo1', _selectedImage1!.path)
// //       );
// //
// //       request.files.add(
// //           await http.MultipartFile.fromPath('photo2', _selectedImage2!.path)
// //       );
// //
// //       request.files.add(
// //           await http.MultipartFile.fromPath('video', _selectedVideo!.path)
// //       );
// //
// //       // Send the request
// //       var response = await request.send();
// //
// //       // Get the response
// //       final responseData = await response.stream.bytesToString();
// //
// //       // Handle the response
// //       if (response.statusCode == 200) {
// //         Fluttertoast.showToast(msg: "Media uploaded successfully");
// //
// //         // Reset the form after successful upload
// //         setState(() {
// //           _selectedImage1 = null;
// //           _selectedImage2 = null;
// //           _selectedVideo = null;
// //           _videoThumbnail = null;
// //           _videoController?.dispose();
// //           _videoController = null;
// //           _videoInitialized = false;
// //         });
// //       } else {
// //         Fluttertoast.showToast(msg: "Upload failed: ${response.statusCode}");
// //         print("Server response: $responseData");
// //       }
// //     } catch (e) {
// //       print("Error during upload: $e");
// //       Fluttertoast.showToast(msg: "Error during upload: ${e.toString()}");
// //     } finally {
// //       // Reset uploading state
// //       setState(() {
// //         _isUploading = false;
// //       });
// //     }
// //   }
// //
// //   // Future<void> _submitMedia() async {
// //   //   // Validate required fields
// //   //   if (_selectedImage1 == null || _selectedImage2 == null || _selectedVideo == null) {
// //   //     Fluttertoast.showToast(msg: "Please select all required media files");
// //   //     return;
// //   //   }
// //   //
// //   //   // if (dropdownValue1.isEmpty) {
// //   //   //   Fluttertoast.showToast(msg: "Please select a category");
// //   //   //   return;
// //   //   // }
// //   //
// //   //   // Set uploading state
// //   //   setState(() {
// //   //     _isUploading = true;
// //   //   });
// //   //
// //   //   try {
// //   //     // Get stored server URL and user ID
// //   //     SharedPreferences sh = await SharedPreferences.getInstance();
// //   //     String url = sh.getString('url') ?? '';
// //   //     String lid = sh.getString('lid') ?? '';
// //   //
// //   //     if (url.isEmpty || lid.isEmpty) {
// //   //       Fluttertoast.showToast(msg: "Missing server information. Please login again.");
// //   //       setState(() {
// //   //         _isUploading = false;
// //   //       });
// //   //       return;
// //   //     }
// //   //
// //   //     // Prepare the API endpoint
// //   //     final uploadUrl = Uri.parse('$url/artist_manage_gallery/');
// //   //
// //   //     // Encode video to base64 if not already done (and if it's not too large)
// //   //     if (_encodedVideo == null && _selectedVideo!.lengthSync() < 10 * 1024 * 1024) {
// //   //       _encodedVideo = base64Encode(_selectedVideo!.readAsBytesSync());
// //   //     }
// //   //
// //   //     // Method 1: For smaller files - Base64 encoding
// //   //     if (_encodedVideo != null) {
// //   //       // Create request body with base64 encoded files
// //   //       final response = await http.post(
// //   //         uploadUrl,
// //   //         body: {
// //   //           'lid': lid,
// //   //           // 'category': category_id_[category_name_.indexOf(dropdownValue1)],
// //   //           'photo1': _encodedImage1,
// //   //           'photo2': _encodedImage2,
// //   //           'video': _encodedVideo,
// //   //         },
// //   //       );
// //   //
// //   //       _handleApiResponse(response);
// //   //     }
// //   //     // Method 2: For larger videos - Multipart request
// //   //     else {
// //   //       // Create a multipart request
// //   //       var request = http.MultipartRequest('POST', uploadUrl);
// //   //
// //   //       // Add text fields
// //   //       request.fields['lid'] = lid;
// //   //       // request.fields['category'] = category_id_[category_name_.indexOf(dropdownValue1)];
// //   //       request.fields['photo1'] = _encodedImage1 ?? '';
// //   //       request.fields['photo2'] = _encodedImage2 ?? '';
// //   //
// //   //       // Add file
// //   //       request.files.add(
// //   //         await http.MultipartFile.fromPath(
// //   //           'video', _selectedVideo!.path,
// //   //         ),
// //   //       );
// //   //
// //   //       // Send the request
// //   //       var streamedResponse = await request.send();
// //   //       var response = await http.Response.fromStream(streamedResponse);
// //   //
// //   //       _handleApiResponse(response);
// //   //     }
// //   //   } catch (e) {
// //   //     print("Error uploading media: $e");
// //   //     Fluttertoast.showToast(msg: "Upload failed: ${e.toString()}");
// //   //     setState(() {
// //   //       _isUploading = false;
// //   //     });
// //   //   }
// //   // }
// //
// //   // Handle API response
// //   void _handleApiResponse(http.Response response) {
// //     setState(() {
// //       _isUploading = false;
// //     });
// //
// //     if (response.statusCode == 200) {
// //       try {
// //         var data = jsonDecode(response.body);
// //         if (data['status'] == 'ok') {
// //           Fluttertoast.showToast(msg: "Media uploaded successfully!");
// //
// //           // Reset form
// //           setState(() {
// //             _selectedImage1 = null;
// //             _selectedImage2 = null;
// //             _selectedVideo = null;
// //             _videoThumbnail = null;
// //             _encodedImage1 = null;
// //             _encodedImage2 = null;
// //             _encodedVideo = null;
// //             // dropdownValue1 = '';
// //           });
// //
// //           // Optionally navigate to another screen
// //           Navigator.pop(context); // or navigate to a specific screen
// //         } else {
// //           Fluttertoast.showToast(msg: data['message'] ?? "Upload failed");
// //         }
// //       } catch (e) {
// //         Fluttertoast.showToast(msg: "Error processing response");
// //       }
// //     } else {
// //       Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
// //     }
// //   }
// // }