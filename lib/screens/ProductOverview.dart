import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Cart_Provider.dart';
import '../screens/CartScreen.dart';
import '../widgets/badge.dart';
import '../widgets/drawer.dart';
import '../widgets/product_grid.dart';

enum favouriteOptions {
  Favourites,
  All,
}

class MyProductOverview extends StatefulWidget {
 
  @override
  _MyProductOverviewState createState() => _MyProductOverviewState();
}

class _MyProductOverviewState extends State<MyProductOverview> {
  bool favouritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoping app"),
        actions: [
          PopupMenuButton(
              onSelected: (option) {
                setState(() {
                  if (option == favouriteOptions.Favourites) {
                    favouritesOnly = true;
                  } else {
                    favouritesOnly = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) {
                return [
                  PopupMenuItem(
                    child: Text("All"),
                    value: favouriteOptions.All,
                  ),
                  PopupMenuItem(
                    child: Text("Only Favourite"),
                    value: favouriteOptions.Favourites,
                  )
                ];
              }),
          Consumer<Cart>(
            builder: (cxt, cart, child) => Badge(
              color: null,
              child: child,
              count: cart.count,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: DrawerBar(),
      body: ProductGrid(fav: favouritesOnly),
    );
  }
}
