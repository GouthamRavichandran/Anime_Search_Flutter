import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'SearchExpandPage.dart';

class SearchAnimePage extends StatefulWidget {
  @override
  _SearchAnimePageState createState() => _SearchAnimePageState();
}

class _SearchAnimePageState extends State<SearchAnimePage> {
  final _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  Future<void> _searchAnime(String query) async {
    const searchQuery = r'''
      query ($query: String) {
        Page(page: 1, perPage: 10) {
          media(search: $query, type: ANIME) {
            id
            title {
              romaji
              english              
            }
      startDate {
        year
      }
            coverImage {
              extraLarge
              medium
            }
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
      body: jsonEncode(<String, dynamic>{
        'query': searchQuery,
        'variables': {'query': query},
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _searchResults = data['data']['Page']['media'];
      });
    } else {
      print('Failed to search anime: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Explore...'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Start Exploring',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchAnime(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final anime = _searchResults[index];
                return ListTile(
                  isThreeLine: true,
                  leading: Image.network(anime['coverImage']['medium']),
                  title: Text(anime['title']['english'].toString() == "null" ? "//English Name Currently Not Available." : anime['title']['english']),
                  subtitle: Text(anime['title']['romaji']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchExpandPage(animeId: anime['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
