import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:votting_systems/presenation/faceRecog.dart';
import 'package:votting_systems/presenation/result.dart';
import 'package:votting_systems/presenation/signinscreen.dart';
import 'package:votting_systems/presenation/votingpage.dart';
import 'package:votting_systems/services/getprofileapi.dart';
import 'package:votting_systems/services/loginapi.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simulated user data (replace with actual data from API or session)
  // final String userName = "John Doe";
  // final String userEmail = "john.doe@example.com";
  // final String? userProfileImage = null; // Replace with API-fetched image URL or File path

  // Placeholder carousel images (replace with actual voting-related images)
  final List<String> carouselImages = [
    'https://i.pinimg.com/736x/b5/1d/74/b51d7416c120b09347a2fc149f9fe077.jpg',
    'https://pbs.twimg.com/media/EVe6BYtX0AEFasB.jpg:large',
    'https://postive.digital/assets/img/national-voters-day-2025.webp',
  ];

  void _logout() {
    // Simulate logout (e.g., clear session, token, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logged out successfully!'),
        backgroundColor: Colors.teal.shade600,
      ),
    );
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ct)=>LoginScreen()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
   String?  userProfileImage=profiledata['known_face_encoding'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Voting System',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey.shade900,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer Header (Profile Section)
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade400, Colors.teal.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                accountName: Text(
                  profiledata['name']??'no name',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  'ID: ${profiledata['voter_id']??'no id'}',
                  style: TextStyle(fontSize: 14),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.teal.shade100,
                  backgroundImage: userProfileImage != null ? NetworkImage('$baseurl$userProfileImage'!) : null,
                  child: userProfileImage == null
                      ? Icon(
                          Icons.person,
                          color: Colors.teal.shade800,
                          size: 50,
                        )
                      : null,
                ),
              ),
              // Settings
              ListTile(
                leading: Icon(Icons.settings, color: Colors.teal.shade400),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              // Logout
              ListTile(
                leading: Icon(Icons.logout, color: Colors.teal.shade400),
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  _logout();
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade50, Colors.teal.shade300],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Carousel Slider
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                  ),
                  items: carouselImages.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.teal.shade900.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  imageUrl,
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  color: Colors.teal.shade700.withOpacity(0.3),
                                ),
                                // Center(
                                //   child: Text(
                                //     'Vote Today!',
                                //     style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 24,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              // Options Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.grey.shade50.withOpacity(0.95),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '"Voting is not just a right; it\'s a responsibility that shapes the future of our communities and nations."',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),
                        // View Candidates Button
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.teal.shade400, Colors.teal.shade700],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.teal.shade900.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FaceRecognitionScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.group, color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'View Candidates',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // View Results Button
                        // Container(
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       colors: [Colors.teal.shade400, Colors.teal.shade700],
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //     ),
                        //     borderRadius: BorderRadius.circular(12),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.teal.shade900.withOpacity(0.3),
                        //         blurRadius: 8,
                        //         offset: Offset(0, 4),
                        //       ),
                        //     ],
                        //   ),
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen()));
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: Colors.transparent,
                        //       shadowColor: Colors.transparent,
                        //       padding: EdgeInsets.symmetric(vertical: 14, horizontal: 36),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.bar_chart, color: Colors.white, size: 20),
                        //         SizedBox(width: 8),
                        //         Text(
                        //           'View Results',
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //             fontWeight: FontWeight.w600,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}