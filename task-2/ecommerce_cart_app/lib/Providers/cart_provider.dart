import 'package:ecommerce_cart_app/Models/product_data.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<ProductModel> items = [];
  String? _discount;
  // add cart items
  void addToCart(ProductModel item) {
    final itemIndex = items.indexWhere((element) => element.id == item.id);

    if (itemIndex >= 0) {
      items[itemIndex].quantity++;
    } else {
      items.add(item);
    }

    notifyListeners();
  }

  // increment item quantity
  void incrementQuantity(int itemId) {
    final item = items.firstWhere((element) => element.id == itemId);
    item.quantity++;
    notifyListeners();
  }

  // decrement item quantity
  void decrementQuantity(int itemId) {
    final item = items.firstWhere((element) => element.id == itemId);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      items.remove(item);
    }
    notifyListeners();
  }

  // subtotal
  double get subTotal {
    return items.fold(
      0,
      (sum, element) => sum + element.price * element.quantity,
    );
  }

  // add tax in item
  double get tax => subTotal * 0.10;
  // get discount
  double get discount {
    if (_discount == 'SAVE20') {
      return subTotal * 0.10;
    } else {
      return 0;
    }
  }

  // apply discount
  void applyDiscount(String code) {
    if (code == _discount) {
      _discount = code;
    } else {
      _discount = '';
    }
    notifyListeners();
  }

  // shipping fee
  double get shippingFee {
 return subTotal == 0 ? 0 : 10;

  }

  // total
  double get total => subTotal + shippingFee + tax - discount;

  void clearCart() {
    items.clear();
    _discount = null;
    notifyListeners();
  }
}
