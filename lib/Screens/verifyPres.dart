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

  final primaryColor = Colors.black;
  final labelColor = Colors.greenAccent;


  Future<void> _veriPres()async{
    setState(() {
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

  Widget _buildCard(String title, String value){
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: labelColor)),
            const SizedBox(height: 8),
            SelectableText(value, style: const TextStyle(fontSize: 14, fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: BackButton(color: labelColor,),
      ),
      body: Center(
        child: _presData != null
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCard('주소', _presData!['DID :'] ?? '-'),
            // 다른 결과 위젯 추가 가능
          ],
        )
            : SizedBox.shrink(),
      ),
    );


  }
}