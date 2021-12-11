import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/editproductitems.dart';
import '../provider/Products_Provider.dart';
import 'AddProducts.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/manageOrders';
  const EditProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editproducts = Provider.of<ProductProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddProducts.routeName);
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            print(editproducts[index].title);
            return EditProducts(
              title: editproducts[index].title,
              imageurl: editproducts[index].imageUrl,
              price: editproducts[index].price,
              id: editproducts[index].id,
            );
          },
          itemCount: editproducts.length,
        ),
      ),
    );
  }
}
