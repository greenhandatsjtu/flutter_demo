import 'package:flutter/material.dart';

class TipRoute extends StatelessWidget {
  TipRoute({Key key, @required this.text}) : super(key: key);
  final String text;
  final controller = TextEditingController(text: "I'm return value");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToolTip'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(controller: controller, autofocus: true),
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.of(context).pop(controller.text),
                child: Text('return'),
              )
            ],
          ),
        ),
      ),
    );
  }
}