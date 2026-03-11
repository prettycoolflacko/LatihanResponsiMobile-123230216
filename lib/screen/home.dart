import 'package:flutter/material.dart';
import 'package:quiz_mobile/models/menu.dart';
import 'detail.dart';

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
        itemCount: dummyFoods.length,
        itemBuilder: (context, index) {
          Food items = dummyFoods[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailPage(food: items, nama: widget.nama),
                ),
              );
            },
            child: Card(
              shape: const RoundedRectangleBorder(),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: SizedBox(
                  width: 56,
                  height: 56,
                  child: Image.network(
                    items.image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('${items.name} '),
                subtitle: Text('${items.category} - Rp ${items.price}'),
                isThreeLine: true,
              ),
            ),
          );
        },
      ),
    );
  }
}