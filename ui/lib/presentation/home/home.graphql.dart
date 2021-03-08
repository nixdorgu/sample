import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ui/presentation/home/widgets/header_title.dart';
import 'package:ui/presentation/home/widgets/list_tile.dart';

class GraphPage extends StatefulWidget {
  final ValueNotifier<GraphQLClient> client;
  GraphPage({Key key, this.client}) : super(key: key);

  @override
  _GraphPageState createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final _query = '''
    query getUsers {
      users {
        id
        name
        timestamp
        twitter
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.client,
      child: CacheProvider(
        child: Query(
          options: QueryOptions(
            document: gql(_query),
            fetchPolicy: FetchPolicy.cacheAndNetwork,
          ),
          builder: (
            QueryResult result, {
            VoidCallback refetch,
            FetchMore fetchMore,
          }) {
            if (result.isLoading) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final List people = result.data['users'];

            if (people == null || people.isEmpty) {
              return Container(
                child: Center(
                  child: Text("No people found"),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Header(title: 'People GQL'),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, idx) {
                      final person = people[idx];
                      return HomeTile(
                        title: '${person['name']}',
                        subtitle: '${person['id']}',
                      );
                    },
                    itemCount: people.length,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
