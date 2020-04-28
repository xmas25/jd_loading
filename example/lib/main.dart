import 'package:flutter/material.dart';
import 'package:jd_loading/jd_loading.dart';

import 'application.dart';
import 'new_page.dart';

void main() {
  final app = MaterialApp(
    home: MyApp(),
  );
  runApp(app);
}

class MyApp extends StatelessWidget {
  double percentage = 0.0;

  @override
  Widget build(BuildContext context) {
    Application.appContext = context;
    JDLoading.init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text(
                  'Show⭕️Loading',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
                onPressed: () {
                  JDLoading.show(isDismissible: true);
                  Future.delayed(Duration(seconds: 5)).then((onValue) {
                    if (JDLoading.isShowing()) JDLoading.hide();
                  });
                }),
            RaisedButton(
                child: Text(
                  'Test New BuildContext)',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyTwoApp()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
