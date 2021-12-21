import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Products_Provider.dart';
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
  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    if (_init) {
      Provider.of<ProductProvider>(context).fetchTheProducts().then((_) {
        setState(() {
                  
      _isLoading = false;
                });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

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
            body: (_isLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ProductGrid(fav: favouritesOnly),
          );
  }
}
