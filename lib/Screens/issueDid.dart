import 'dart:convert';

import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class makeDid extends StatefulWidget {
  const makeDid({super.key});

  State<makeDid> createState()=> _makeDidState();
}

class _makeDidState extends State<makeDid> {

Map<String, dynamic>? _didData;
bool _isLoading =false;

  Future<void> _issueDid() async {
    setState(() {
      _isLoading=true;
      _didData;
      }
    );

    final api=ApiService();
    final result=await api.issueDid();
    if(result!=null){
      final data= jsonDecode(result) as Map<String, dynamic>;
      setState(() {
        _didData=data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 40),

            )
        )
    );

  }
}


