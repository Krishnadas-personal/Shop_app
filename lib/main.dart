import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/EditProductScreen.dart';

import './provider/Order_Provider.dart';
import './screens/CartScreen.dart';
import './screens/OrderScreen.dart';

import './provider/Products_Provider.dart';
import './provider/Cart_Provider.dart';
import './screens/ProductDetails.dart';
import './screens/ProductOverview.dart';
import './screens/AddProducts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orange,
            errorColor: Colors.red,
            fontFamily: 'Lato '),
        home: MyProductOverview(),
      
        routes: {
          ProductDetial.routeName: (cxt) => ProductDetial(),
          CartScreen.routeName: (cxt) => CartScreen(),
          OrderScreen.routeName: (cxt) => OrderScreen(),
          EditProductScreen.routeName: (cxt) => EditProductScreen(),
          AddProducts.routeName: (cxt) => AddProducts(),
        },
      ),
    );
  }
}
