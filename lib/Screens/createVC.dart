import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/ApiService.dart';
import 'dart:convert';

class createCred extends StatefulWidget{
  const createCred({super.key});

  State<createCred> createState()=> _createCredState();
}

class _createCredState extends State<createCred>{

  Map<String, dynamic>? _keyPairData;
  bool _isLoading=false;
  String? _error;

  Future<void> createDid()async{
    setState(() {
      _isLoading=true;
      _error=null;
    });

    final api=ApiService();
    final result=await api.createDid();
    if (result!=null){
      final data= jsonDecode(result) as Map<String, dynamic>;
    }

  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.black,
   );
  }
}