import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const HomeTile({Key key, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 24),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
