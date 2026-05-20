import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ProductApi {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<Product>> fetchProducts() async {
    final Uri uri = Uri.parse('$_baseUrl/products?limit=0');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> products = data['products'] as List<dynamic>? ?? [];
    return products
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    final Uri uri = Uri.parse('$_baseUrl/products/category/$category');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products for category: $category');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> products = data['products'] as List<dynamic>? ?? [];
    return products
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<String>> fetchCategories() async {
    final Uri uri = Uri.parse('$_baseUrl/products/category-list');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load categories');
    }

    final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
    return data.map((e) => e as String).toList();
  }

  Future<Product> fetchProductById(int id) async {
    final Uri uri = Uri.parse('$_baseUrl/products/$id');
    final http.Response response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load product $id');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    return Product.fromJson(data);
  }
}
