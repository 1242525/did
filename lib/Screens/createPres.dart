import 'dart:convert';
import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class createPre extends StatefulWidget{
  const createPre({super.key});

  State<createPre> createState () => _createPreCreate();


}

class _createPreCreate extends State<createPre>{

  Map<String, dynamic>? _preData;
  bool _isLoading=false;

  Future<void> _createPre()async {
    setState(() {
      _isLoading = true;
      _preData;
    });

    final api = ApiService();
    final result = await api.createPre();
    if (result != null) {
      final data = jsonDecode(result) as Map<String, dynamic>;
      setState(() {
        _preData = data;
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

