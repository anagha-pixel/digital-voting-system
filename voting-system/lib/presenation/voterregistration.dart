// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueGrey[50], // Light background color
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "VOTER",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueGrey[800],
//                   ),
//                 ),
//                 SizedBox(height: 30),
                
//                 // Name Field
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Name',
//                     prefixIcon: Icon(Icons.person, color: Colors.blueGrey),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: Colors.blue, width: 2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Email Field
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Email ID',
//                     prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: Colors.blue, width: 2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Password Field
//                 TextFormField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: Colors.blue, width: 2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
                
//                 // Confirm Password Field
//                 TextFormField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Confirm Password',
//                     prefixIcon: Icon(Icons.lock, color: Colors.blueGrey),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: Colors.blue, width: 2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 30),

//                 // Image Picker Button
//                 ElevatedButton.icon(
//                   onPressed: _pickImage,
//                   icon: Icon(Icons.image),
//                   label: Text("Pick Image"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Display Selected Image
//                 _image != null
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.file(
//                           _image!,
//                           height: 150,
//                           width: 150,
//                           fit: BoxFit.cover,
//                         ),
//                       )
//                     : Text('No image selected', style: TextStyle(color: Colors.grey)),

//                 SizedBox(height: 40),

//                 // Submit Button
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text("Submit"),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     foregroundColor: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
