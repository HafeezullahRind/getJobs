import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    final url = Uri.parse('http://www.jobportal.ai-teacher.org/api/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> register(
      {required String email,
      required String password,
      required String location,
      required String name}) async {
    final url = Uri.parse('http://www.jobportal.ai-teacher.org/api/register');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
        'location': location,
        'role': 'user',
        'name': name
      },
    );
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON response
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> forgetPassword({
    required String email,
    required BuildContext context,
  }) async {
    final url =
        Uri.parse('http://www.jobportal.ai-teacher.org/api/password/email');
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
        },
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON response
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send reset code. Please try again.'),
        ),
      );
      // Re-throw the error so it can be caught by the caller if needed
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> ApplyJob({
    required String email,
    required String name,
    String? coverletter,
    required BuildContext context,
    required File resumeFile,
  }) async {
    final url = Uri.parse(
        'https://www.jobportal.ai-teacher.org/api/apply-for-job/applied/2');

    CircularProgressIndicator();
    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['name'] = 'user';
      request.fields['email'] = 'user@user.com';
      request.fields['portfolio_site'] = 'www.google.com';
      request.fields['cover_letter'] =
          coverletter ?? ''; // If cover letter is null, provide an empty string

      // Add resume file to the request
      request.files.add(http.MultipartFile(
        'resume',
        resumeFile.readAsBytes().asStream(), // Convert the file to a stream
        resumeFile.lengthSync(), // Provide the length of the file
        filename: resumeFile.path.split('/').last, // Provide the file name
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON response
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      
      // Re-throw the error so it can be caught by the caller if needed
      rethrow;
    }
  }
}
