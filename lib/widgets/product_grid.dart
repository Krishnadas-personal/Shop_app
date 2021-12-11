import 'package:flutter/material.dart';

import '../provider/Products_Provider.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
class ProductGrid extends StatelessWidget {
  final bool fav;
  const ProductGrid({ Key key, this.fav }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // ignore: non_constant_identifier_names
   final ProductsData= Provider.of<ProductProvider>(context);
   final products =(fav)? ProductsData.favouritesItem : ProductsData.items;
 
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / 2,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
          // create:(ctx)=> Product(),
            // ignore: deprecated_member_use
            value:  products[index],
            child: ProductItem(
                // imageUrl: products[index].imageUrl,
                // id: products[index].id,
                // title: products[index].title
                ),
          ),
       
        itemCount: products.length,
        
      );
  }
}