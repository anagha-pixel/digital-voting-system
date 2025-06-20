// import 'package:flutter/material.dart';

// class AdminPanel extends StatefulWidget {
//   @override
//   _AdminPanelState createState() => _AdminPanelState();
// }

// class _AdminPanelState extends State<AdminPanel> {
//   // Candidate List with Vote Counts
//   List<Map<String, dynamic>> _candidates = [
//     {"name": "John Doe", "votes": 15},
//     {"name": "Emma Smith", "votes": 10},
//     {"name": "Michael Brown", "votes": 7},
//   ];

//   final TextEditingController _nameController = TextEditingController();

//   // Function to reset votes
//   void _resetVotes() {
//     setState(() {
//       for (var candidate in _candidates) {
//         candidate["votes"] = 0;
//       }
//     });
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All votes have been reset.")));
//   }

//   // Function to delete a candidate
//   void _deleteCandidate(int index) {
//     setState(() {
//       _candidates.removeAt(index);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Candidate removed.")));
//   }

//   // Function to add a new candidate
//   void _addCandidate() {
//     if (_nameController.text.isNotEmpty) {
//       setState(() {
//         _candidates.add({"name": _nameController.text, "votes": 0});
//       });
//       _nameController.clear();
//       Navigator.pop(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Admin Panel"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Text(
//               "Candidate Management",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),

//             // Candidate List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _candidates.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     child: ListTile(
//                       title: Text(_candidates[index]["name"], style: TextStyle(fontSize: 18)),
//                       subtitle: Text("Votes: ${_candidates[index]["votes"]}"),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _deleteCandidate(index),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             SizedBox(height: 20),

//             // Reset Votes Button
//             ElevatedButton(
//               onPressed: _resetVotes,
//               child: Text("Reset All Votes"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//               ),
//             ),

//             SizedBox(height: 10),

//             // Add Candidate Button
//             ElevatedButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: Text("Add Candidate"),
//                     content: TextField(
//                       controller: _nameController,
//                       decoration: InputDecoration(labelText: "Candidate Name"),
//                     ),
//                     actions: [
//                       TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
//                       ElevatedButton(onPressed: _addCandidate, child: Text("Add")),
//                     ],
//                   ),
//                 );
//               },
//               child: Text("Add Candidate"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
