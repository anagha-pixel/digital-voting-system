// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key});

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final List<Map<String, dynamic>> messages = [];
//   final TextEditingController _controller = TextEditingController();
//   final geminiProvider = GeminiProvider(
//     model: GenerativeModel(
//       model: 'gemini-1.5-flash',
//       apiKey: 'AIzaSyBj3aubGBooDX7b0re9SJYa155tWMv7_lQ', // Replace with your actual Gemini API key
//     ),
//   );

//   void _sendMessage(String message) async {
//     if (message.isEmpty) return;

//     setState(() {
//       messages.add({'text': message, 'isUser': true});
//     });
//     _controller.clear();

//     if (message.toLowerCase().startsWith('generate image')) {
//       final prompt = message.replaceFirst(RegExp(r'generate image', caseSensitive: false), '').trim();
//       if (prompt.isEmpty) {
//         setState(() {
//           messages.add({'text': 'Please provide a valid image prompt.', 'isUser': false});
//         });
//         return;
//       }

//       setState(() {
//         messages.add({'text': 'Generating image...', 'isUser': false});
//       });

//       final imageBase64 = await _generateImage(prompt);
//       setState(() {
//         messages.removeLast(); // Remove "Generating image..."
//         if (imageBase64 != null) {
//           messages.add({'image': imageBase64, 'isUser': false});
//         } else {
//           messages.add({'text': 'Failed to generate image.', 'isUser': false});
//         }
//       });
//     } else {
//       try {
//         final responseStream = geminiProvider.sendMessageStream(message, attachments: []);
//         await for (final response in responseStream) {
//           setState(() {
//             messages.add({'text': response.toString(), 'isUser': false});
//           });
//         }
//       } catch (e) {
//         setState(() {
//           messages.add({'text': 'Error processing request: $e', 'isUser': false});
//         });
//       }
//     }
//   }

//   Future<String?> _generateImage(String prompt) async {
//     final dio = Dio();
//     try {
//       print('Sending image generation request for prompt: $prompt');
//       final response = await dio.post(
//         'https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image',
//         options: Options(
//           headers: {
//             'Authorization': 'sk-5QulvsjCnAUznptPzFMv3npnNhiDBMUENkED8r4KEVnkp6Sw', // Replace with your actual Stability AI API key
//             'Content-Type': 'application/json',
//           },
//         ),
//         data: {
//           'text_prompts': [
//             {'text': prompt, 'weight': 1}
//           ],
//           'cfg_scale': 7,
//           'height': 1024,
//           'width': 1024,
//           'samples': 1,
//           'steps': 30,
//         },
//       );
//       if (response.statusCode == 200) {
//         final base64 = response.data['artifacts'][0]['base64'];
//         print('Generated base64: ${base64.substring(0, 50)}...');
//         return base64;
//       } else {
//         print('API error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Image generation error: $e');
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('AI Chatbot')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 final isUser = message['isUser'] as bool;
//                 if (message.containsKey('image')) {
//                   try {
//                     return Align(
//                       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Image.memory(
//                           base64Decode(message['image']),
//                           width: 200,
//                           height: 200,
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) => const Text('Failed to load image.'),
//                         ),
//                       ),
//                     );
//                   } catch (e) {
//                     return const Text('Error rendering image.');
//                   }
//                 }
//                 return Align(
//                   alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.all(8.0),
//                     padding: const EdgeInsets.all(12.0),
//                     decoration: BoxDecoration(
//                       color: isUser ? Colors.blue[100] : Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Text(
//                       message['text'] as String,
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Type a message or "generate image of..."',
//                       border: OutlineInputBorder(),
//                     ),
//                     onSubmitted: _sendMessage,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () => _sendMessage(_controller.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }