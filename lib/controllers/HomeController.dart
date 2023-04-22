import 'package:benyiino_shop/services/ShopService.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _state = GroceryState.normal.obs;
  List<Product> catalog = List.unmodifiable(products);
  RxList<CartProduct> cart = <CartProduct>[].obs;
  RxList<WislistProduct> wishlist = <WislistProduct>[].obs;

  GroceryState get state => _state.value;

  set state(GroceryState value) => _state.value = value;

  final _cartBarHeight = 100.0.obs;

  double get cartBarHeight => _cartBarHeight.value;

  set cartBarHeight(double value) => _cartBarHeight.value = value;

  double get totalPrice {
    return cart.fold<double>(
      0.0,
      (previousValue, element) =>
          previousValue +
          double.parse(
            (element.product.price * element.quantity).toStringAsFixed(2),
          ),
    );
  }

  void addToCart(Product product) {
    final cartProduct = getCartProduct(product);

    if (cartProduct != null) {
      cartProduct.quantity++;
    } else {
      cart.add(CartProduct(product: product));
    }

    cart.refresh();
  }

  void removeFromCart(Product product) {
    final cartProduct = getCartProduct(product);

    if (cartProduct != null && cartProduct.quantity > 1) {
      cartProduct.quantity--;
    } else {
      cart.remove(cartProduct);
    }

    cart.refresh();
  }

  void deleteFromCart(CartProduct cartProduct) {
    cart.remove(cartProduct);
    cart.refresh();
  }

  CartProduct? getCartProduct(Product product) {
    return cart.firstWhereOrNull((p) => p.product == product);
  }

  //? Wishlist

  void addToWishlist(Product product) {
    final wishlistProduct = getWishlistProduct(product);

    if (wishlistProduct == null) {
      wishlist.add(WislistProduct(product: product));
    }

    wishlist.refresh();
  }

  void removeFromWishlist(Product product) {
    final wishlistProduct = getWishlistProduct(product);

    if (wishlistProduct != null) {
      wishlist.remove(wishlistProduct);
    }

    wishlist.refresh();
  }

  WislistProduct? getWishlistProduct(Product product) {
    return wishlist.firstWhereOrNull((p) => p.product == product);
  }
}

enum GroceryState { normal, details, cart }

class CartProduct {
  CartProduct({required this.product, this.quantity = 1});

  final Product product;
  int quantity;
}

class WislistProduct {
  WislistProduct({required this.product});

  final Product product;
  final DateTime date = DateTime.now();
}
