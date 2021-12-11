import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/Products_Provider.dart';
import 'package:shop_app/screens/AddProducts.dart';

class EditProducts extends StatelessWidget {
  final String title;
  final String imageurl;
  final double price;
  final String id;
  const EditProducts({Key key, this.title, this.imageurl, this.price, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
      ),
      title: Text(title),
      subtitle: Text('\$$price'),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddProducts.routeName, arguments: id);
                }),
            IconButton(icon: Icon(Icons.delete), onPressed: () {
              Provider.of<ProductProvider>(context,listen: false).remove_product(id);
            }),
          ],
        ),
      ),
    );
  }
}
