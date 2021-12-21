import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/Product_Provider.dart';
import 'package:shop_app/provider/Products_Provider.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/editproductitems.dart';
import 'package:shop_app/widgets/showDilaog.dart';

class AddProducts extends StatefulWidget {
  static const routeName = '/addProdcuts';
  const AddProducts({Key key}) : super(key: key);

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final _pricefocusNode = FocusNode();
  final _descriptionfocusNode = FocusNode();
  final _imageUrlfocusnode = FocusNode();
  final _imagecontroller = TextEditingController();
  bool Init = true;
  bool _loading = false;
  final formKey = GlobalKey<FormState>();

  var editProducts =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var initialValues = {
    'id': '',
    'title': '',
    'description': '',
    'price': '',
  };

  @override
  void initState() {
    _imageUrlfocusnode.addListener(_updateimageurl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (Init == true) {
      final product_id = ModalRoute.of(context).settings.arguments as String;
      if (product_id != null) {
        editProducts =
            Provider.of<ProductProvider>(context).findEachProduct(product_id);
        print("editProducts");
        print(editProducts.id);
        initialValues = {
          'id': editProducts.id,
          'title': editProducts.title,
          'description': editProducts.description,
          'price': editProducts.price.toString(),
        };
        _imagecontroller.text = editProducts.imageUrl;
      }
    }
    super.didChangeDependencies();
    Init = false;
  }

  @override
  void dispose() {
    _imageUrlfocusnode.removeListener(_updateimageurl);
    _pricefocusNode.dispose();
    _descriptionfocusNode.dispose();
    _imageUrlfocusnode.dispose();
    _imagecontroller.dispose();
    super.dispose();
  }

  void _updateimageurl() {
    if (!_imageUrlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _submit() async {
    final isValid = formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState.save();
    setState(() {
      _loading = true;
    });
    if (editProducts.id != null) {
      print("I am Updating");
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .updateProduct(editProducts.id, editProducts);
      } catch (err) {
          print("Error Update");
        print(err.toString());
        await showDialogBox(context, err);
      }
    } else {
    
      print(editProducts.id);
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .addproducts(editProducts);
      } catch (err) {
        await showDialogBox(context, err);
      }
      // finally {
      //   setState(() {
      //     _loading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _loading = false;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Products"),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _submit)],
      ),
      body: (_loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: initialValues['title'],
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_pricefocusNode);
                      },
                      onSaved: (value) {
                        editProducts = Product(
                          id: editProducts.id,
                          isFavorite: editProducts.isFavorite,
                          title: value,
                          description: editProducts.description,
                          imageUrl: editProducts.description,
                          price: editProducts.price,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Enter a product name';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: initialValues['price'],
                      decoration: InputDecoration(
                        labelText: "Price",
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _pricefocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionfocusNode);
                      },
                      onSaved: (value) {
                        editProducts = Product(
                          id: editProducts.id,
                          isFavorite: editProducts.isFavorite,
                          title: editProducts.title,
                          description: editProducts.description,
                          imageUrl: editProducts.description,
                          price: double.parse(value),
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) return 'Enter the price ';
                        if (double.parse(value) <= 0)
                          return 'Price should be greater than 0 ';
                        // if (double.tryParse(value) <= 0) return 'Enter the price ';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: initialValues['description'],
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionfocusNode,
                      onSaved: (value) {
                        editProducts = Product(
                          id: editProducts.id,
                          isFavorite: editProducts.isFavorite,
                          title: editProducts.title,
                          description: value,
                          imageUrl: editProducts.description,
                          price: editProducts.price,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Enter the Description for the product ';
                        if (value.length < 10)
                          return 'Description should be greater than ten character ';
                        // if (double.tryParse(value) <= 0) return 'Enter the price ';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          // margin: EdgeInsets.only(
                          //   right: 10,
                          //   top: 8
                          // ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imagecontroller.text.isEmpty
                              ? Center(child: Text("Image\nPreview"))
                              : FittedBox(
                                  child: Image.network(_imagecontroller.text),
                                  fit: BoxFit.fill,
                                ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Image Url",
                                border: OutlineInputBorder(),
                              ),
                              controller: _imagecontroller,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.url,
                              focusNode: _imageUrlfocusnode,
                              onFieldSubmitted: (_) => _submit(),
                              onSaved: (value) {
                                editProducts = Product(
                                  id: editProducts.id,
                                  isFavorite: editProducts.isFavorite,
                                  title: editProducts.title,
                                  description: editProducts.description,
                                  imageUrl: value,
                                  price: editProducts.price,
                                );
                              },
                              validator: (value) {
                                if (value.isEmpty) return 'Enter the Image URL';
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https'))
                                  return 'Enter a valid Image URL';
                                // if (double.tryParse(value) <= 0) return 'Enter the price ';
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
