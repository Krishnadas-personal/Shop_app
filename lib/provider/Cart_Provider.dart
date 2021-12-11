import 'package:flutter/material.dart';

class CartItems {
  String id;
  String title;
  String imageUrl;
  double price;
  int quantity;
  CartItems({
    @required this.id,
    @required this.price,
    @required this.imageUrl,
    @required this.title,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  int get count {
    print("Total Cart");
    print(_items.length.toString());
    return _items.length == null ? 0 : _items.length;
  }

  void addItems(String productid, String title, double price, String imageUrl) {
    if (_items.containsKey(productid)) {
      _items.update(
          productid,
          (existingProductItems) => CartItems(
              id: existingProductItems.id,
              price: existingProductItems.price,
              title: existingProductItems.title,
              quantity: existingProductItems.quantity + 1,
              imageUrl: existingProductItems.imageUrl));
      print(_items);
    } else {
      _items.putIfAbsent(
          productid,
          () => CartItems(
              id: DateTime.now().toString(),
              price: price,
              title: title,
              quantity: 1,
              imageUrl: imageUrl));
      notifyListeners();
    }
  }

  void qtyAdjustment(String id, IconData icon) {
    _items.forEach((prod, value) {
      if (value.id == id && icon == Icons.add)
        value.quantity = value.quantity + 1;
      if (value.id == id &&
          icon == Icons.minimize_rounded &&
          value.quantity > 0) value.quantity = value.quantity - 1;
    });
    notifyListeners();
  }

  double get totalamount {
    double amount = 0.0;

    _items.forEach((prod, value) {
      amount += value.price * value.quantity;
    });
    return amount;
  }

  void removeItem(productid) {
    _items.remove(productid);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeFromCart(String productid) {
    if (!_items.containsKey(productid)) {
      return;
    }
    if (_items[productid].quantity > 1) {
      _items.update(
          productid,
          (existingvalues) => CartItems(
              id: existingvalues.id,
              price: existingvalues.price,
              imageUrl: existingvalues.imageUrl,
              title: existingvalues.title,
              quantity: existingvalues.quantity - 1));
    } else {
      _items.remove(productid);
    }

    notifyListeners();
  }
}
