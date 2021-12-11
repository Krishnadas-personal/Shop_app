import 'package:flutter/material.dart';
import '../screens/EditProductScreen.dart';

import '../screens/OrderScreen.dart';


class DrawerBar extends StatelessWidget {
  const DrawerBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello There!!'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              size: 24,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            title: Text("Shop"),
          ),
          ListTile(
            leading: Icon(
              Icons.payment,
              size: 24,
            ),
            onTap: () {
              Navigator.pushNamed(context, OrderScreen.routeName);
            },
            title: Text("Your Orders"),
          ),
          ListTile(
            leading: Icon(
              Icons.edit,
              size: 24,
            ),
            onTap: () {
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
            title: Text("Manage Products"),
          )
        ],
      ),
    );
  }
}
