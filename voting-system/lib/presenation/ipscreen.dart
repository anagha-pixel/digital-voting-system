import 'package:flutter/material.dart';
import 'package:votting_systems/presenation/signinscreen.dart';
import 'package:votting_systems/services/loginapi.dart';

// String baseUrl = '';

class IpScreen extends StatefulWidget {
  @override
  _IpScreenState createState() => _IpScreenState();
}

class _IpScreenState extends State<IpScreen> {
  final TextEditingController _ipController = TextEditingController(
    text: 'http://',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[400],

        title: Text('Enter IP Address', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _ipController,
              decoration: InputDecoration(
                labelText: 'IP Address',
                border: OutlineInputBorder(),
              ),
              // keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[400],
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                String ipAddress = _ipController.text.trim();
                if (ipAddress.isNotEmpty) {
                  baseurl = ipAddress;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid IP address')),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
