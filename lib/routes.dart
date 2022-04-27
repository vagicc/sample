import 'package:flutter/material.dart';
import 'screens/color_theme_demo.dart';
import 'screens/inherited_widget_test.dart';
import 'screens/my_list.dart';
import 'screens/provider_demo.dart';
import 'screens/tab_demo.dart';
import 'screens/test.dart';
import 'screens/animated_list.dart';
import 'screens/friendly-chat-app.dart';
import 'screens/value_listenable_demo.dart';
import 'screens/will_pop_scope_test.dart';

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
  SampleRoute(
    name: TabDemo.name,
    route: TabDemo.routeName,
    builder: (context) => TabDemo(),
  ),
  SampleRoute(
    name: WillPopScopeTest.name,
    route: WillPopScopeTest.routeName,
    builder: (context) => WillPopScopeTest(),
  ),
  SampleRoute(
    name: InheritedWidgetTest.name,
    route: InheritedWidgetTest.routeName,
    builder: (context) => InheritedWidgetTest(),
  ),
  SampleRoute(
    name: ProviderDemo.name,
    route: ProviderDemo.routeName,
    builder: (context) => ProviderDemo(),
  ),
  SampleRoute(
    name: ValueListenableDemo.name,
    route: ValueListenableDemo.routeName,
    builder: (context) => ValueListenableDemo(),
  ),
  SampleRoute(
    name: ColorThemeDemo.name,
    route: ColorThemeDemo.routeName,
    builder: (context) => ColorThemeDemo(),
  ),
];

final screensRoutes = Map.fromEntries(
  screens
      .map((sampleRoute) => MapEntry(sampleRoute.route, sampleRoute.builder)),
);

final allRoutes = <String, WidgetBuilder>{
  ...screensRoutes,
};
