import 'package:first_flutter_app/switch_and_checkbox.dart';
import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: DefaultTextStyle(
        style: TextStyle(color: Colors.green, fontSize: 20),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "This is new route",
                textAlign: TextAlign.center,
                style: TextStyle(
                  inherit: false,
                  fontSize: 30,
                  color: Colors.red,
                  fontFamily: 'Courier',
                  background: Paint()..color = Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.green,
                  decorationStyle: TextDecorationStyle.dashed,
                  decorationThickness: 2,
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                  text: "GitHub: ",
                ),
                TextSpan(
                  text: "https://github.com",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
//                    recognizer:
                )
              ])),
              FlatButton(
                colorBrightness: Brightness.dark,
                child: Text("Submit"),
                color: Colors.blue,
                splashColor: Colors.grey,
                highlightColor: Colors.blue[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {},
              ),
              Image.network(
                "https://pcdn.flutterchina.club/imgs/book.png",
                height: 200,
                color: Colors.red,
                colorBlendMode: BlendMode.difference,
              ),
              Text(
                "\uE914 \uE000 \uE90D",
                style: TextStyle(
                  fontFamily: "MaterialIcons",
                  fontSize: 40.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.accessible, color: Colors.green),
                  Icon(Icons.error, color: Colors.green),
                  Icon(Icons.fingerprint, color: Colors.green)
                ],
              ),
              SwitchAndCheckBoxTestRoute(),
              SizedBox(
                height: 10,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey[200],
                    semanticsLabel: "Indicator",
                    strokeWidth: 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}