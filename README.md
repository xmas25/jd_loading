# jd_loading

> 京东系APP统一Loading

## 示例预览

<img src="https://storage.jd.com/dqimage/img/demo/loading_preview.png" width = "675" height = "290" alt="" align=center />

## 如何使用？

依赖library：

 ```dart
dependencies:
  jd_loading: ^0.1.0
  
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
 更多使用，参见example.
