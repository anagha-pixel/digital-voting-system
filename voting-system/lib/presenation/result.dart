// import 'package:flutter/material.dart';

// class ResultScreen extends StatefulWidget {
//   @override
//   _ResultScreenState createState() => _ResultScreenState();
// }

// class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
//   // Candidate List with Vote Counts and Images
//   List<Map<String, dynamic>> candidates = [
//     {"id": "101", "name": "Alice Johnson", "party": "Party A", "votes": 120, "image": "assets/candidate1.jpg"},
//     {"id": "102", "name": "Bob Williams", "party": "Party B", "votes": 90, "image": "assets/candidate2.jpg"},
//     {"id": "103", "name": "Charlie Davis", "party": "Party C", "votes": 150, "image": "assets/candidate3.jpg"},
//     {"id": "104", "name": "Diana Evans", "party": "Party D", "votes": 110, "image": "assets/candidate4.jpg"},
//   ];

//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     );
//     _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   // Calculate total votes
//   int get _totalVotes => candidates.fold(0, (sum, candidate) => sum + candidate["votes"] as int);

//   // Calculate vote percentage
//   double _getVotePercentage(int votes) {
//     if (_totalVotes == 0) return 0.0;
//     return (votes / _totalVotes * 100).clamp(0, 100);
//   }

//   // Find winners (handle ties)
//   List<Map<String, dynamic>> get _winners {
//     if (candidates.isEmpty) return [];
//     final maxVotes = candidates.map((c) => c["votes"] as int).reduce((a, b) => a > b ? a : b);
//     return candidates.where((c) => c["votes"] == maxVotes).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Sort candidates by votes (descending order)
//     candidates.sort((a, b) => b["votes"].compareTo(a["votes"]));

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Election Results',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.teal.shade700,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.teal.shade200, Colors.teal.shade600],
//           ),
//         ),
//         child: SafeArea(
//           child: candidates.isEmpty
//               ? Center(
//                   child: Text(
//                     'No results available',
//                     style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
//                   ),
//                 )
//               : SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // Header
//                       ScaleTransition(
//                         scale: _scaleAnimation,
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Colors.teal.shade100,
//                               child: Icon(
//                                 Icons.emoji_events,
//                                 color: Colors.teal.shade800,
//                                 size: 48,
//                               ),
//                             ),
//                             SizedBox(height: 16),
//                             Text(
//                               'Election Results',
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 1.2,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             SizedBox(height: 8),
//                             Text(
//                               'See who’s leading the race',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey.shade400,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 24),
//                       // Winner Highlight
//                       ScaleTransition(
//                         scale: _scaleAnimation,
//                         child: Card(
//                           elevation: 12,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                             side: BorderSide(color: Colors.teal.shade400, width: 1),
//                           ),
//                           color: Colors.grey.shade50.withOpacity(0.95),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.emoji_events,
//                                       color: Colors.yellow.shade600,
//                                       size: 32,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       _winners.length > 1 ? 'Winners (Tie)' : 'Winner',
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.yellow.shade300,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 16),
//                                 ..._winners.asMap().entries.map((entry) {
//                                   final winner = entry.value;
//                                   final percentage = _getVotePercentage(winner["votes"]);
//                                   return Padding(
//                                     padding: const EdgeInsets.only(bottom: 12.0),
//                                     child: Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 40,
//                                           backgroundColor: Colors.teal.shade100,
//                                           backgroundImage: AssetImage(winner["image"]),
//                                           onBackgroundImageError: (_, __) => Icon(
//                                             Icons.person,
//                                             color: Colors.teal.shade800,
//                                             size: 48,
//                                           ),
//                                         ),
//                                         SizedBox(width: 16),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 winner["name"],
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 4),
//                                               Text(
//                                                 'Party: ${winner["party"]}',
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey.shade400,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 4),
//                                               Text(
//                                                 'Votes: ${winner["votes"]} (${percentage.toStringAsFixed(1)}%)',
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 24),
//                       // Total Votes
//                       Text(
//                         'Total Votes Cast: $_totalVotes',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 24),
//                       // Candidate Results List
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemCount: candidates.length,
//                         itemBuilder: (context, index) {
//                           final candidate = candidates[index];
//                           final percentage = _getVotePercentage(candidate["votes"]);
//                           return AnimatedBuilder(
//                             animation: _animationController,
//                             builder: (context, child) {
//                               return Transform.scale(
//                                 scale: _scaleAnimation.value,
//                                 child: Card(
//                                   elevation: 8,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16),
//                                     side: BorderSide(color: Colors.teal.shade400, width: 1),
//                                   ),
//                                   color: Colors.grey.shade50.withOpacity(0.95),
//                                   margin: EdgeInsets.symmetric(vertical: 12),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Row(
//                                       children: [
//                                         // Candidate Image
//                                         CircleAvatar(
//                                           radius: 40,
//                                           backgroundColor: Colors.teal.shade100,
//                                           backgroundImage: AssetImage(candidate["image"]),
//                                           onBackgroundImageError: (_, __) => Icon(
//                                             Icons.person,
//                                             color: Colors.teal.shade800,
//                                             size: 48,
//                                           ),
//                                         ),
//                                         SizedBox(width: 16),
//                                         // Candidate Details
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 candidate["name"],
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.grey,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 4),
//                                               Text(
//                                                 'Party: ${candidate["party"]}',
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey.shade400,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 4),
//                                               Text(
//                                                 'Votes: ${candidate["votes"]} (${percentage.toStringAsFixed(1)}%)',
//                                                 style: TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.grey,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                               SizedBox(height: 8),
//                                               // Progress Bar
//                                               LinearProgressIndicator(
//                                                 value: percentage / 100,
//                                                 backgroundColor: Colors.grey.shade700,
//                                                 valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade400),
//                                                 minHeight: 6,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }