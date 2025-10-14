import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl =' ';

  Future<String?> createDid() async {
    final url = Uri.parse('$baseUrl/');

    try {
      final response = await http.post(
        url,
        headers: {'Contetnt-Type': 'application/json'},
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        print('응답: ${response.body}');
        return response.body;
      } else {
        print('응답 실패: ${response.statusCode}');
      }
    } catch (e, stack) {
      print('예외발생: $e');
      print(stack);
    }
  }

  Future<String?> createVC()async {
    final url = Uri.parse('$baseUrl/');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}),
      );

      if (response.statusCode == 200) {
        print('응답: ${response.body}');
        return response.body;
      } else {
        return null;
      }
    } catch (e, stack) {
      print('예외발생 : $e');
      print(stack);
    }
  }

  Future<String?> createVP()async{
    final url=Uri.parse('$baseUrl/');

    try{
    final response= await http.post(url,
    headers: {'Content-Type': 'application/json'},
      body: jsonEncode({}),
    );

    if(response.statusCode==200) {
      print('응답: ${response.body}');
      return response.body;
    }else{
      return null;

    }
  }catch(e, stack){
      print('예외발생: $e');
      print(stack);
    }

  }

  Future<String?> verifyVC()async {
    final url = Uri.parse('$baseUrl/');

    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}),

      );
      if (response.statusCode == 200) {
        print('응답: ${response.body}');
        return response.body;
      } else {
        return null;
      }
    } catch (e, stack) {
      print('예외발생 : $e');
      print(stack);
    }
  }

  Future<String?> verifyVP()async {
    final url = Uri.parse('$baseUrl/');

    try {
      final response = await http.post(url,
        headers: {'content-Type': 'applications/json'},
        body: jsonEncode({}),
      );
      if (response.statusCode == 200) {
        print('응답: ${response.body}');
        return response.body;
      } else {
        return null;
      }
    } catch (e, stack) {
      print('예외발생: $e');
      print(stack);
    }
  }
}
