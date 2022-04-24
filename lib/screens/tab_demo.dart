import 'package:flutter/material.dart';

class TabDemo extends StatelessWidget {
  const TabDemo({Key? key}) : super(key: key);
  static String name = " Tab 切换"; //在首屏列表展示的文字
  static String routeName = "/TabDemo"; //设置的路由名

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TabDemo.name)),
      body: ListView(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PageViewDemo();
              }));
            },
            icon: Icon(Icons.dark_mode),
            label: Text("基础Tab切换"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TabViewDemo();
              }));
            },
            child: Text('TabView0'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TabBarView1();
              }));
            },
            icon: Icon(Icons.add_link),
            label: Text('tab controller'),
          ),
          ElevatedButton.icon(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyTabBar();
            })),
            icon: Icon(Icons.ios_share),
            label: Text('TabBar'),
          ),
        ],
      ),
    );
  }
}

class MyTabBar extends StatefulWidget {
  const MyTabBar({Key? key}) : super(key: key);

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar Widget'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.cloud_outlined)),
            Tab(icon: Icon(Icons.beach_access_sharp)),
            Tab(icon: Icon(Icons.brightness_5_sharp)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(child: Text("It's cloud_outlined")),
          Center(child: Text("It's rainy")),
          Center(child: Text("It's sunny")),
        ],
      ),
    );
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Zeroth'),
  Tab(text: 'First'),
  Tab(text: 'Second'),
];

class TabBarView1 extends StatelessWidget {
  const TabBarView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            //使用tabController.index获取当前标签的索引
            print('当前:${tabController.index}');
          }
        });

        return Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: tabs),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Center(
                child: Text(
                  '${tab.text!} Tab',
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}

class TabViewDemo extends StatelessWidget {
  const TabViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Widget'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(icon: Icon(Icons.cloud_outlined)),
              Tab(icon: Icon(Icons.beach_access_sharp)),
              Tab(icon: Icon(Icons.brightness_5_sharp)),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}

/* 最基础的 Tab 切换 */
class PageViewDemo extends StatelessWidget {
  const PageViewDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    //生成6个Tab页
    for (var i = 0; i < 6; i++) {
      children.add(Page(text: '$i'));
    }
    return Scaffold(
      appBar: AppBar(title: Text(TabDemo.name)),
      body: PageView(
        // scrollDirection:Axis.vertical,  //设置滑动方向为垂直方向，默认不设置则为水平方向
        allowImplicitScrolling: true, //缓存前后各一页,不设置则不缓存
        children: children,
      ),
    );
  }
}

class Page extends StatefulWidget {
  final String text;
  const Page({Key? key, required this.text}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    print("构建build ${widget.text}");

    return Center(
      child: Text(
        "页面：${widget.text}",
        textScaleFactor: 5,
      ),
    );
  }
}
