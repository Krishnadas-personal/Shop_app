import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/CardDetail.dart';
// import '../provider/products.dart';
import '../provider/Products_Provider.dart';

class ProductDetial extends StatelessWidget {
  static const routeName = '/ProductDetails';
  final String title;
  const ProductDetial({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prodId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).findEachProduct(prodId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: CardDetail(
        title: loadedProduct.title,
        price: loadedProduct.price,
        imageurl: loadedProduct.imageUrl,
      ),
    );
  }
}
