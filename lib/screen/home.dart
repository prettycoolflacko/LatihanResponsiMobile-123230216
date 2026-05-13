import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_mobile/models/space_api.dart';
import 'package:quiz_mobile/screen/content_list.dart';

class _MenuItem {
  final ContentType type;
  final String title;
  final String subtitle;
  final IconData icon;

  const _MenuItem({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

const List<_MenuItem> _menuItems = [
  _MenuItem(
    type: ContentType.news,
    title: 'News',
    subtitle: 'Latest spaceflight news',
    icon: Icons.public,
  ),
  _MenuItem(
    type: ContentType.blogs,
    title: 'Blogs',
    subtitle: 'Community and official blogs',
    icon: Icons.article,
  ),
  _MenuItem(
    type: ContentType.reports,
    title: 'Reports',
    subtitle: 'Agency and mission reports',
    icon: Icons.assessment,
  ),
];

class Home extends StatefulWidget {
  final String nama;
  const Home({super.key, required this.nama});

  @override
  State<Home> createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(
          'Welcome, ${widget.nama}!',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _menuItems.length,
        itemBuilder: (context, index) {
          final _MenuItem item = _menuItems[index];
          return GestureDetector(
            onTap: () {
              Get.to(
                () => ContentListPage(
                  type: item.type,
                  nama: widget.nama,
                ),
              );
            },
            child: Card(
              shape: const RoundedRectangleBorder(),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  child: Icon(item.icon, color: Colors.black87),
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.subtitle),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          );
        },
      ),
    );
  }
}