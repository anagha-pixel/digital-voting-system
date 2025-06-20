import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Map<String, dynamic>> candidates = [
    {"id": "101", "name": "Alice Johnson", "party": "Party A", "votes": 120},
    {"id": "102", "name": "Bob Williams", "party": "Party B", "votes": 90},
    {"id": "103", "name": "Charlie Davis", "party": "Party C", "votes": 150},
    {"id": "104", "name": "Diana Evans", "party": "Party D", "votes": 110},
  ];

  @override
  Widget build(BuildContext context) {
    // Sort candidates by votes (descending order)
    candidates.sort((a, b) => b["votes"].compareTo(a["votes"]));

    return Scaffold(
      appBar: AppBar(
        title: Text("Election Results"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Winner Highlight
            Card(
              color: Colors.green.shade300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.emoji_events, color: Colors.yellow, size: 40),
                title: Text("Winner: ${candidates[0]['name']}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("Party: ${candidates[0]['party']} | Votes: ${candidates[0]['votes']}"),
              ),
            ),
            SizedBox(height: 20),

            // Candidate Results List
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: index == 0 ? Colors.green : Colors.grey,
                        child: Text(candidates[index]['name'][0]),
                      ),
                      title: Text("${candidates[index]['name']}"),
                      subtitle: Text("Party: ${candidates[index]['party']} | Votes: ${candidates[index]['votes']}"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
