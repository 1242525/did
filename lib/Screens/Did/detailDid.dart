import 'checkDid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Widget/infoCard.dart';
import '../../Api/ApiService.dart';

class detailDid extends StatefulWidget{
  final String did;
  const detailDid ({super.key, required this.did});


  
  State<detailDid> createState() => _detailDidState();
  
}

class _detailDidState extends State<detailDid>{
  
  Map<String, dynamic>? detail;
  final labelColor= Colors.pink[50];
  
  Future<void> _detailDid(String did)async{
    final ApiService api= ApiService();
    final result= await api.detailDid(did);
    
    setState(() {
      detail=result;
    });
  }

  @override
  void initState(){
    super.initState();
    _detailDid(widget.did);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("did 상세정보"),
        leading: BackButton(color: labelColor),),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          infoCard(title: "@context", value: detail?['@context']?.toString() ?? '-'),
          infoCard(title: "id", value: detail?['id']?.toString() ?? '-'),
          infoCard(title: "verificationMethod", value: detail?['verificationMethod']?.toString() ?? '-'),
          infoCard(title: "assertionMethod", value: detail?['assertionMethod']?.toString() ?? '-'),
          infoCard(title: "authentication", value: detail?['authentication']?.toString() ?? '-'),
          infoCard(title: "capabilityDelegation", value: detail?['capabilityDelegation']?.toString() ?? '-'),
          infoCard(title: "capabilityInvocation", value: detail?['capabilityInvocation']?.toString() ?? '-'),
          infoCard(title: "keyAgreement", value: detail?['keyAgreement']?.toString() ?? '-'),
        ],
      ),
    );
  }
}