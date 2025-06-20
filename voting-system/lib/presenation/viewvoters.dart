// import 'package:flutter/material.dart';

// class ViewVotersScreen extends StatefulWidget {
//   @override
//   _ViewVotersScreenState createState() => _ViewVotersScreenState();
// }

// class _ViewVotersScreenState extends State<ViewVotersScreen> {
//   List<Map<String, String>> voters = [
//     {"id": "201", "name": "Alice Johnson", "age": "25", "voterId": "V001"},
//     {"id": "202", "name": "Bob Williams", "age": "30", "voterId": "V002"},
//     {"id": "203", "name": "Charlie Davis", "age": "22", "voterId": "V003"},
//     {"id": "204", "name": "Diana Evans", "age": "28", "voterId": "V004"},
//   ];

//   TextEditingController searchController = TextEditingController();
//   List<Map<String, String>> filteredVoters = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredVoters = voters; // Initially show all voters
//   }

//   void _filterVoters(String query) {
//     setState(() {
//       if (query.isEmpty) {
//         filteredVoters = voters;
//       } else {
//         filteredVoters = voters
//             .where((voter) =>
//                 voter["name"]!.toLowerCase().contains(query.toLowerCase()) ||
//                 voter["voterId"]!.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   void _deleteVoter(int index) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text("Confirm Deletion"),
//         content: Text("Are you sure you want to delete this voter?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             onPressed: () {
//               setState(() {
//                 voters.removeAt(index);
//                 filteredVoters = voters; // Update filtered list
//               });
//               Navigator.of(ctx).pop();
//             },
//             child: Text("Delete", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Voter List"), backgroundColor: Colors.blue),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Search Bar
//             TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 labelText: "Search Voter",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: _filterVoters,
//             ),
//             SizedBox(height: 10),

//             // Voter List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredVoters.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: Text(filteredVoters[index]['name']![0]), // First letter of name
//                       ),
//                       title: Text(filteredVoters[index]['name']!),
//                       subtitle: Text("Age: ${filteredVoters[index]['age']} | ID: ${filteredVoters[index]['voterId']}"),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => _deleteVoter(index),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
