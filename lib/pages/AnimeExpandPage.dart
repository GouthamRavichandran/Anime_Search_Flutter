import 'package:flutter/material.dart';

class AnimeExpandPage extends StatelessWidget {
  final dynamic anime;

  const AnimeExpandPage({Key? key, required this.anime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(anime['title']['english']),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Center(
    child: Image.network(anime['coverImage']['extraLarge'],
    width: 200,
    ),
    ),
    const SizedBox(height: 16),
    Text(
    'Episodes: ${anime['episodes'].toString() == "null" ? "Data currently not available" : anime['episodes']}',
    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
      IconButton(
        icon: const Icon(Icons.favorite_border),
        color: Colors.pink,
        onPressed: () {
          color: Colors.pink;
          print("Favorite done");
        },
      ),
    const SizedBox(height: 10),
    Text(
        'Telecast Year: ${anime['startDate']['year']}',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    const SizedBox(height: 10),
    const Text(
    'Description:',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 10),
    Text(
    anime['description'],
    style: const TextStyle(fontSize: 16),
      )
    ]
    )
    )
    )
    );
  }
}

