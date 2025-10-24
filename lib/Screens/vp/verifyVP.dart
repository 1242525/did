import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';
import '../vp/issueVP.dart';


class verifyVP extends StatefulWidget{

  final String vp_jwt;
  final String aud;

  const verifyVP ({
    super.key,
    required String this.vp_jwt,
    required String this.aud});

  State<verifyVP> createState()=> _verifyVPState();

}

class _verifyVPState extends State<verifyVP>{

  Map<String, dynamic>? verifyData;
  Map<String, dynamic>? vcPayloadData;

  Future<void> _verifyVP() async {
    try {
      final ApiService api = ApiService();
      final result = await api.verifyVP(vp_jwt: widget.vp_jwt);

      if (result != null) {
        print("응답 타입: ${result.runtimeType} ");
        print("출력값 : $result ");

        final decoded = jsonDecode(result) as Map<String, dynamic>;

        // verifiableCredential 안의 JWT 문자열 가져오기
        final vc_jwt = decoded['payload']?['vp']?['verifiableCredential']?[0];

        Map<String, dynamic>? vcData;
        if (vc_jwt != null) {
          vcData = Jwt.parseJwt(vc_jwt);
        }

        setState(() {
          verifyData = decoded;
          vcPayloadData = vcData;
        });
      }

    } catch (e, stack) {
      print("예외타입: $e");
      print("스택 트레이스 : $stack");
    }
  }

  @override
  void initState() {
    super.initState();
    _verifyVP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.greenAccent,),
        title: const Text("VP 검증", style: TextStyle(color: Colors.greenAccent),),
      ),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),

        child:Center(
            child: Column(
              children: [
                if (verifyData != null) ...[
                  // VP 전체 유효성
                  infoCard(title: "VP 유효성", value: verifyData!['valid']?.toString() ?? '-'),

                  // 개별 VC 파싱 후 정보
                  infoCard(title: "VC 만료", value: vcPayloadData!['exp']?.toString() ?? '-'),
                  infoCard(title: "발급자", value: vcPayloadData!['iss']?.toString() ?? '-'),
                  infoCard(title: "소유자", value: vcPayloadData!['sub']?.toString() ?? '-'),
                  infoCard(title: "이름", value: vcPayloadData!['vc']?['credentialSubject']?['name']?.toString() ?? '-'),
                  infoCard(title: "사번", value: vcPayloadData!['vc']?['credentialSubject']?['employeeId']?.toString() ?? '-'),
                ]

              ],
            )
        ),
      ),
    );
  }
}