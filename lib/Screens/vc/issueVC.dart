import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';
import '../vp/issueVP.dart';


class issueVC extends StatefulWidget{
  final String issuer;
  final String subject;


  const issueVC ({super.key,
  required this.issuer,
  required this.subject,
  });

  State<issueVC> createState() => _issueVCState();

}

class _issueVCState extends State<issueVC> {

  Map<String, dynamic>? vcData;

  TextEditingController _ttlController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _idController = TextEditingController();

  final primaryColor = Colors.black;
  final labelColor = Colors.greenAccent;

  Future<void> _issueVC(int ttl, Map<String, dynamic>claims) async {


    final aud = "verifier.example";

    final ApiService api = ApiService();
    final result = await api.issueVC(
      issuer: widget.issuer,
      subject: widget.subject,
      claims: claims,
      ttl: ttl,
      aud: aud,);

    if (result != null) {
      print("결과 타입: ${result.runtimeType}");
      print("결과 내용: $result");

      setState(() {
        vcData = result;
      });
    } else {
      print("vc 발급 실패: null 반환");
    }
  }

  @override
  void initState() {
    super.initState();
    print("issuer: did:key:..."); // 하드코딩
    print("subject: ${widget.subject}"); // 이 값 확인
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(color: Colors.greenAccent,),
        title: const Text(
          "VC 발급", style: TextStyle(color: Colors.greenAccent),),
        actions: [
          TextButton.icon(
            onPressed: vcData == null ? null : () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) =>
                    issueVP(
                      holder: widget.subject, vc_jwts: [vcData!['vc_jwt']],
                    ),
                ),
              );
            },
            label: const Text("VP 생성",
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
            SizedBox( width:  400,
            child: TextField(
              controller: _ttlController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "유효시간 입력",
                labelStyle: TextStyle(color: labelColor),
                border: OutlineInputBorder(),
              ),
            ),
          ),
            const SizedBox(height: 8),

              SizedBox(
                width: 400,
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "이름 입력",
                    labelStyle: TextStyle(color: labelColor),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // 사번/ID 입력
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _idController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "사번 입력",
                    labelStyle: TextStyle(color: labelColor),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),




              // ✅ VC 발급 버튼
              ElevatedButton(
                onPressed: () {
                  int ttlValue = int.tryParse(_ttlController.text) ?? 36000;
                  final claims = {
                    "name": _nameController.text,
                    "employeeId": _idController.text,
                  };
                  _issueVC(ttlValue, claims);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // 버튼 배경색
                  foregroundColor: Colors.black,       // 글자색
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // 버튼 크기 조정
                ),
                child: const Text("발급"),
              ),
              if (vcData != null) ...[
                infoCard(
                    title: "exp",
                    value: vcData?['exp']?.toString() ?? '-'),
                infoCard(
                    title: "JWT",
                    value: vcData?['vc_jwt']?.toString() ?? '-'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
