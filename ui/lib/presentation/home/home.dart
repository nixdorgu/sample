import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/home/home.graphql.dart';

// import 'package:ui/presentation/home/home.graphql.dart';
import 'package:ui/presentation/home/home.rest.dart';

class Home extends StatefulWidget {
  final http.Client restClient;
  final ValueNotifier<GraphQLClient> graphClient;
  const Home({Key key, this.restClient, this.graphClient}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  http.Client restClient;
  ValueNotifier<GraphQLClient> graphClient;
  List<Widget> pages;

  @override
  initState() {
    restClient = widget.restClient;
    graphClient = widget.graphClient;
    pages = [RestPage(client: restClient), GraphPage(client: graphClient)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Graph/REST Demo'),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home REST',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service),
            label: 'Home GraphQL',
          )
        ],
      ),
    );
  }
}
