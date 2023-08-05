import 'package:flutter/material.dart';
import 'package:problema/Homepage.dart';
import 'home.dart';
import 'package:problema/ProjectsPage.dart';
import 'package:flutter/material.dart';
import 'home.dart';


class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      _navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => HomePage()));
    } else if (index == 1) {
      _navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => ProjectsPage()));
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: kBottomNavigationBarHeight + 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: _selectedIndex == 0 ? Colors.lightBlue : Colors.grey,
            onPressed: () => _onItemTapped(0),
          ),
          IconButton(
            icon: Icon(Icons.business),
            color: _selectedIndex == 1 ? Colors.lightBlue : Colors.grey,
            onPressed: () => _onItemTapped(1),
          ),
          SizedBox(width: 48),
          IconButton(
            icon: Icon(Icons.message),
            color: _selectedIndex == 2 ? Colors.lightBlue : Colors.grey,
            onPressed: () => _onItemTapped(2),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            color: _selectedIndex == 3 ? Colors.lightBlue : Colors.grey,
            onPressed: () => _onItemTapped(3),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Flutter Navigation Bar'),
      // ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => HomePage());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
