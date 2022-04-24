import 'package:flutter/material.dart';
import 'package:sample/screens/test.dart';
import 'routes.dart';

void main() {
  // runApp(const MyApp());   //原本代码生成的
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* 主题设置:https://flutter.dev/docs/cookbook/design/themes */
    return MaterialApp(
      title: "Sample App",
      theme: ThemeData(
        primarySwatch: Colors.purple, //主题颜色
        // visualDensity: VisualDensity.adaptivePlatformDensity, //视觉密度
        // fontFamily: 'GenWanMinTW', //全局使用字体:源云明体 比案桌原字体淡一点
      ),
      // routes: {
      //   'index': (context) => Examples(),   //这是路由写法
      // },
      routes: allRoutes, //把路由文件单独放在routes.dart中
      // initialRoute: 'index', //使用时initialRoute，请勿定义home属性
      home: SampleDemo(),
    );
  }
}

class SampleDemo extends StatelessWidget {
  const SampleDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(title: Text("示例整合")),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const ListTile(
            title: Text('标题'),
          ),
          ...screens.map(
            (sampleRoute) => RouteList(sampleRoute: sampleRoute),
          ),
          ElevatedButton(
            style: style,
            onPressed: null,
            child: const Text('Disabled'),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {},
            child: const Text('Enabled'),
          ),
          Container(
            height: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ),
    );
  }
}

/* 单个列表样式 */
class RouteList extends StatelessWidget {
  static int listNum = 1;
  final SampleRoute sampleRoute;
  const RouteList({Key? key, required this.sampleRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    /* 按奇偶返回不同按纽 */
    Widget returnButton = (++listNum % 2 != 1)
        ? ElevatedButton(
            // style: style,
            onPressed: () => Navigator.pushNamed(context, sampleRoute.route),
            child: Text(sampleRoute.name),
          )
        : OutlinedButton(
            child: Text(sampleRoute.name),
            onPressed: () {
              Navigator.pushNamed(context, sampleRoute.route);
            },
          );
    // print("listNum % 2 = ${listNum % 2}");

    return returnButton;
  }
}

class Examples extends StatelessWidget {
  const Examples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('示例样本 sample')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: [],
          ),
        ),
      ),
    );
  }
}

/* 这个是原本代码生成的 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sample',
      theme: ThemeData(
        primarySwatch: Colors.lime, //主题颜色
      ),
      home: const MyHomePage(title: 'Flutter Code Sample'),
    );
  }
}

/* 原来创建的计算器 */
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
        title: Text(widget.title),
      ),
      body: Center(
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
            const Text(
              '点击按纽次数:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
