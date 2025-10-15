import 'dart:convert';

import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Widget/infoCard.dart';

class makeDid extends StatefulWidget {
  const makeDid({super.key});

  State<makeDid> createState()=> _makeDidState();
}

class _makeDidState extends State<makeDid> {

Map<String, dynamic>? _didData;

final primaryColor= Colors.black;
final labelColor= Colors.greenAccent;

  Future<void> _issueDid() async {
    setState(() {
      _didData = null;
    }
    );

    final result = await ApiService().issueDid();
    if (result != null) {
      final data = jsonDecode(result) as Map<String, dynamic>;
      setState(() {
        _didData = data;
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
              child: _didData != null
          ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            infoCard(title: "DID", value: _didData!['DID :'] ?? '-'),
            // 다른 결과 위젯 추가 가능
          ],
        )
            : SizedBox.shrink(),
    ),
    );


  }
}


