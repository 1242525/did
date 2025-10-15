import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class infoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color labelColor;


  const infoCard({
    super.key,
    required this.title,
    required this.value,
    this.labelColor = Colors.greenAccent

  });

  @override
  Widget build(BuildContext context){
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(
                fontWeight: FontWeight.bold, color: labelColor)),
            const SizedBox(height: 8),
            SelectableText(value,
                style: const TextStyle(fontSize: 14, fontFamily: 'monospace')),
          ],
        ),
      ),
    );
  }

}