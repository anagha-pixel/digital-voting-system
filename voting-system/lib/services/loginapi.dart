import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:votting_systems/presenation/voterhomescreen.dart';
import 'package:votting_systems/services/getprofileapi.dart';

  String baseurl = ''; 
  String? lid;
  Future<Map<String, dynamic>> loginApi(String email, String password,context) async {
   // Replace with your API endpoint
Dio _dio = Dio(); // Create a Dio instance
    try {
      final response = await _dio.post(
        '$baseurl/api/login/',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(   
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200&& response.data['status'] == 'success') {
        lid=response.data['login_id'].toString();
        print('Login successful: ${response.data}');
      await  fetchProfileData();
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctxt)=> HomeScreen()  ), (route) => false,);
        return response.data;
      } else {
        throw Exception('Failed to login: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
