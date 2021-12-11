import 'package:flutter/material.dart';

import 'Cart_Provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime date;

  OrderItem({this.id, this.amount, this.products, this.date});
}

class Orders with ChangeNotifier {
  List<OrderItem> _item = [];

  List<OrderItem> get item {
    return [..._item];
  }

  void addOrder(List<CartItems> cartproducts, double total) {
    _item.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cartproducts,
          date: DateTime.now()),
    );
    notifyListeners();
  }
}
