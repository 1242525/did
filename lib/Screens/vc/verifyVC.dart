/*import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';

import '../../Api/ApiService.dart';

class verifyCred extends StatefulWidget{
  const verifyCred({super.key});

  State<verifyCred> createState()=> _verifyCredState();
}

class _verifyCredState extends State<verifyCred>{

  Map<String, dynamic>? _veriData;

  final primaryColor = Colors.black;
  final labelColor = Colors.greenAccent;

  Future<void> _veriCred() async{
    setState(() {
      _veriData=null;
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
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: BackButton(color: labelColor,),
      ),
      body: Center(
        child: _veriData!= null
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            infoCard(title: 'verifyCred', value: _veriData![' '] ?? '-'),
            // 다른 결과 위젯 추가 가능
          ],
        )
            : SizedBox.shrink(),
      ),
    );


  }
}

 */