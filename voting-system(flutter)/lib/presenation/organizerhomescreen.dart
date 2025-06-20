import 'package:flutter/material.dart';

class OrganizerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organizer Dashboard"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Logout logic here
              Navigator.pushReplacementNamed(context, "/auth");
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // Navigate to Organizer Profile
            Navigator.pushNamed(context, "/organizer_profile");
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // View Candidates
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/organizer_view_candidates");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("View Candidates", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 20),

            // Manage Elections
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/manage_elections");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Manage Elections", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 20),

            // Add Voters
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add_voters");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Add Voters", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 20),

            // View Results
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/view_results");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("View Results", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
