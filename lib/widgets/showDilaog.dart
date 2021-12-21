import 'package:flutter/material.dart';

showDialogBox(context, err){
  return  showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("An Error Occured"),
            content: Text(err.toString()),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Okay")),
            ],
          ),
        );
}