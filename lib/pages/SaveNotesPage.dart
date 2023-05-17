import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SaveNotesPage()
));

// void main() => runApp();

class SaveNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Anime Notes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  late File _notesFile;
  String _notesText = '';

  @override
  void initState() {
    super.initState();
    _getLocalFile();
  }

  Future<void> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    _notesFile = File('${directory.path}/animenotes.txt');
    if (await _notesFile.exists()) {
      setState(() {
        _notesText = _notesFile.readAsStringSync();
      });
    }
  }

  Future<void> _SaveNotesPage() async {
    await _notesFile.writeAsString(_notesText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _SaveNotesPage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _textEditingController,
          onChanged: (String text) {
            setState(() {
              _notesText = text;
            });
          },
          maxLines: null,
          decoration: const InputDecoration(
            hintText: 'Type your Anime Notes here',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _SaveNotesPage();
    super.dispose();
  }
}
