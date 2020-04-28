import 'package:flutter/material.dart';
import 'package:jd_loading/jd_loading.dart';

class MyTwoApp extends StatelessWidget {
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    Widget _progressJdLoading = Image.asset('assets/images/loading_jd_joy.gif');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text(
                  '默认⭕️Loading',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
                onPressed: () {
                  JDLoading.show(isDismissible: false);
                  Future.delayed(Duration(seconds: 5)).then((onValue) {
                    if (JDLoading.isShowing()) JDLoading.hide();
                  });
                }),
            RaisedButton(
                child: Text(
                  'JD字母Loading',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
                onPressed: () {
                  JDLoading.show(
                      type: LoadingType.NORMAL, isDismissible: false);
                  Future.delayed(Duration(seconds: 5)).then((onValue) {
                    if (JDLoading.isShowing()) JDLoading.hide();
                  });
                }),
            RaisedButton(
                child: Text(
                  '京东APP统一Loading',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
                onPressed: () {
                  JDLoading.show(
                      type: LoadingType.JD_MALL, isDismissible: false);
                  Future.delayed(Duration(seconds: 8)).then((onValue) {
                    if (JDLoading.isShowing()) JDLoading.hide();
                  });
                }),
            RaisedButton(
                child: Text(
                  '传入自定义widgetLoading',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
                onPressed: () {
                  JDLoading.show(
                      customBody: _progressJdLoading, isDismissible: false);
                  Future.delayed(Duration(seconds: 5)).then((onValue) {
                    if (JDLoading.isShowing()) JDLoading.hide();
                  });
                })
          ],
        ),
      ),
    );
  }
}
