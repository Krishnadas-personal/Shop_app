import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../provider/Order_Provider.dart';
import '../widgets/orderitem.dart' as orderitem;

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  const OrderScreen({Key key}) : super(key: key);


  // void initState() {
  //   Future.delayed(Duration.zero).then((value) async {
  //     await Provider.of<Orders>(context, listen: false).fetchProductsOrders();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final order = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders'),
        ),
        drawer: DrawerBar(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchProductsOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.error != null) {
              return Center(
                child: Text("An error occured"),
              );
            } else {
              return Consumer<Orders>(builder: (context, orders, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return orderitem.OrderItem(
                      order: orders.item[index],
                    );
                  },
                  itemCount: orders.item.length,
                );
              });
            }
          },
        ));
  }
}
