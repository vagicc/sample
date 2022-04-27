import 'dart:collection';
import 'package:flutter/material.dart';

class ProviderDemo extends StatefulWidget {
  const ProviderDemo({Key? key}) : super(key: key);
  static String name = "跨组件状态共享"; //在首屏列表展示的文字
  static String routeName = "/ProviderDemo"; //设置的路由名

  @override
  State<ProviderDemo> createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("跨组件状态管理（Provider）")),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context) {
            return Column(
              children: <Widget>[
                Builder(builder: (context) {
                  var cart = ChangeNotifierProvider.of<CartModel>(context);

                  return Text("购物车总价：${cart.totalPrice}");
                }),
                //这个等同于上面的代码，但更有明确的主义
                Consumer<CartModel>(
                  builder: (context, cart) =>
                      Text("封装订阅者-购物车总价：${cart?.totalPrice}"),
                ),

                Builder(builder: (context) {
                  print("添加1个20元的商品……");
                  return ElevatedButton(
                    child: Text('添加1个20元的商品'),
                    onPressed: () {
                      //添加商品给购物车
                      ChangeNotifierProvider.of<CartModel>(context,
                              listen: false)
                          .add(Item(price: 20, count: 1));
                    },
                  );
                }),
                Builder(builder: (context) {
                  print('添加两个3元的商品');
                  return ElevatedButton.icon(
                    onPressed: () {
                      ChangeNotifierProvider.of<CartModel>(context,
                              listen: false)
                          .add(Item(price: 3, count: 2));
                    },
                    icon: Icon(Icons.kebab_dining_outlined),
                    label: Text('添加2个3元的商品'),
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }
}

//封装订阅者，消费者 => 明确主义   便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  Consumer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}

//购物车内商品数据,   应该做成 ”单例模式“
class CartModel extends ChangeNotifier {
  final List<Item> _items = []; //保存购物车商品列表

  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  //购物车商品总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  //添加商品到购物车
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

//商品信息
class Item {
  Item({required this.price, required this.count});
  double price; //商品单价
  int count; //商品数量
  // ...
}

//  =====================下面为工具类================

//通用的InheritedWidget，保存需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  final T data;
  InheritedProvider({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

class ChangeNotifier extends Listenable {
  List listeners = [];

  @override
  void addListener(VoidCallback listener) {
    //添加监听
    listeners.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    //移除监听器
    listeners.add(listener);
  }

  void notifyListeners() {
    //通知所有监听器，触发监听回调
    listeners.forEach((item) => item());
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;
  const ChangeNotifierProvider({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T of<T>(BuildContext context, {bool listen = true}) {
    // final provider =
    //     context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    /* 
    调用dependOnInheritedWidgetOfExactType() 
    和getElementForInheritedWidgetOfExactType()
    的区别就是前者会注册依赖关系，而后者不会
     */
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;

    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  //数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}
