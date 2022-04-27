import 'package:flutter/material.dart';

class WillPopScopeTest extends StatefulWidget {
  const WillPopScopeTest({Key? key}) : super(key: key);
  static String name = "导航返回拦截"; //在首屏列表展示的文字
  static String routeName = "/WillPopScopeTest"; //设置的路由名

  @override
  State<WillPopScopeTest> createState() => _WillPopScopeTestState();
}

class _WillPopScopeTestState extends State<WillPopScopeTest> {
  DateTime? _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Container(
        alignment: Alignment.center,
        child: Text("1秒内连续按两次返回键退出"),
      ),
    );
  }
}
