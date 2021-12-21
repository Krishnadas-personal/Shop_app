import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../provider/Order_Provider.dart' as orders;

class OrderItem extends StatefulWidget {
  final orders.OrderItem order;
  const OrderItem({Key key, this.order}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
    var _expanded = false;
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat('dd-MMM-yyy').format(widget.order.date)),
            trailing: IconButton(
              icon:
                  Icon( _expanded?Icons.expand_less:Icons.expand_more),
                  
              onPressed: () {
                setState(() {
                  
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
                height: 100,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(widget.order.products[index].title),
                          subtitle: Text('\$${widget.order.amount}'),
                          trailing: Text(
                              '${widget.order.products[index].quantity}x ${widget.order.products[index].price}'),
                        ),
                        Divider(),
                      ],
                    );
                  },
                  itemCount: widget.order.products.length,
                )),
        ],
      ),
    );
  }
}
