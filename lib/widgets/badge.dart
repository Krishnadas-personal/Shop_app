import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final int count;
  final Widget child;
  final Colors color;

  const Badge({Key key, this.count, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: color == null ? Theme.of(context).accentColor : color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              count.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            constraints: BoxConstraints(
            minHeight: 16,
            minWidth: 16

            ),
          ),
          
         right: 6,
        top: 4,
        ),
      ],
    );
  }
}
