import 'package:flutter/material.dart';
import 'package:quiz_mobile/screen/home.dart';
import 'package:quiz_mobile/screen/profile.dart';

class Root extends StatefulWidget {
  final String nama;

  const Root({super.key, required this.nama});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Home(nama: widget.nama),
      ProfilePage(nama: widget.nama),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: _navItems,
      ),
    );
  }
}
