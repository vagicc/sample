import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  static String name = "测试"; //在首屏列表展示的文字
  static String routeName = "/test"; //设置的路由名
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: Container(
        child: Text("test"),
      ),
    );
  }
}
