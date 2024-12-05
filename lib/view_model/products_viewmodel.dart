import 'package:e_commerce_bluestone/api/api_services.dart';
import 'package:e_commerce_bluestone/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider() {
    getProducts();
  }

  final ApiService _apiService = ApiService();

  final Set<Product> _productsSet = {};
  List<Product> products = [];

  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> getProducts() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    try {
      final newProducts = await _apiService.getProducts(currentPage * 5);

      if (newProducts.isEmpty) {
        hasMore = false;
      } else {
        _productsSet.addAll(newProducts);
        products = _productsSet.toList();

        currentPage++;
      }
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Product?> getProductDetails(int productId) async {
    try {
      return await _apiService.getProductDetail(productId);
    } catch (e) {
      print("Error fetching product details: $e");
      return null;
    }
  }
}
