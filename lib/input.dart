import 'package:flutter/material.dart';

class InputRoute extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = "Hello world";
    controller.selection = TextSelection(
      baseOffset: 2,
      extentOffset: controller.text.length,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  )),
            ),
            TextField(
              onChanged: (v) {
                print("On changed: $v");
              },
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock),
                  hintStyle: TextStyle(color: Colors.green, fontSize: 20)),
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
