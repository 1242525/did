import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/ApiService.dart';
import 'dart:convert';
import '../Widget/infoCard.dart';

class createCred extends StatefulWidget{
  const createCred({super.key});

  State<createCred> createState ()=> _createCredState();
}

class _createCredState extends State<createCred> {

  final primaryColor= Colors.black;
  final labelColor= Colors.greenAccent;

  Map<String, dynamic>? _credData;

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
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: BackButton(color: labelColor,),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: _credData != null
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            infoCard(title: "Create Credential", value: _credData![' '] ?? '-'),
            // 다른 결과 위젯 추가 가능
          ],
        )
            : SizedBox.shrink(),
      ),
    );
  }
}