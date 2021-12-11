import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CardDetail extends StatelessWidget {
  final String title;
  final double price;
  final String imageurl;
  const CardDetail({Key key, this.title, this.price, this.imageurl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: Image.network(
            imageurl,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "$title : \$$price ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
