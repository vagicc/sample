import 'package:flutter/material.dart';

/* 颜色和主题 */
// Color(0xffdc380d); //如果颜色固定可以直接使用整数值
// //颜色是一个字符串变量
// var c = "dc380d";
// Color(int.parse(c,radix:16)|0xFF000000) //通过位运算符将Alpha设置为FF
// Color(int.parse(c,radix:16)).withAlpha(255)  //通过方法将Alpha设置为FF
class ColorThemeDemo extends StatelessWidget {
  const ColorThemeDemo({Key? key}) : super(key: key);
  static String name = "颜色和主题"; //在首屏列表展示的文字
  static String routeName = "/ColorThemeDemo"; //设置的路由名

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ColorThemeDemo.name)),
      body: Column(
        children: <Widget>[
          // 路由换肤功能
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ThemeTestRoute();
              }));
            },
            icon: Icon(Icons.add_link),
            label: Text('路由换肤功能'),
          ),
          //背景为蓝色，则title自动为白色
          NavBar(color: Colors.blue, title: "蓝色bar"),
          //背景为白色，则title自动为黑色
          NavBar(color: Colors.white, title: "标题"),
        ],
      ),
    );
  }
}

//路由换肤功能
class ThemeTestRoute extends StatefulWidget {
  const ThemeTestRoute({Key? key}) : super(key: key);

  @override
  State<ThemeTestRoute> createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  var _themeColor = Colors.teal; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor,
        iconTheme: IconThemeData(color: _themeColor),
      ),
      child: Scaffold(
        appBar: AppBar(title: Text('主题测试')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //第一行Icon使用主题中的iconTheme
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text('颜色跟随主题'),
              ],
            ),
            //为第二行Icon自定义颜色（固定为黑色）
            Theme(
              data: themeData.copyWith(
                iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色固定黑色"),
                ],
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => setState(() {
                _themeColor = Colors.amber;
              }),
              icon: Icon(Icons.access_alarm),
              label: Text('amber琥珀色，黄褐色'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _themeColor = Colors.lime;
                });
              },
              icon: Icon(Icons.two_mp_rounded),
              label: Text("lime"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() {
            _themeColor =
                _themeColor == Colors.teal ? Colors.blue : Colors.teal;
          }),
          child: const Icon(Icons.palette),
        ),
      ),
    );
  }
}

/// 背景颜色和Title可以自定义的导航栏
class NavBar extends StatelessWidget {
  final String title;
  final Color color; //背景颜色
  const NavBar({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 52,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [
          //阴影
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          //根据背景颜色亮度来确定Title的颜色
          color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
