import 'package:flutter/material.dart';

class VoterHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voter Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Handle logout
              Navigator.pushReplacementNamed(context, "/auth");
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            // Navigate to profile screen
            Navigator.pushNamed(context, "/profile");
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle voting action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text("Vote Now", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
