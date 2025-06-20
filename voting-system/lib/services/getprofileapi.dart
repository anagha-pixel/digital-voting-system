import 'package:dio/dio.dart';
import 'package:votting_systems/services/loginapi.dart';


  final Dio _dio = Dio();
  Map<String, dynamic> profiledata={};

  Future<Map<String, dynamic>> fetchProfileData() async {
    try {
      final response = await _dio.get(
        '$baseurl/api/user_profile/$lid',
       
      );

      if (response.statusCode == 200) {
        profiledata = response.data as Map<String, dynamic>;
        print('Profile data fetched successfully: $profiledata');
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      throw Exception('Error fetching profile data: $e');
    }
  }
