import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:votting_systems/presenation/faceRecog.dart';
import 'package:votting_systems/services/loginapi.dart';

class VotingScreen extends StatefulWidget {
  @override
  _VotingScreenState createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> with SingleTickerProviderStateMixin {
  // Candidate List with Vote Counts
   List<Map<String, dynamic>> _candidates = [
    // {"name": "John Doe", "image": "assets/candidate1.jpg", "votes": 0},
    // {"name": "Emma Smith", "image": "assets/candidate2.jpg", "votes": 0},
    // {"name": "Michael Brown", "image": "assets/candidate3.jpg", "votes": 0},
  ];

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
     _fetchCandidates();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }


 

  Future<void> _fetchCandidates() async {
    try {
      final response = await Dio().get('$baseurl/api/candidate_list/');
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          _candidates = List<Map<String, dynamic>>.from(response.data['candidates']);
        });
      } else {
        throw Exception('Failed to load candidates');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching candidates: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  Future<void> _submitVote(int candidateId) async {
    try {
      final response = await Dio().post(
        '$baseurl/api/voting/',
        data: {'candidate_id': candidateId,'voter_loginid': lid},
      );
      print(response.data);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vote submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to submit vote');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting vote: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }



  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Function to handle vote submission
  void _voteForCandidate(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.grey.shade50.withOpacity(0.95),
        title: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade400, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Text(
            "Confirm Your Vote",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        content: Text(
          "Are you sure you want to vote for ${_candidates[index]["name"]}?",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.teal.shade400, fontSize: 14),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade200, Colors.teal.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _submitVote(_candidates[index]["id"]);
// Navigator.push(context, MaterialPageRoute(builder: (ctx)=>FaceRecognitionScreen()));
               
                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                "Confirm",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Voting System',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade200, Colors.teal.shade800],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              children: [
                // Header
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(
                          Icons.how_to_vote,
                          color: Colors.teal.shade800,
                          size: 48,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Vote for Your Candidate',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Make your voice heard',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // Candidate List
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _candidates.length,
                  itemBuilder: (context, index) {
                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.teal.shade400, width: 1),
                            ),
                            color: Colors.grey.shade50.withOpacity(0.95),
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  // Candidate Image
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.teal.shade100,
                                    backgroundImage: NetworkImage('$baseurl/media/${_candidates[index]["candidate_image"]}'),
                                    // onBackgroundImageError: (_, __) => Icon(
                                    //   Icons.person,
                                    //   color: Colors.teal.shade800,
                                    //   size: 48,
                                    // ),
                                  ),
                                  SizedBox(width: 16),
                                  // Candidate Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _candidates[index]["name"]??"",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                        ),
                                         Text(
                                          _candidates[index]["party"]??"",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        
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
                                      onPressed: () => _voteForCandidate(index),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.how_to_vote, color: Colors.white, size: 18),
                                          SizedBox(width: 8),
                                          Text(
                                            'Vote',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                      ],
                                    ),
                                  ),
                                 
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}