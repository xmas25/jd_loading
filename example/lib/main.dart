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
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  JDLoading.loading(context, isDismissible: true).then((value) {
                    print('aaa show loading callback');
                  });
                  Future.delayed(Duration(seconds: 3)).then((onValue) {
                    if (JDLoading.isShowing())
                      JDLoading.hide().then((status) {
                        print('aaa hide loading callback');
                      });
                  });
                }),
            RaisedButton(
                child: Text(
                  'Test New BuildContext',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyTwoApp()),
                  );
                }),
            RaisedButton(
                child: Text(
                  'Test hide',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.deepOrangeAccent,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => new AlertDialog(
                            title: new Text("Material Dialog"),
                            content: new Text("Hey! I'm a Test!"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('Close me!'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ));
                })
          ],
        ),
      ),
    );
  }
}
