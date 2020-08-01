import 'package:flutter/material.dart';

class FunctionalPage extends StatefulWidget {
  @override
  _FunctionalPageState createState() => _FunctionalPageState();
}

class _FunctionalPageState extends State<FunctionalPage> {
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Functional Widgets")),
      body: new WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: 1)) {
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Container(
          alignment: Alignment.center,
          child: Text('1秒内连续按两次返回键退出'),
        ),
      ),
    );
  }
}
