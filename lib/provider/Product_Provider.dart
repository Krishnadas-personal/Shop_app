import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.imageUrl,
      this.isFavorite = false,
      this.description,
      this.price});

  void _favOldStatus(oldStatus) {
    isFavorite = oldStatus;

    notifyListeners();
  }

  Future<void> toogleFavoriteChanger() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    final url =
        'https://shop-server-777cf-default-rtdb.firebaseio.com/addProducts/$id.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            "isFavorite": isFavorite,
          }));
      notifyListeners();
      if (response.statusCode >= 400) {
        _favOldStatus(oldStatus);
      }
    } catch (err) {
      _favOldStatus(oldStatus);
    }
  }
}
