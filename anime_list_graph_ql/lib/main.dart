import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(_initGraphQLClient()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StarWarsScreen(),
      ),
    );
  }

  GraphQLClient _initGraphQLClient() {
    final httpLink = HttpLink(
      'https://swapi-graphql.netlify.app/.netlify/functions/index',
    );

    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    );
  }
}

class StarWarsScreen extends StatelessWidget {
  final String fetchFilmsQuery = """
    query {
      allFilms {
        films {
          id
          title
          releaseDate
          director
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Wars Films'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(fetchFilmsQuery),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text('Error: ${result.exception.toString()}'));
          }
          log(result.data.toString());
          final films = result.data?['allFilms']['films'] as List<dynamic>;

          return ListView.builder(
            itemCount: films.length,
            itemBuilder: (context, index) {
              final film = films[index];
              log(film.toString());
              return ListTile(
                leading: Image.network(
                    "https://static.wikia.nocookie.net/starwars/images/c/cc/Star-wars-logo-new-tall.jpg/revision/latest/scale-to-width-down/1200?cb=20190313021755"),
                title: Text(film['title']),
                subtitle: Text('Directed by ${film['director']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          StarWarsDetailsScreen(filmId: film['id']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class StarWarsDetailsScreen extends StatelessWidget {
  final String filmId;

  const StarWarsDetailsScreen({super.key, required this.filmId});

  final String fetchFilmDetailsQuery = """
    query(\$id: ID!) {
      film(id: \$id) {
        title
        director
        releaseDate
        openingCrawl
        producers
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film Details'),
      ),
      body: SingleChildScrollView(
        child: Query(
          options: QueryOptions(
            document: gql(fetchFilmDetailsQuery),
            variables: {'id': filmId},
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (result.hasException) {
              return Center(
                  child: Text('Error: ${result.exception.toString()}'));
            }
            log(result.data.toString());
            final film = result.data?['film'];
            log(film.toString());

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    film['title'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Director: ${film['director']}'),
                  Text('Producers: ${film['producers'].join(", ")}'),
                  Text('Release Date: ${film['releaseDate']}'),
                  const SizedBox(height: 16),
                  const Text(
                    'Opening Crawl:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(film['openingCrawl']),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
