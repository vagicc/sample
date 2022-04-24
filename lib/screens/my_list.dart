import 'package:flutter/material.dart';

/* 列表示例 */
class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);
  static String name = "列表示例"; //在首屏列表展示的文字
  static String routeName = "/MyList"; //设置的路由名

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MyList.name)),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyListViewDemo();
                }));
              },
              icon: Icon(Icons.key_off),
              label: const Text('listView水平滚动'),
            ),
            ElevatedButton(
              child: Text('网格列表'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyGridViewDemo();
                }));
              },
            ),
            OutlinedButton(
              child: Text('浮动'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyCustomScrollViewDemo();
                }));
              },
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyListItemDemo())),
              icon: Icon(Icons.zoom_out_outlined),
              label: Text('自定义列表'),
            ),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LongList();
                }));
              },
              icon: Icon(Icons.ac_unit_rounded),
              label: Text("长列表"),
            )
          ],
        ),
      ),
    );
  }
}

/*  listView的水平滚动方式  */
class MyListViewDemo extends StatelessWidget {
  const MyListViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' listView的水平滚动方式')),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal, //设置为水平滚动
          children: [
            Container(
              width: 160.0,
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
            Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

/* 网格列表 */
class MyGridViewDemo extends StatelessWidget {
  const MyGridViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('网格列表')),
      body: GridView.count(
        crossAxisCount: 2, //两列
        children: List.generate(100, (index) {
          //总数100个
          return Center(
            child: Container(
              width: 160.0,
              height: 160.0,
              color: Colors.red,
              child: Center(
                child: Text('Item $index'),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/* 在列表顶部放置一个浮动的 app bar */
class MyCustomScrollViewDemo extends StatelessWidget {
  const MyCustomScrollViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('test')),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('列表顶部浮动的app bar'),
            floating: true, //
            flexibleSpace: Placeholder(), //这样子声明，就会有测试X线
            expandedHeight: 200, //高度,不尖圆默认
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('Item #$index'),
            ),
            childCount: 1000, //列表条数
          )),
        ],
      ),
    );
  }
}

class LongList extends StatelessWidget {
  final List<String> items =
      List<String>.generate(1000, (index) => "列表项：￥$index");
  LongList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('长列表'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('${items[index]}'),
        );
      }),
    );
  }
}

abstract class ListItem {
  Widget buildTitle(BuildContext context);
  Widget buildSubtitle(BuildContext context);
}

class HeadingItem implements ListItem {
  final String heading;
  HeadingItem(this.heading);

  Widget buildTitle(BuildContext context) {
    return Text(
      heading,
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget buildSubtitle(BuildContext context) {
    return Text('');
  }
}

class MessageItem implements ListItem {
  final String sender;
  final String body;
  MessageItem(this.sender, this.body);

  Widget buildTitle(BuildContext context) => Text(sender);

  Widget buildSubtitle(BuildContext context) {
    return Text(body);
  }
}

class MyListItemDemo extends StatelessWidget {
  MyListItemDemo({Key? key}) : super(key: key);
  final List<ListItem> items = List<ListItem>.generate(
      1000,
      (i) => i % 6 == 0
          ? HeadingItem("Heading $i")
          : MessageItem("Sender $i", "Message body $i"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('自定义列表')),
      body: ListView.builder(itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );
      }),
    );
  }
}
