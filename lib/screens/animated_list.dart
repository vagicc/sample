import 'package:flutter/material.dart';

class AnimatedListRoute extends StatefulWidget {
  static String name = "AnimatedList示例"; //在首屏列表展示的文字
  static String routeName = "/AnimatedListRoute"; //设置的路由名
  const AnimatedListRoute({Key? key}) : super(key: key);

  @override
  State<AnimatedListRoute> createState() => _AnimatedListRouteState();
}

class _AnimatedListRouteState extends State<AnimatedListRoute> {
  var data = <String>[];
  int counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < counter; i++) {
      data.add("${i + 1}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(title: Text('AnimatedList示例')),
      // appBar: AppBar(title: Text(widget.name)),
      appBar: AppBar(title: Text(AnimatedListRoute.name)),
      body: Stack(
        children: [
          AnimatedList(
            key: globalKey,
            initialItemCount: data.length,
            itemBuilder: (
              BuildContext context,
              int index,
              Animation<double> animation,
            ) {
              //添加列表项时会执行渐显动画
              return FadeTransition(
                opacity: animation,
                child: buildItem(context, index),
              );
            },
          ),
          buildAddBtn(),
        ],
      ),
    );
  }

  // 创建一个 “+” 按钮，点击后会向列表中插入一项
  Widget buildAddBtn() {
    return Positioned(
      child: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // 添加一个列表项
          data.add('${++counter}');
          globalKey.currentState!.insertItem(data.length - 1);
          print("添加 $counter");
        },
      ),
      bottom: 30,
      left: 0,
      right: 0,
    );
  }

  // 构建列表项
  Widget buildItem(context, index) {
    String char = data[index];
    return ListTile(
      key: ValueKey(char),
      title: Text(char),
      trailing: IconButton(
        onPressed: () => onDelete(context, index),
        icon: Icon(Icons.delete),
      ),
    );
  }

  onDelete(context, index) {
    globalKey.currentState!.removeItem(
      index,
      (context, animation) {
        // 删除过程执行的是反向动画，animation.value 会从1变为0
        var item = buildItem(context, index);
        print("删除 ${data[index]}");
        data.removeAt(index);

        // 删除动画是一个合成动画：渐隐 + 缩小列表项告诉
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.5, 1.0),
          ),
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: item,
          ),
        );
      },
      duration: Duration(milliseconds: 200), //动画时间为200ms
    );
  }
}
