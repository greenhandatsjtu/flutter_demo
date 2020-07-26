import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scroll chapter")),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton.icon(
              icon: Icon(Icons.open_in_new),
              color: Colors.red,
              label: Text("SingleChildScrollView"),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return SingleScrollRoute();
              })),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.open_in_new),
              color: Colors.cyan,
              label: Text("ListView"),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return InfiniteListViewRoute();
              })),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.open_in_new),
              color: Colors.blue,
              label: Text("GridView"),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return GridViewRoute();
              })),
            ),
            RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return CustomScrollViewTestRoute();
                  }));
                },
                icon: Icon(Icons.open_in_new),
                colorBrightness: Brightness.dark,
                color: Colors.indigo,
                label: Text("CustomScrollView")),
          ],
        ),
      ),
    );
  }
}

class SingleScrollRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scaffold(
      appBar: AppBar(
        title: Text("SingleChildScrollView"),
      ),
      body: Scrollbar(
        // 显示进度条
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              //动态创建一个List<Widget>
              children: str
                  .split("")
                  //每一个字母都用一个Text显示,字体为原来的两倍
                  .map((c) => Text(
                        c,
                        textScaleFactor: 2.0,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class InfiniteListViewRoute extends StatefulWidget {
  @override
  _InfiniteListViewRouteState createState() =>
      new _InfiniteListViewRouteState();
}

class _InfiniteListViewRouteState extends State<InfiniteListViewRoute> {
  static const loadingTag = "##loading##"; //表尾标记
  var _words = <String>[loadingTag];
  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    _retrieveData();
    _controller.addListener(() {
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && !showToTopBtn) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget divider1 = Divider(color: Colors.blue, height: 0, thickness: 2);
    Widget divider2 = Divider(color: Colors.green, height: 0, thickness: 2);
    return Scaffold(
      appBar: AppBar(
        title: Text("Infinite ListView with TapToTop"),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Random Words",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: Scrollbar(
              child: ListView.separated(
                controller: _controller,
                itemCount: _words.length,
                itemBuilder: (context, index) {
                  //如果到了表尾
                  if (_words[index] == loadingTag) {
                    //不足100条，继续获取数据
                    if (_words.length - 1 < 100) {
                      //获取数据
                      _retrieveData();
                      //加载时显示loading
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(strokeWidth: 2.0)),
                      );
                    } else {
                      //已经加载了100条数据，不再获取数据。
                      return Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            "没有更多了",
                            style: TextStyle(color: Colors.grey),
                          ));
                    }
                  }
                  //显示单词列表项
                  return ListTile(
                      title: Text(_words[index]),
                      leading: Text("${index + 1}"));
                },
                separatorBuilder: (context, index) {
                  return index % 2 == 0 ? divider1 : divider2;
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: showToTopBtn
          ? FloatingActionButton(
              backgroundColor: Colors.cyan,
              onPressed: () {
                _controller.animateTo(.0,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOutCirc);
              },
              child: Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        //重新构建列表
        _words.insertAll(
            _words.length - 1,
            //每次生成20个单词
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}

class GridViewRoute extends StatefulWidget {
  @override
  _GridViewRouteState createState() => _GridViewRouteState();
}

class _GridViewRouteState extends State<GridViewRoute> {
  List<IconData> _icons = []; //保存Icon数据

  void _retrieveIcons() {
    Future.delayed(Duration(milliseconds: 200)).then((value) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GridView")),
      body: Column(
        children: <Widget>[
          Expanded(
              child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast)
              ])),
          Expanded(
              child: GridView.extent(
            maxCrossAxisExtent: 120.0,
            childAspectRatio: 2.0,
            children: <Widget>[
              Icon(Icons.ac_unit),
              Icon(Icons.airport_shuttle),
              Icon(Icons.all_inclusive),
              Icon(Icons.beach_access),
              Icon(Icons.cake),
              Icon(Icons.free_breakfast),
            ],
          )),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                ),
                itemCount: _icons.length,
                itemBuilder: (BuildContext context, int index) {
                  //如果显示到最后一个并且Icon总数小于200时继续获取数据
                  if (index == _icons.length - 1 && _icons.length < 200) {
                    _retrieveIcons();
                  }
                  if (index < _icons.length) {
                    return Icon(_icons[index]);
                  } else {
                    return Icon(Icons.hourglass_empty);
                  }
                }),
          ),
        ],
      ),
    );
  }
}

class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "./images/avatar.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 50),
          ),
        ],
      ),
    );
  }
}
