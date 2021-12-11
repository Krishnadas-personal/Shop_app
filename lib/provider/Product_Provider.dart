import 'package:flutter/cupertino.dart';

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

  void toogleFavoriteChanger() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
