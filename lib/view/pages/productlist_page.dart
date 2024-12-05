import 'package:e_commerce_bluestone/constants/color.dart';
import 'package:e_commerce_bluestone/view/pages/productsdetails_page.dart';
import 'package:e_commerce_bluestone/view_model/products_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Badge(
              backgroundColor: primary,
              label: const Text('2'),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              productProvider.hasMore &&
              !productProvider.isLoading) {
            productProvider.getProducts();
          }
          return false;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productProvider.products.length +
                    (productProvider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == productProvider.products.length) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final product = productProvider.products[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            productId: product.id,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 2,
                                  color: Colors.grey,
                                  spreadRadius: 0.4)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(product.image,
                                  width: 150, height: 150, fit: BoxFit.contain),
                              const SizedBox(width: 20),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Text(product.title,
                                              style: const TextStyle(
                                                  fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: primary, fontSize: 15),
                                        ),
                                        Text(
                                            ' ${product.rating.count} Orders & Rating: ${product.rating.rate}',
                                            style:
                                                const TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
