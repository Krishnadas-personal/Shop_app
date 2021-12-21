import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';
import '../widgets/editproductitems.dart';
import '../provider/Products_Provider.dart';
import 'AddProducts.dart';

class EditProductScreen extends StatelessWidget {
  static const routeName = '/manageOrders';
  const EditProductScreen({Key key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchTheProducts();
  }

  @override
  Widget build(BuildContext context) {
    final editproducts = Provider.of<ProductProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddProducts.routeName);
              })
        ],
      ),
      drawer: DrawerBar(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
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
      ),
    );
  }
}
