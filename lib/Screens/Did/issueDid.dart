import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';

class MakeDid extends StatefulWidget {
  const MakeDid({super.key});

  @override
  State<MakeDid> createState() => _MakeDidState();
}

class _MakeDidState extends State<MakeDid> {
  Map<String, dynamic>? _didData;

  TextEditingController _labelController = TextEditingController();

  final primaryColor = Colors.black;
  final labelColor = Colors.greenAccent;

  Future<void> _issueDid(String label) async {
    final api = ApiService();
    final result = await api.issueDid(label);

    if (result != null) {
      print("결과 타입: ${result.runtimeType}");
      print("결과 내용: $result");

      setState(() {
        _didData = result;
      });
    } else {
      print("DID 발급 실패: null 반환");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: BackButton(color: labelColor),
      ),
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 사용자 입력창
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox( width:  400,
                  child: TextField(
                    controller: _labelController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "DID 라벨 입력",
                      labelStyle: TextStyle(color: labelColor),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final label = _labelController.text.trim();
                    if (label.isNotEmpty) {
                      _issueDid(label);
                      _labelController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // 버튼 배경색
                    foregroundColor: Colors.black,       // 글자색
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // 버튼 크기 조정
                  ),
                  child: const Text("생성"),
                ),
              ],
            ),

            const SizedBox(height: 16),


            if (_didData != null) ...[
              infoCard(title: "DID", value: _didData!['did'] ?? '-'),
              infoCard(title: "Fingerprint", value: _didData!['fingerprint'] ?? '-'),
              infoCard(title: "Label", value: _didData!['label'] ?? '-'),
              infoCard(title: "Stored", value: _didData!['stored']?.toString() ?? '-'),
            ],
          ],
        ),
      ),
    );
  }

}
