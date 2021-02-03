import 'package:flutter/material.dart';
import 'package:instagram_clone_ver2/feed_screen.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];

  List<Widget> _screens = [
    FeedScreen(),
    Container(color: Colors.pinkAccent),
    Container(color: Colors.cyanAccent),
    Container(color: Colors.deepOrangeAccent),
    Container(color: Colors.yellowAccent),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: btmNavItems,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabItem,
      ),
    );
  }

  void _onTabItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
