import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Did/issueDid.dart';
import 'Did/checkDid.dart';
import 'vp/issueVP.dart';
import 'vc/issueVC.dart';
import '../Screens/vc/issueVC.dart';

class homeScreen extends StatelessWidget{
  homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 200),
                _buildHomeButton(
                  context,
                  text: 'issue DID',
                  icon: Icons.person,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MakeDid(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
                _buildHomeButton(
                  context,
                  text: 'DID List',
                  icon: Icons.list,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => checkDid()
                      ),
                    );
                  },
                ),




              ],

            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton(
      BuildContext context, {
        required String text,
        required IconData icon,
        required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 260,
      height: 56,
      child: OutlinedButton.icon(onPressed: onPressed,
          icon: Icon(icon, size: 22, color: Colors.pink[50]),
        label: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.pink[50]
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.pink[50]!, width: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
          ),
    );
  }
}