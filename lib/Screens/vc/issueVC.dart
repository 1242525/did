import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';
import '../../Api/ApiService.dart';

class issueVC extends StatefulWidget{
  final String issuer;
  final String subject;

  const issueVC ({super.key,
  required this.issuer,
  required this.subject});

  State<issueVC> createState() => _issueVCState();

}

class _issueVCState extends State<issueVC> {

  Map<String, dynamic>? vcData;

  Future<void> _issueVC() async {
    final claims = {"name": "Alice", "employeeId": "E-123"};
    final ttl = 36000;
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
      print("DID 발급 실패: null 반환");
    }
  }


  @override
  void initState() {
    super.initState();
    _issueVC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("VC 발급", style: TextStyle(color: Colors.greenAccent),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            infoCard(
                title: "exp", value: vcData?['exp']?.toString() ?? '-'),
            infoCard(title: "JWT", value: vcData?['vc_jwt']?.toString() ?? '-'),

          ],
        ),
      ),
      ),
    );
  }
}
