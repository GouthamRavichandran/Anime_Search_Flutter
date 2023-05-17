import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'AnimeExpandPage.dart';

class TrendingAnimePage extends StatefulWidget {
  @override
  _TrendingAnimePageState createState() => _TrendingAnimePageState();
}

class _TrendingAnimePageState extends State<TrendingAnimePage> {
  List<dynamic> animeList = [];

  Future<void> _fetchTopAnime() async {
    const query = r'''
      query {
        Pop: Page(page: 1, perPage: 20) {
          media(sort: TRENDING_DESC, type: ANIME) {
            title {
              english
            }
            coverImage {
              medium
              extraLarge
            }
      startDate {
        year
      }
      episodes
      popularity
      description(asHtml: false)
      }
    }
  }
    ''';

    final response = await http.post(
      Uri.parse('https://graphql.anilist.co/'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{'query': query}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        animeList = data['data']['Pop']['media'];
      });
    } else {
      print('Failed to fetch top anime: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTopAnime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Anime'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          final anime = animeList[index];
          int? num = anime['episodes'];
          num ??= 0;
          int? pop = anime['popularity'];
          pop ??= 0;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeExpandPage(anime: anime),
                ),
              );
            },
            child: Card(
              child: ListTile(
                leading: Image.network(anime['coverImage']['medium']),
                title: Text(anime['title']['english']),
                subtitle: Text('$pop'),
                trailing: Text('$num'),
              ),
            ),
          );
        },
      ),
    );
  }
}
