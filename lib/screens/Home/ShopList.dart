import 'package:benyiino_shop/controllers/HomeController.dart';
import 'package:benyiino_shop/screens/Home/HomeScreen.dart';
import 'package:benyiino_shop/screens/Product/ProductDetails.dart';
import 'package:benyiino_shop/widgets/StaggeredDualView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopList extends StatelessWidget {
  ShopList({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: cartBarHeight),
      child: StaggeredDualView(
        aspectRatio: 0.6,
        offsetPercent: 0.6,
        itemCount: _homeController.catalog.length,
        itemBuilder: (context, index) {
          final product = _homeController.catalog[index];

          return GestureDetector(
            onTap: () {
              if (_homeController.state == GroceryState.cart) {
                _homeController.state = GroceryState.normal;
              } else {
                Get.to(() => ProductDetails(product: product));
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Get.isDarkMode ? Colors.grey[700] : Colors.grey[300],
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Hero(
                        tag: 'list_${product.id}',
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.contain,
                          height: 120,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      product.weight,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
