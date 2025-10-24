import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';
import '../Did/detailDid.dart';
import '../../Api/ApiService.dart';
import '../vc/issueVC.dart';

class checkDid extends StatefulWidget {
  const checkDid({super.key});

  @override
  State<checkDid> createState() => _checkDidState();
}

class _checkDidState extends State<checkDid> {
  Map<String, dynamic>? _checkData;
  final primaryColor = Colors.black;
  final labelColor = Colors.greenAccent;
  bool _showDelete = false; //did삭제
  bool _showVC =false;


  Future<void> _checkDid() async {
    final api = ApiService();
    final result = await api.checkDid();

    if (result != null) {
      setState(() {
        _checkData = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkDid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DID 리스트", style: TextStyle(color: Colors.greenAccent)),
        backgroundColor: primaryColor,
        leading: BackButton(color: labelColor),
        actions: [
          // AppBar 삭제 버튼

          TextButton.icon(
              onPressed: (){
                setState(() {
                  _showDelete=!_showDelete;
                });
              },
            label: const Text("삭제", style: TextStyle(color: Colors.redAccent, fontSize: 20),),
          ),

          TextButton.icon(
            onPressed: (){
              setState(() {
                _showVC = !_showVC;
              });
            },
            label:  const Text("VC 발급", style: TextStyle(color: Colors.blueAccent, fontSize: 20),),
          ),


        ],
      ),
      backgroundColor: primaryColor,
      body: _checkData == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '총 DID 개수: ${_checkData!['count']?.toString() ?? '-'}',
              style: TextStyle(
                color: labelColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: (_checkData!['items'] as List<dynamic>).asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final did = item['did'] ?? '';
                final label = item['label'] ?? '-';

                return Column(
                      children: [
                        Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              flex: 4,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) => detailDid(did: did),
                                      ),
                                  );
                                },
                                child: infoCard(title: label, value: did),
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (_showDelete)
                              Flexible(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () async {
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Text("삭제하시겠습니까?",),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, false),
                                            child: const Text("취소"),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, true),
                                            child: const Text("삭제"),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (confirmed == true) {
                                      final api = ApiService();
                                      final success = await api.deleteDid(did);
                                      if (success) {
                                        _checkDid();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("삭제되었습니다.")),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text("삭제 실패")),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                            if (_showVC)
                              Flexible(
                                flex: 1,
                                child: IconButton(
                                  icon: const Icon(Icons.add, color: Colors.blueAccent),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => issueVC(
                                          issuer: did,
                                          subject: did,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                        )
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
