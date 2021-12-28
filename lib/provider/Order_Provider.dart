import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future<void> fetchProductsOrders() async {
    const url =
        'https://shop-server-777cf-default-rtdb.firebaseio.com/orderProducts.json';
   
      final response = await http.get(Uri.parse(url));
      final encodedData = json.decode(response.body) as Map<String, dynamic>;
      if (encodedData == null) {
        return;
      }
      List<OrderItem> loadedOrdered = [];
      encodedData.forEach((orderId, orderData) {
        loadedOrdered.add(OrderItem(
          amount: orderData['amount'],
          date: DateTime.parse(orderData['date']),
          products: (orderData['product'] as List<dynamic>).map(
            (prod) =>
              CartItems(

                  id: prod['id'],
                  price: prod['price'],
                  title: prod['title'],
                  quantity: prod['quantity'],
                  imageUrl: prod['imageUrl']),
            
          ).toList(),
        ));
      });
      _item = loadedOrdered;
      notifyListeners();
    
  }

  Future<void> addOrder(List<CartItems> cartproducts, double total) async {
    final timestamp = DateTime.now();
    List<CartItems> products = [];
    const url =
        'https://shop-server-777cf-default-rtdb.firebaseio.com/orderProducts.json';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'amount': total,
            'date': timestamp.toIso8601String(),
            'product': cartproducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                      'imageUrl': cp.imageUrl,
                    })
                .toList()
          }));
      _item.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartproducts,
          date: timestamp,
        ),
      );
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
