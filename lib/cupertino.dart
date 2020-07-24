import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text("Press"),
            onPressed: () {}),
      ),
    );
  }
}

class SnackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.message),
      onPressed: () => {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: new Text('Hello!'),
          action: new SnackBarAction(label: '撤消', onPressed: () {}),
          duration: Duration(seconds: 1),
        ))
      },
    );
  }
}

Future getHitokoto() async {
  try {
    final response = await Dio().get("https://v1.hitokoto.cn/",
        queryParameters: {'c': 'a', 'encode': 'json'});
    String hitokoto = jsonDecode(response.toString())['hitokoto'];
    print(hitokoto);
    return hitokoto;
  } catch (e) {
    print(e);
  }
}
