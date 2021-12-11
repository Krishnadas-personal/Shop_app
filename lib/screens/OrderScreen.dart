import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../provider/Order_Provider.dart';
import '../widgets/orderitem.dart' as orderitem;

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: DrawerBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return orderitem.OrderItem(
            order: order.item[index],
          );
        },
        itemCount: order.item.length,
      ),
    );
  }
}
