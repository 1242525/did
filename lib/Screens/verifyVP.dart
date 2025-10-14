import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/ApiService.dart';

class verifyVP extends StatefulWidget{
  const verifyVP({super.key});

  State<verifyVP> createState() => _verifyVPState();
}



class _verifyVPState extends State<verifyVP>{






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('verify present'),
      ),
    );
  }
}