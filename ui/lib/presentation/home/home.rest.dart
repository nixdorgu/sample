import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/home/widgets/header_title.dart';
import 'dart:convert' as convert;

import 'package:ui/presentation/home/widgets/list_tile.dart';

class RestPage extends StatefulWidget {
  final http.Client client;

  RestPage({Key key, this.title, this.client}) : super(key: key);
  final String title;

  @override
  _RestPageState createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> {
  Future<http.Response> getPeople(String link) => widget.client.get(Uri.http('$link:5000', '/people'));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPeople(!Platform.isAndroid ? 'localhost': '10.0.2.2'),
      builder: (context, snapshot) {
        if (!snapshot.hasError && snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            child: Center(
              child: Text("No people found"),
            ),
          );
        }

        final List people = convert.jsonDecode(snapshot.data.body);
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Header(title: 'People REST',),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemExtent: 100,
                itemBuilder: (context, idx) {
                  final person = people[idx];
                  return HomeTile(
                    title: '${person['first_name']} ${person['last_name']}',
                    subtitle: 'Person #${person['id']}',
                  );
                },
                itemCount: people.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
