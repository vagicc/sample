import 'package:flutter/material.dart';

// widget 树中从上到下共享数据
// 和数据流向无关，可以实现任意流向的数据共享。
// 实践中，ValueListenableBuilder 的拆分粒度应该尽可能细，可以提高性能
class ValueListenableDemo extends StatefulWidget {
  const ValueListenableDemo({Key? key}) : super(key: key);
  static String name = "widget从上到下共享数据"; //在首屏列表展示的文字
  static String routeName = "/ValueListenableDemo"; //设置的路由名

  @override
  State<ValueListenableDemo> createState() => _ValueListenableDemoState();
}

class _ValueListenableDemoState extends State<ValueListenableDemo> {
  //定义一个ValueNotifier，当数字变化时会通知 ValueListenableBuilder
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  static const double textScaleFactor = 1.5;

  @override
  Widget build(BuildContext context) {
    // 添加 + 按钮不会触发整个 ValueListenableRoute 组件的 build
    print('build 只触发一次');

    return Scaffold(
        appBar: AppBar(title: Text('ValueListenableBuilder示例')),
        body: Center(
          child: ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, Widget? child) {
              //builder 方法只会在 _counter 变化时被调用
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  child!,
                  Text('$value 次', textScaleFactor: textScaleFactor),
                  
                ],
              );
            },
            valueListenable: _counter,
            // 当子组件不依赖变化的数据，且子组件收件开销比较大时，指定 child 属性来缓存子组件非常有用
            child: const Text('点击了 ', textScaleFactor: textScaleFactor),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _counter.value += 1,
        ));
  }
}
