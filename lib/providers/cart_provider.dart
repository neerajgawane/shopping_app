import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _cart = [];

  List<Map<String, dynamic>> get cart => _cart;

  void addProduct(Map<String, dynamic> product) {
    final existingProduct = _cart.firstWhere(
      (item) => item['id'] == product['id'] && item['size'] == product['size'],
      orElse: () => {},
    );

    if (existingProduct.isNotEmpty) {
      existingProduct['quantity'] += 1;
    } else {
      product['quantity'] = 1;
      _cart.add(product);
    }
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    _cart.remove(product);
    notifyListeners();
  }

  void updateQuantity(Map<String, dynamic> product, int newQuantity) {
    final existingProduct = _cart.firstWhere(
      (item) => item['id'] == product['id'] && item['size'] == product['size'],
      orElse: () => {},
    );

    if (existingProduct.isNotEmpty) {
      if (newQuantity > 0) {
        existingProduct['quantity'] = newQuantity;
      } else {
        _cart.remove(existingProduct);
      }
      notifyListeners();
    }
  }

  int get totalItems {
    return _cart.fold(0, (sum, item) => sum + (item['quantity'] as int));
  }

  double get totalPrice {
    return _cart.fold(
        0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }
}
