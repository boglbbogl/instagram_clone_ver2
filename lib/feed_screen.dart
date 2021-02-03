import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Instagram',
          style: TextStyle(fontFamily: 'VeganStyle', color: Colors.black87),
        ),
      ),
    );
  }
}
