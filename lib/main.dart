import 'package:first_flutter_app/container.dart';
import 'package:first_flutter_app/layout.dart';
import 'package:first_flutter_app/random_words.dart';
import 'package:first_flutter_app/scroll.dart';
import 'package:first_flutter_app/tooltip.dart';
import 'package:first_flutter_app/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cupertino.dart';
import 'form.dart';
import 'input.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.lime,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
//      initialRoute: "/",
      routes: {
//        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        "new_page": (context) => NewRoute(),
        "tooltip_page": (context) => TipRoute(
              text: ModalRoute.of(context).settings.arguments,
            ),
        "form_page": (context) => FormTestRoute(),
        "layout_page": (context) => LayoutRoute(),
        "container_page": (context) => ContainerPage(),
        "scroll_page": (context) => ScrollPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  String hitokoto = "";
  int _selectedIndex = 0;
  TabController _tabController;
  List tabs = ["Home", "Business", "School"];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
        brightness: Brightness.dark,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share, color: Colors.white), onPressed: () {})
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
      drawer: Drawer(
        child: Container(
            alignment: Alignment.center,
            child: ListView(
              children: <Widget>[
                FlutterLogo(
                  style: FlutterLogoStyle.horizontal,
                  size: 50,
                ),
                ListTile(
                  leading: Icon(Icons.widgets),
                  title: Text("基础Widget"),
                  subtitle: Text(
                      "text, button, icon, image, icon, switch, indicator"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return NewRoute();
                    }));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.view_module),
                  title: Text("布局类Widget"),
                  subtitle: Text("Row, Column, Flex, Wrap, Align"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("layout_page");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.tablet),
                  title: Text("容器类Widget"),
                  subtitle: Text(
                      "Padding, ConstrainedBox, DecorateBox, Container, Scaffold, Clip"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("container_page");
                  },
                ),
                ListTile(
                  leading: Icon(Icons.format_line_spacing),
                  title: Text("可滚动Widget"),
                  subtitle: Text(
                      "SingleChildScrollView, ListView, GridView, CustomScrollView, ScrollController"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("scroll_page");
                  },
                ),
              ],
            )),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<String>(
                  future: getHitokoto(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(snapshot.data,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                            color: Colors.indigo,
                          ));
                    } else {
                      return SizedBox(
                          height: 29,
                          width: 29,
                          child: CircularProgressIndicator());
                    }
                  },
                ),
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline4,
                ),
                IconButton(
                  icon: Icon(Icons.open_in_new),
                  tooltip: "Open new route",
                  color: Colors.blue,
                  iconSize: 40,
                  onPressed: () {
                    Navigator.of(context).pushNamed("new_page");
                  },
                ),
                RaisedButton.icon(
                  colorBrightness: Brightness.dark,
                  color: Colors.cyan,
                  icon: Icon(Icons.open_in_new),
                  label: Text('open tooltip page'),
                  onPressed: () async {
                    var result = await Navigator.of(context).pushNamed(
                        "tooltip_page",
                        arguments: "I'm tooltip, hello.");
                    print(result);
                  },
                ),
                FlatButton(
                  textColor: CupertinoColors.activeGreen,
                  child: Text('open Cupertino page'),
                  onPressed: () =>
                  {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return CupertinoTestRoute();
                    }))
                  },
                ),
                RandomWordsWidget(),
                SnackButton(),
                RaisedButton(
                  color: Colors.teal,
                  colorBrightness: Brightness.dark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text("input page"),
                  onPressed: () =>
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return InputRoute();
                      })),
                ),
                RaisedButton(
                  color: Colors.green[600],
                  textColor: Colors.grey[300],
                  child: Text("form page"),
                  onPressed: () => Navigator.of(context).pushNamed('form_page'),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(tabs[1], textScaleFactor: 5),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(tabs[2], textScaleFactor: 5),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), title: Text("Business")),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), title: Text("School")),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.cyan,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
