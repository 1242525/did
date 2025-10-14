import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/ApiService.dart';

class verifyCred extends StatefulWidget{
  const verifyCred({super.key});

  State<verifyCred> createState()=> _verifyCredState();
}

class _verifyCredState extends State<verifyCred>{

  Map<String, dynamic>? _veriData;
  bool _isLoading=false;

  Future<void> _veriCred() async{
    setState(() {
      _isLoading=true;
      _veriData;
    });

    final api= ApiService();
    final result= await api.verifyVC();

    if(result!=null){
      final data= jsonDecode(result) as Map<String, dynamic>;
      setState(() {
        _veriData=data;
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