import 'package:flutter/material.dart';

class ViewCandidatesScreen extends StatelessWidget {
  final List<Map<String, String>> candidates = [
    {"id": "101", "name": "John Doe", "party": "Democratic Party", "post": "President"},
    {"id": "102", "name": "Jane Smith", "party": "Republican Party", "post": "Vice President"},
    {"id": "103", "name": "Alex Johnson", "party": "Independent", "post": "Senator"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidates"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: candidates.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(candidates[index]["name"]![0], style: TextStyle(color: Colors.white)),
              ),
              title: Text(
                candidates[index]["name"]!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Party: ${candidates[index]["party"]!}", style: TextStyle(color: Colors.black87)),
                  Text("Post: ${candidates[index]["post"]!}", style: TextStyle(color: Colors.black87)),
                  Text("ID: ${candidates[index]["id"]!}", style: TextStyle(color: Colors.grey)),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Voted for ${candidates[index]["name"]!}")),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text("Vote"),
              ),
            ),
          );
        },
      ),
    );
  }
}
