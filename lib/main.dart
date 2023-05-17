import 'package:flutter/material.dart';
import 'pages/TopAnimePage.dart';
import 'pages/TrendingAnimePage.dart';
import 'pages/SearchAnimePage.dart';
import 'pages/SaveNotesPage.dart';


void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyBottomNavigationBar()
));

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TrendingAnimePage(),
    TopAnimePage(),
    SearchAnimePage(),
    SaveNotesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_sharp),
            label: 'Trending Anime',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.vertical_align_top_rounded),
            label: 'Top Anime',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search_sharp),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_sharp),
            label: 'Notes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// class Home extends StatelessWidget{
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Track your Fav Anime',
//           style: TextStyle(
//             fontSize: 30.0,
//             letterSpacing: 2.0,
//             color: Colors.blue,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Poppins'),
//       ),
//         centerTitle: true,
//         backgroundColor: Colors.pink[200],
//       ),
//       body: Center(
//         child: ElevatedButton.icon(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.cyan,
//               elevation: 2,
//               minimumSize: const Size(300.0, 70.0),
//             ),
//             onPressed: () {
//               print("hell");
//             },
//             label: const Text("Let's Go",
//               style: TextStyle(
//                   fontSize: 30.0,
//                   letterSpacing: 2.0,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'IndieFlower'),
//             ),
//           icon: const Icon(
//               Icons.run_circle_outlined
//           ),
//         )
//         ),
//
//         );
//   }
// }