import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/ApiService.dart';
import 'dart:convert';

class createCred extends StatefulWidget{
  const createCred({super.key});

  State<createCred> createState ()=> _createCredState();
}

class _createCredState extends State<createCred> {


  Map<String, dynamic>? _credData;
  bool _isLoading = false;

  Future<void> _createCred() async {

    final api = ApiService();
    final result = await api.createCred();
    if (result != null) {
      final data = jsonDecode(result) as Map<String, dynamic>;
      setState(() {
        _credData = data;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

    );
  }
}