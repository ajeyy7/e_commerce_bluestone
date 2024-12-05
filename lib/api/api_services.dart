import 'dart:convert';
import 'package:e_commerce_bluestone/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts(int limit) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?limit=$limit'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);
        return data
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Failed to Get products');
      }
    } catch (e) {
      throw Exception('Failed to Get products: $e');
    }
  }

  Future<Product> getProductDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to Get product detail');
      }
    } catch (e) {
      throw Exception("Failed to get product details $e");
    }
  }
}
