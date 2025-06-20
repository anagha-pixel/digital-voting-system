import 'package:flutter/material.dart';

class CandidateManagementScreen extends StatefulWidget {
  @override
  _CandidateManagementScreenState createState() => _CandidateManagementScreenState();
}

class _CandidateManagementScreenState extends State<CandidateManagementScreen> {
  List<Map<String, String>> candidates = [
    {"id": "101", "party": "Party A", "post": "President"},
    {"id": "102", "party": "Party B", "post": "Vice President"},
    {"id": "103", "party": "Party C", "post": "Secretary"},
  ];

  void _addOrEditCandidate({String? id, String? party, String? post, int? index}) {
    final TextEditingController idController = TextEditingController(text: id ?? "");
    final TextEditingController partyController = TextEditingController(text: party ?? "");
    final TextEditingController postController = TextEditingController(text: post ?? "");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(index == null ? "Add Candidate" : "Edit Candidate"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: "Candidate ID"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: partyController,
              decoration: InputDecoration(labelText: "Party Name"),
            ),
            TextField(
              controller: postController,
              decoration: InputDecoration(labelText: "Post"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (idController.text.isNotEmpty &&
                  partyController.text.isNotEmpty &&
                  postController.text.isNotEmpty) {
                setState(() {
                  if (index == null) {
                    // Add Candidate
                    candidates.add({
                      "id": idController.text,
                      "party": partyController.text,
                      "post": postController.text,
                    });
                  } else {
                    // Edit Candidate
                    candidates[index] = {
                      "id": idController.text,
                      "party": partyController.text,
                      "post": postController.text,
                    };
                  }
                });
                Navigator.of(ctx).pop();
              }
            },
            child: Text(index == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  void _deleteCandidate(int index) {
    setState(() {
      candidates.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidate Management"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Add Candidate Button
            ElevatedButton(
              onPressed: () => _addOrEditCandidate(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Add Candidate", style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 20),

            // Candidate List
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("Party: ${candidates[index]['party']}"),
                      subtitle: Text("Post: ${candidates[index]['post']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit Button
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _addOrEditCandidate(
                              id: candidates[index]['id'],
                              party: candidates[index]['party'],
                              post: candidates[index]['post'],
                              index: index,
                            ),
                          ),
                          // Delete Button
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteCandidate(index),
                          ),
                        ],
                      ),
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
