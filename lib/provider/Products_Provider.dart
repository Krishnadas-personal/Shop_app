import 'package:flutter/material.dart';
import 'Product_Provider.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _item = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._item];
  }

  List<Product> get favouritesItem {
    return _item.where((proditem) => proditem.isFavorite).toList();
  }

  Product findEachProduct(String id) {
    return _item.firstWhere((prod) => prod.id == id);
  }

  void addproducts(Product product) {
    final products = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: DateTime.now().toString());

    _item.insert(0, products);
    notifyListeners();
  }

  void updateProduct(String id,Product newProduct) {
    // print(id);
    // print('In UPDATE PROD');
   
    final updateIndex = _item.indexWhere((prod) => prod.id == id);
    print(updateIndex);
    print('updateIndex');
    if (updateIndex >= 0) _item[updateIndex] = newProduct;
    print(_item[updateIndex].id);
    print(_item[updateIndex].title);

    notifyListeners();
  }
  void remove_product(String productid) {
    _item.removeWhere((prod) => prod.id==productid);

  

    notifyListeners();
  }
}