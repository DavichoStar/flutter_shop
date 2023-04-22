import 'package:benyiino_shop/controllers/HomeController.dart';
import 'package:benyiino_shop/services/ShopService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String heroTag = '';
  final HomeController _homeController = Get.find();

  void _onAddToCart() {
    setState(() {
      heroTag = '_details';
    });
    _homeController.addToCart(widget.product);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Get.isDarkMode ? Colors.white : Colors.black),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Hero(
                  tag: 'list_${widget.product.id}$heroTag',
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.product.weight,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      '\$${widget.product.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Acercas de este producto',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.product.description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            children: [
              Obx(
                () => IconButton(
                  onPressed: () {
                    if (_homeController.getWishlistProduct(widget.product) != null) {
                      _homeController.removeFromWishlist(widget.product);
                    } else {
                      _homeController.addToWishlist(widget.product);
                    }
                  },
                  icon: Icon(
                    _homeController.getWishlistProduct(widget.product) != null
                        ? Icons.bookmark_remove
                        : Icons.bookmark_add_outlined,
                    size: 32,
                    color: _homeController.getWishlistProduct(widget.product) != null
                        ? Theme.of(context).primaryColor
                        : null,
                  ),
                  padding: const EdgeInsets.only(left: 20, right: 30),
                ),
              ),
              Expanded(
                child: _homeController.getCartProduct(widget.product) != null
                    ? TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () {
                                _homeController.removeFromCart(widget.product);
                              },
                            ),
                            Obx(
                              () => Column(
                                children: [
                                  Text(
                                    _homeController.getCartProduct(widget.product)?.quantity.toString() ?? '0',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '\$${double.parse((_homeController.getCartProduct(widget.product)?.quantity ?? 0 * widget.product.price).toStringAsFixed(2))}',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () {
                                _homeController.addToCart(widget.product);
                              },
                            ),
                          ],
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _onAddToCart,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(vertical: 20),
                          ),
                        ),
                        child: const Text('Add to cart'),
                      ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
