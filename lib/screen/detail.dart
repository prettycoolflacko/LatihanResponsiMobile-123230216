import 'package:flutter/material.dart';
import 'package:quiz_mobile/screen/root.dart';
import '../models/menu.dart';

class FoodDetailPage extends StatefulWidget {
  final Food food;
  final String nama;
  const FoodDetailPage({super.key, required this.food, required this.nama});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  final TextEditingController _jumlah = TextEditingController();
  late Food food;
  String total = "";
  bool isCheckedOut = false;

  @override
  void initState(){
    super.initState();
    food = widget.food;
    total = food.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(widget.food.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(widget.food.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
              
            ),
            Container(
            padding: EdgeInsets.all(16),
            child: Row(
              spacing: 20,
              children: [
                Text(widget.food.name,style: TextStyle(fontSize: 20, fontWeight: FontWeight(800)),),
                Text(widget.food.category),
              ],
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: Rp ${widget.food.price}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description: ${widget.food.description}',
                    style: TextStyle(fontSize: 15,),
                  ),
                  Text(
                    'Ingredients: ${widget.food.ingredients}',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
            margin: EdgeInsets.all(20),
            width: 350,
            child: TextField(
              controller: _jumlah,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Jumlah"),
                hintText: "example : 4",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Text("Price : " + total, style: TextStyle(fontSize: 16, fontWeight: FontWeight(800)),),
          ),
          Container(
            
            margin: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ElevatedButton(onPressed: () {
              int jumlahInt = 0;
              try{
              jumlahInt = int.parse(_jumlah.text);
              }catch(e){
              print(e);
              }
              setState(() {
              total = (food.price * jumlahInt).toString();
              });
              },
              child: Text("Tes Ombak"),
              ),
              SizedBox(width: 20,),
              ElevatedButton(onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Berhasil memesan ${_jumlah.text} porsi ${food.name} dengan total harga Rp $total')),);
                Navigator.pop( context, MaterialPageRoute(builder: (context) => Root(nama: widget.nama)), );
              }, child: Text("Pesan Sekarang"),),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}
