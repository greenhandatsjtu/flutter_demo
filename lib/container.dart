import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ContainerPage extends StatelessWidget {
  final Widget redBox = DecoratedBox(
    decoration: BoxDecoration(color: Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RaisedButton.icon(
                      colorBrightness: Brightness.dark,
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ContainerRoute();
                        }));
                      },
                      icon: Icon(Icons.open_in_new),
                      label: Text("Container part")),
                  RaisedButton.icon(
                      colorBrightness: Brightness.dark,
                      color: Colors.green,
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ClipTestRoute();
                        }));
                      },
                      icon: Icon(Icons.open_in_new),
                      label: Text("Clip part")),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Hello world!"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("I'm Jack"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                    child: Text("your friend."),
                  )
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 50.0,
              ),
              child: Container(
                height: 5.0,
                child: redBox,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 80.0,
              height: 80.0,
              child: redBox,
            ),
            SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Colors.red, Colors.orange[700]]),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                    )
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 18.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 50),
            Container(
              color: Colors.cyan,
              child: new Transform(
                alignment: Alignment.topRight, //相对于坐标系原点的对齐方式
                transform: new Matrix4.skewY(0.3), //沿Y轴倾斜0.3弧度
                child: new Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.deepOrange,
                  child: const Text('Apartment for rent!'),
                ),
              ),
            ),
            SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Transform.translate(
                offset: Offset(20.0, -5.0),
                child: Text("Hello world!"),
              ),
            ),
            SizedBox(height: 30),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Transform.rotate(
                //旋转90度
                angle: math.pi / 2,
                child: Text("Hello world"),
              ),
            ),
            SizedBox(height: 30),
            DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Transform.scale(
                    scale: 1.5, //放大到1.5倍
                    child: Text("Hello world"))),
            SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              //将Transform.rotate换成RotatedBox
              child: RotatedBox(
                quarterTurns: 1, //旋转90度(1/4圈)
                child: Text("Hello world"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Container part"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50.0, left: 120.0),
            //容器外填充
            constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0),
            //卡片大小
            decoration: BoxDecoration(
              //背景装饰
                gradient: RadialGradient(
                  //背景径向渐变
                    colors: [Colors.red, Colors.orange],
                    center: Alignment.topLeft,
                    radius: 0.98),
                boxShadow: [
                  //卡片阴影
                  BoxShadow(
                      color: Colors.black54,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 10.0)
                ]),
            transform: Matrix4.rotationZ(.2),
            //卡片倾斜变换
            alignment: Alignment.center,
            //卡片内文字居中
            child: Text(
              //卡片文字
              "5.20", style: TextStyle(color: Colors.white, fontSize: 40.0),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            color: Colors.orange,
            child: Text("Hello world!"),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.orange,
            child: Text("Hello world!"),
          )
        ],
      ),
    );
  }
}

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 头像
    Widget avatar = Image.network(
      "https://pcdn.flutterchina.club/imgs/book.png",
      width: 90,
    );
    return Scaffold(
      appBar: AppBar(title: Text("Clip Route")),
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          children: <Widget>[
            avatar, //不剪裁
            ClipOval(child: avatar), //剪裁为圆形
            ClipRRect(
              //剪裁为圆角矩形
              borderRadius: BorderRadius.circular(20.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),
                Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  //将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5, //宽度设为原来宽度一半
                    child: avatar,
                  ),
                ),
                Text("你好世界", style: TextStyle(color: Colors.green))
              ],
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: ClipRect(
                clipper: MyClipper(),
                child: avatar,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 70.0, 90.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
