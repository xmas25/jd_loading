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
        child: RaisedButton(
            child: Text(
              '新页面(验证BuildContext)',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.deepOrange,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyTwoApp()),
              );
            }),
      ),
    );
  }
}
