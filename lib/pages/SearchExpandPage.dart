import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchExpandPage extends StatefulWidget {
  final int animeId;

  SearchExpandPage({required this.animeId});

  @override
  _SearchExpandPageState createState() => _SearchExpandPageState();
}

class _SearchExpandPageState extends State<SearchExpandPage> {
  Map<String, dynamic> _animeData = {};

  Future<void> _fetchAnimeDetails() async {
    const query = r'''
      query ($id: Int!) {
        Media(id: $id, type: ANIME) {
          id
          title {
            english
          }
          description
          averageScore
          coverImage {
            extraLarge
            large
            medium
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
        'query': query,
        'variables': <String, dynamic>{
          'id': widget.animeId,
        },
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _animeData = data['data']['Media'];
      });
    } else {
      print('Failed to fetch anime details: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAnimeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_animeData['title']['english'] ?? 'Anime Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(_animeData['coverImage']['large']),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _animeData['title']['english'] ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _animeData['description'] ?? 'Description currently Unavailable',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Average Score: ${_animeData['averageScore'] ?? 'NA or very few scores to determine average'}',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
