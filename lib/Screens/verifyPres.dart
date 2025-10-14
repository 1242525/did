import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/ApiService.dart';

class verifyPres extends StatefulWidget{
  const verifyPres({super.key});

  State<verifyPres> createState()=> _verifyPres();
}

class _verifyPres extends State<verifyPres>{

  Map<String, dynamic>? _presData;
  bool _isLoading=false;

  Future<void> _veriPres()async{
    setState(() {
      _isLoading=true;
      _presData;
    });

    final api= ApiService();
    final result= await api.verifyVP();

    if(result!=null){
      final data= jsonDecode(result) as Map<String, dynamic>;
      setState(() {
        _presData=data;
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