import 'dart:convert';

import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';
import '../vp/verifyVP.dart';

class issueVP extends StatefulWidget{

  final String holder;
  final List<String> vc_jwts;


  issueVP ({super.key,
  required String this.holder,
    required List<String> this.vc_jwts
  });

  State<issueVP> createState ()=> _issueVPState();

}

class _issueVPState extends State<issueVP> {

  Map<String, dynamic>? vpData;


  Future <void> _issueVP() async {

    try{
      final ApiService api = ApiService();
      final result = await api.issueVP(
        holder: widget.holder,
        vc_jwts: widget.vc_jwts);

    if (result != null) {
      print(" 실행결과: ${result.runtimeType}");
      print("출력값: $result");

      final decoded = jsonDecode(jsonEncode(result)) as Map<String, dynamic>;

      setState(() {
        vpData = decoded;
      });
    } }
        catch(e, stack){
      print("응답 에러 : $e");
      print("$stack");
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.vc_jwts.isNotEmpty) {
      _issueVP();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text(" VP 생성"),backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.pink[50], // 텍스트 색상 지정
          fontSize: 20,              // 필요하면 글자 크기 지정
          fontWeight: FontWeight.bold,
        ),
        actions: [
          TextButton.icon(
            onPressed: vpData ==null ? null:(){
              final vp_jwt = vpData!['vp_jwt'] as String?;
              if (vp_jwt != null) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) =>
                     verifyVP(vp_jwt: vp_jwt, aud: '',)
                  ),
                );
              }
            },
            label: const Text("VP 검증", style: TextStyle(color: Colors.blueAccent, fontSize: 20),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),

        child:Center(
        child: Column(
          children: [
            if (vpData != null) ...[
          infoCard(title: "VP 만료(exp)", value: vpData!['exp']?.toString() ?? '-'),
        infoCard(title: "VP JWT", value: vpData!['vp_jwt'] ?? '-'),
        ],
    ],
        )
    ),
    ),
    );
  }
}