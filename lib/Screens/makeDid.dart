import 'dart:convert';

import 'package:did/Api/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class makeDid extends StatelessWidget {
  makeDid({super.key});


  Future<void> _getDid() async {
    final api = ApiService();
    final result = await api.createDid();
    if (result != null) {
      final data = jsonDecode(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 40),
                child: Column(
                    children: [
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {
                            print("DID 발급 버튼 클릭됨!");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amberAccent,
                          ),
                          child: const Text('DID 발급', style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ]
                )
            )
        )
    );
  }
}

