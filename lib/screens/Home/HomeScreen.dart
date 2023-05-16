import 'dart:io';

import 'package:benyiino_shop/controllers/HomeController.dart';
import 'package:benyiino_shop/screens/Home/ShopList.dart';
import 'package:benyiino_shop/screens/Home/StoreCart.dart';
import 'package:benyiino_shop/widgets/AppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const cartBarHeight = 80.0;
const _pannelTransition = Duration(milliseconds: 700);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());

  void _onVerticalGesture(DragUpdateDetails details) {
    double primaryDelta = details.primaryDelta!;
    if (primaryDelta < -7) {
      _homeController.state = GroceryState.cart;
    } else if (primaryDelta > 12) {
      _homeController.state = GroceryState.normal;
    }
  }

  double _getTopForWhitePanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      return -cartBarHeight;
    } else if (state == GroceryState.cart) {
      return -(size.height - kToolbarHeight - cartBarHeight / 2);
    }

    return 0.0;
  }

  double _getTopForBlackPanel(GroceryState state, Size size) {
    if (state == GroceryState.normal) {
      double sizeTop = size.height - kToolbarHeight - cartBarHeight;

      try {
        sizeTop -= (Platform.isAndroid ? kBottomNavigationBarHeight * 0.5 : 0);
      } catch (_) {}

      return sizeTop;
    } else if (state == GroceryState.cart) {
      return cartBarHeight / 2;
    }

    return -kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(toolbarHeight: 0),
      body: AnimatedBuilder(
        animation: _homeController,
        builder: (context, _) {
          return Column(
            children: [
              const AppBarWidget(),
              Expanded(
                child: Stack(
                  children: [
                    Obx(
                      () => AnimatedPositioned(
                        duration: _pannelTransition,
                        curve: Curves.decelerate,
                        left: 0,
                        right: 0,
                        top: _getTopForWhitePanel(_homeController.state, size),
                        height: size.height - kToolbarHeight,
                        child: GestureDetector(
                          onTap: () {
                            if (_homeController.state == GroceryState.cart) {
                              _homeController.state = GroceryState.normal;
                            }
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: ShopList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        duration: _pannelTransition,
                        curve: Curves.decelerate,
                        left: 0,
                        right: 0,
                        top: _getTopForBlackPanel(_homeController.state, size),
                        height: size.height - cartBarHeight,
                        child: GestureDetector(
                          // Si es móvil, se usa el onVerticalDragUpdate
                          onVerticalDragUpdate: _onVerticalGesture,
                          // Si es web o escritorio, se usa onTap
                          onTap: () {
                            if (_homeController.state == GroceryState.normal) {
                              _homeController.state = GroceryState.cart;
                            }
                          },
                          child: Container(
                            color: Theme.of(context).cardColor.withOpacity(0.4),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      width: 40,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  flex: _homeController.state == GroceryState.normal ? 0 : 1,
                                  child: AnimatedSwitcher(
                                    duration: _pannelTransition,
                                    child: _homeController.state == GroceryState.normal
                                        ? Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Carrito',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: Row(
                                                      children: List.generate(
                                                        _homeController.cart.length,
                                                        (index) {
                                                          final cartProduct = _homeController.cart[index];

                                                          return Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 7),
                                                            child: Stack(
                                                              children: [
                                                                Hero(
                                                                  tag: 'list_${cartProduct.product.id}_details',
                                                                  child: CircleAvatar(
                                                                    backgroundColor: Colors.white,
                                                                    backgroundImage:
                                                                        AssetImage(cartProduct.product.image),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  right: 0,
                                                                  child: CircleAvatar(
                                                                    radius: 10,
                                                                    backgroundColor: Theme.of(context).primaryColor,
                                                                    child: Text(
                                                                      cartProduct.quantity.toString(),
                                                                      style: const TextStyle(
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  backgroundColor: Theme.of(context).primaryColor,
                                                  radius: 15,
                                                  child: Text(
                                                    _homeController.cart
                                                        .fold(
                                                            0,
                                                            (previousValue, element) =>
                                                                previousValue + element.quantity)
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : StoreCart(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
