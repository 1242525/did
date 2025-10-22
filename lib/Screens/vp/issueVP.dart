/*import 'dart:convert';
import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';

class createPre extends StatefulWidget{
  const createPre({super.key});

  State<createPre> createState () => _createPreCreate();


}

class _createPreCreate extends State<createPre>{
  final primaryColor= Colors.black;
  final labelColor= Colors.greenAccent;

  Map<String, dynamic>? _preData;
  bool _isLoading=false;

  Future<void> _createPre()async {
    setState(() {
      _isLoading = true;
      _preData;
    });

    final api = ApiService();
    final result = await api.i();
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: BackButton(color: labelColor,),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: _preData != null
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            infoCard(title: "DID", value: _preData!['DID :'] ?? '-'),
            // 다른 결과 위젯 추가 가능
          ],
        )
            : SizedBox.shrink(),
      ),
    );

  }


}

 */



