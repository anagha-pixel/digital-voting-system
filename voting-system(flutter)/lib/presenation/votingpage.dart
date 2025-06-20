import 'package:flutter/material.dart';

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  // Candidate List with Vote Counts
  final List<Map<String, dynamic>> _candidates = [
    {"name": "John Doe", "image": "assets/candidate1.jpg", "votes": 0},
    {"name": "Emma Smith", "image": "assets/candidate2.jpg", "votes": 0},
    {"name": "Michael Brown", "image": "assets/candidate3.jpg", "votes": 0},
  ];

  // Function to handle vote submission
  void _voteForCandidate(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Your Vote"),
        content: Text("Are you sure you want to vote for ${_candidates[index]["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _candidates[index]["votes"]++; // Increase vote count
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Vote submitted for ${_candidates[index]["name"]}!")),
              );
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voting System"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "VOTE FOR CANDIDATE",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Candidate List
            Expanded(
              child: ListView.builder(
                itemCount: _candidates.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(_candidates[index]["image"]),
                        radius: 30,
                      ),
                      title: Text(_candidates[index]["name"], style: TextStyle(fontSize: 18)),
                      
                      trailing: ElevatedButton(
                        onPressed: () => _voteForCandidate(index),
                        child: Text("Vote"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
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
