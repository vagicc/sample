import 'package:flutter/material.dart';
import 'screens/test.dart';
import 'screens/animated_list.dart';

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
    builder: (context) => AnimatedListRoute(),
  ),
  SampleRoute(
    name: Test.name,
    route: Test.routeName,
    builder: (context) => Test(),
  ),
  
];

final screensRoutes = Map.fromEntries(
  screens
      .map((sampleRoute) => MapEntry(sampleRoute.route, sampleRoute.builder)),
);

final allRoutes = <String, WidgetBuilder>{
  ...screensRoutes,
};
