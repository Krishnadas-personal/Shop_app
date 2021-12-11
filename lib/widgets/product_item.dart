import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Product_Provider.dart';
import '../provider/Cart_Provider.dart';
import '../screens/ProductDetails.dart';

class ProductItem extends StatelessWidget {
  // final String imageUrl;
  // final String title;
  // final String id;
  // const ProductItem({Key key, this.imageUrl, this.title, this.id})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prod = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    print("Product rebuilds");
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetial.routeName,
            arguments: prod.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          footer: GridTileBar(
            title: Text(
              prod.title,
              textAlign: TextAlign.center,
              // style: TextStyle(fontSize: 8),
            ),
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                icon: (product.isFavorite)
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product.toogleFavoriteChanger();
                },
              ),
            ),
            trailing: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItems(prod.id, prod.title, prod.price, prod.imageUrl);
                // Navigator.of(context).pushNamed(CartScreen.routeName);
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Added to Cart"),
                    duration: Duration(seconds: 3),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeFromCart(prod.id);
                        }),
                  ),
                );
              },
            ),
          ),
          child: Image.network(
            prod.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
