# jd_loading

> APP全局统一Loading

## 示例预览

![image](https://storage.jd.com/dqimage/img/demo/loading_preview.png)

## 如何使用？

依赖library：

```dart
dependencies:
  jd_loading: ^0.1.6

```
在入口页面初始化：

```dart
class MyApp extends StatelessWidget {
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    Application.appContext = context;
    //初始化
    JDLoading.init(context);
    return Scaffold(
    );
  }
}
```

在任意页面调用，展示loading：

```dart
JDLoading.show();

 ```
如果需要initState展示，则需要等页面渲染完，再调用，比如监听页面帧是否渲染完毕等

```dart
WidgetsBinding.instance
       .addPostFrameCallback((_) => _showDialogFrame(context));

```

如果不显示，需要重新传入BuildContext,(测试遇见使用FlutterBoost时候，需要重新传入context)

```dart
JDLoading.loading(context);

```

如果需要显示和隐藏的回调，可以这样处理

```dart
 JDLoading.loading(context, isDismissible: true).then((value) {
    print('aaa show loading callback');
 });
 Future.delayed(Duration(seconds: 3)).then((onValue) {
    if (JDLoading.isShowing())
      JDLoading.hide().then((status) {
        print('aaa hide loading callback');
      });
 });

```

更多使用，参见example.
