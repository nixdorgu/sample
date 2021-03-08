import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        top: 24,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFF005288),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
