import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Order_Provider.dart';
import '../provider/Cart_Provider.dart' show Cart;
import '../widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL : ",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  Chip(
                    label: Text(
                      "\$${cart.totalamount.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () {
                      order.addOrder(
                          cart.items.values.toList(), cart.totalamount);
                          cart.clearCart();
                    },
                    child: Text(
                      "ORDER\n  NOW",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CartItems(
                  title: cart.items.values.toList()[index].title,
                  id: cart.items.values.toList()[index].id,
                  imageurl: cart.items.values.toList()[index].imageUrl,
                  price: cart.items.values.toList()[index].price,
                  qty: cart.items.values.toList()[index].quantity,
                  productid: cart.items.keys.toList()[index],
                );
              },
              itemCount: cart.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
