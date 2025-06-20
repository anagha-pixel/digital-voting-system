import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:votting_systems/presenation/votingpage.dart';
import 'package:votting_systems/services/loginapi.dart';

class FaceRecognitionScreen extends StatefulWidget {
  @override
  _FaceRecognitionScreenState createState() => _FaceRecognitionScreenState();
}

class _FaceRecognitionScreenState extends State<FaceRecognitionScreen> with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  Future<void> _initializeCamera() async {
    try {
      // Get available cameras and select the front camera
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first, // Fallback to first camera if no front camera
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      if (!mounted) return;

      setState(() {});

      // Start 2-second timer to take picture
      Timer(Duration(seconds: 2), _takePicture);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to initialize camera: $e'),
          backgroundColor: Colors.red.shade600,
        ),
      );
      Navigator.pop(context); // Navigate back on failure
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;

    try {
      setState(() {
        _isLoading = true;
      });

      // Capture image
      final XFile image = await _cameraController!.takePicture();
      final File imageFile = File(image.path);

      // Send to server
      await _sendToServer(imageFile);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to capture image: $e'),
          backgroundColor: Colors.red.shade600,
        ),
      );
      Navigator.pop(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendToServer(File imageFile) async {
    try {
      final dio = Dio();
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await dio.post(
        '$baseurl/api/monitor_camera/$lid/',
        data: formData,
      );

      // Show dialog based on response
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.grey.shade50.withOpacity(0.95),
          title: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  response.statusCode == 200 || response.statusCode == 201
                      ? Colors.teal.shade600
                      : Colors.red.shade600,
                  response.statusCode == 200 || response.statusCode == 201
                      ? Colors.teal.shade800
                      : Colors.red.shade800,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Text(
              response.statusCode == 200 || response.statusCode == 201
                  ? 'Face Recognition Success'
                  : 'Face Recognition Failed',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          content: Text(
            response.statusCode == 200 || response.statusCode == 201
                ? response.data['message'] ?? 'Face recognition successful!'
                : response.data['message'] ?? 'Unknown error',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade400, Colors.teal.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  // Navigator.pop(context); // Navigate back
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VotingScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      // Show error dialog for exceptions
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.grey.shade50.withOpacity(0.95),
          title: Container(
            
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade600, Colors.red.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Text(
              'Face Recognition Error',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          content: Text(
            'An error occurred: $e',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          actions: [
            Container(
             
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal.shade400, Colors.teal.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Navigate back
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade200, Colors.teal.shade800],
          ),
        ),
        child: SafeArea(
          child: _cameraController == null || !_cameraController!.value.isInitialized
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade400),
                  ),
                )
              : Stack(
                alignment: Alignment.center,
                  children: [
                    // Camera Preview
                    Positioned.fill(
                      child: CameraPreview(_cameraController!),
                    ),
                    // UI Overlay
                    Column(
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.teal.shade100,
                                  child: Icon(
                                    Icons.camera_front,
                                    color: Colors.teal.shade800,
                                    size: 48,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Face Recognition',
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
                                  'Position your face in the frame',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        // Loading Indicator
                        if (_isLoading)
                          Container(
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal.shade400),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Processing face recognition...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}