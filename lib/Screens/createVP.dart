import 'dart:convert';
import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class verifyCred extends StatefulWidget{
  const verifyCred({super.key});

  State<verifyCred> createState () => _verifyCredCreate();


}

class _verifyCredCreate extends State<verifyCred>{

  Future<void> _CreateVC()async{
    setState(() {
      String? error= null;

    });

    final api=ApiService();
    final result=await api.createVC();
    if(result!=null){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
              }, child: const Text('credentail ')
              ),

            )
          ],
        ),
      ),

    );
  }


}

