import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // on iOS emulator, swap 10.0.2.2 for localhost
  HttpLink link = HttpLink('https://api.spacex.land/graphql/');

  final http.Client restClient = http.Client();

  ValueNotifier<GraphQLClient> graphClient = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: link,
    ),
  );

  runApp(MyApp(restClient: restClient, graphClient: graphClient));
}

class MyApp extends StatelessWidget {
  final http.Client restClient;
  final ValueNotifier<GraphQLClient> graphClient;

  const MyApp({Key key, this.restClient, this.graphClient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(restClient: restClient, graphClient: graphClient),
    );
  }
}
