import 'package:benyiino_shop/controllers/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreCart extends StatelessWidget {
  StoreCart({super.key});
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Visibility(
                  visible: _homeController.cart.isNotEmpty,
                  child: const Text(
                    'Carrito',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _homeController.cart.isEmpty ? 1 : _homeController.cart.length,
                    itemBuilder: (context, index) {
                      if (_homeController.cart.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.3),
                          child: const Text(
                            'No hay productos en el carrito',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final cartProduct = _homeController.cart[index];

                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(cartProduct.product.image),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartProduct.product.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                '\$${cartProduct.product.price} x ${cartProduct.quantity} = \$${double.parse((cartProduct.product.price * cartProduct.quantity).toStringAsFixed(2))}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                            onPressed: () {
                              _homeController.removeFromCart(cartProduct.product);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                            onPressed: () {
                              _homeController.addToCart(cartProduct.product);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () {
                              _homeController.deleteFromCart(cartProduct);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              Expanded(
                child: Text(
                  '\$${_homeController.totalPrice}',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: ElevatedButton(
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('Continuar'),
            ),
          ),
        ),
      ],
    );
  }
}
