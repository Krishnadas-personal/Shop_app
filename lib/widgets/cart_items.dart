import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Cart_Provider.dart';

class CartItems extends StatefulWidget {
  final String title;
  final String id;
  final String productid;
  final String imageurl;
  final double price;
  final int qty;

  const CartItems(
      {Key key,
      this.title,
      this.id,
      this.price,
      this.qty,
      this.imageurl,
      this.productid})
      : super(key: key);

  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    final cartitem = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(widget.id),
      onDismissed: (direction) {
        cartitem.removeItem(widget.productid);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        padding: EdgeInsets.only(right: 30),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: Text(
                    "Do you want to delete ${widget.title} from cart"),
                title: Text("Are you sure ?"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('Cancel')),
                  FlatButton(onPressed: () {
                    Navigator.of(context).pop(true);
                  }, child: Text('Delete'))
                ],
              );
            });
      },
      child: Card(
        margin: EdgeInsets.all(6.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(widget.imageurl),
                radius: 30,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Image.network(widget.imageurl),
                            title: Text(widget.title + ': ${widget.price}'),
                            actions: [],
                          );
                        });
                  },
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.title}",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  Text(
                    '\$${(widget.price * widget.qty).toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        cartitem.qtyAdjustment(widget.id, Icons.add);
                      }),
                  // FlatButton(onPressed: () {}, child: Icon(Icons.add)),
                  Text(
                    '${widget.qty} x',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  // FlatButton(
                  //   onPressed: () {},
                  //   child: Icon(Icons.minimize_rounded),
                  // )
                  IconButton(
                      icon: Icon(Icons.minimize_rounded),
                      onPressed: () {
                        cartitem.qtyAdjustment(
                            widget.id, Icons.minimize_rounded);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
