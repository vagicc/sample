import 'package:flutter/material.dart';
import 'screens/my_list.dart';
import 'screens/test.dart';
import 'screens/animated_list.dart';
import 'screens/friendly-chat-app.dart';

class SampleRoute {
  final String name; //名字说明
  final String route; //路由
  final WidgetBuilder builder;

  SampleRoute({required this.name, required this.route, required this.builder});
}

/* 每添加一个示例页，在此添加到数组中,则自动在首屏列表有 */
final screens = [
  SampleRoute(
    name: AnimatedListRoute.name,
    route: AnimatedListRoute.routeName,
    builder: (context) => const AnimatedListRoute(),
  ),
  SampleRoute(
    name: Test.name,
    route: Test.routeName,
    builder: (context) => const Test(),
  ),
  SampleRoute(
    name: FriendlyChatApp.name,
    route: FriendlyChatApp.routeName,
    builder: (context) => FriendlyChatApp(),
  ),
  SampleRoute(
    name: MyList.name,
    route: MyList.routeName,
    builder: (context) => MyList(),
  ),
];

final screensRoutes = Map.fromEntries(
  screens
      .map((sampleRoute) => MapEntry(sampleRoute.route, sampleRoute.builder)),
);

final allRoutes = <String, WidgetBuilder>{
  ...screensRoutes,
};
