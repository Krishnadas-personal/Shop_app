import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'Product_Provider.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  List<Product> _item = [];

  List<Product> get items {
    return [..._item];
  }

  List<Product> get favouritesItem {
    return _item.where((proditem) => proditem.isFavorite).toList();
  }

  Product findEachProduct(String id) {
    return _item.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchTheProducts() async {
    const url =
        'https://shop-server-777cf-default-rtdb.firebaseio.com/addProducts.json';
    try {
      final response = await http.get(Uri.parse(url));

      print("Data to fetch");

      final addProducts = json.decode(response.body) as Map<String, dynamic>;

//  print(addProducts);
      List<Product> loadedItems = [];
      addProducts.forEach((productId, products) {
        loadedItems.add(Product(
            id: productId,
            description: products['description'],
            imageUrl: products['imageUrl'],
            isFavorite: products['isFavorite'],
            price: products['price'],
            title: products['title']));
      });
      _item = loadedItems;
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> addproducts(Product product) async {
    const url =
        'https://shop-server-777cf-default-rtdb.firebaseio.com/addProducts.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      // print(json.decode(response.body));
      print("response");
      final products = Product(
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
          id: json.decode(response.body)['name']);

      _item.insert(0, products);
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final url =
        'https://shop-server-777cf-default-rtdb.firebaseio.com/addProducts/$id.json';

    final updateIndex = _item.indexWhere((prod) => prod.id == id);

    try {
      if (updateIndex >= 0) {
        final response = await http.patch(Uri.parse(url),
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'price': newProduct.price,
              'imageUrl': newProduct.imageUrl,
            }));
        _item[updateIndex] = newProduct;
        print(response.statusCode.toString());
        notifyListeners();
      }
    } catch (err) {
      print("Error Update");
      print(err.toString());
      throw err;
    }
  }

  Future<void> remove_product(String productid) async {
    final url =
        'https://shop-server-777cf-default-rtdb.firebaseio.com/addProducts/$productid.json';
    final productIndex = _item.indexWhere((prod) => prod.id == productid);
    var existingProducts = _item[productIndex];

    _item.removeWhere((prod) => prod.id == productid);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _item.insert(productIndex, existingProducts);
      notifyListeners();
      throw HttpException(response.body);
    }
    existingProducts=null;
  }
}
