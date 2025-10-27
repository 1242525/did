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
    this.labelColor = Colors.black

  });

  @override
  Widget build(BuildContext context){
    return Card(
      color: Colors.pink[50],
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(
                fontWeight: FontWeight.bold, color: labelColor)),
            const SizedBox(height: 15),
            SelectableText(value,
                style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),),
          ],
        ),
      ),
    );
  }

}