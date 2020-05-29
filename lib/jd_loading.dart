library jd_loading;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LoadingType {
  ///正常圆圈
  NORMAL,

  ///JD字母
  JD,

  ///京东APP loading
  JD_MALL,

  ///自定义widget
  ME
}

///是否可见
bool _isShowing = false;

class JDLoading {
  ///单例
  static final JDLoading _singleton = JDLoading._internal();

  factory JDLoading() {
    return _singleton;
  }

  JDLoading._internal();

  ///全局Context
  static BuildContext appContext;

  ///展示类型
  static LoadingType _loadingType = LoadingType.NORMAL;

  ///是否点击取消
  static bool _loadingDismissible = true;

  ///自定义样式
  static Widget _customBody;

  static _LoadingDialog _dialog;

  ///初始化
  static init(BuildContext context) {
    appContext = context;
  }

  static JDLoading style(
      {LoadingType type, bool isDismissible, Widget customBody}) {
    _loadingType = type;
    _loadingDismissible = isDismissible ?? true;
    _customBody = customBody ?? null;
    return JDLoading._singleton;
  }

  static bool isShowing() {
    return _isShowing;
  }

  static Future<bool> loading(BuildContext context,
      {LoadingType type, bool isDismissible, Widget customBody}) async {
    appContext = context;
    return show(
        type: type, isDismissible: isDismissible, customBody: customBody);
  }

  static Future<bool> show(
      {LoadingType type, bool isDismissible, Widget customBody}) async {
    _loadingType = type;
    _loadingDismissible = isDismissible ?? true;
    _customBody = customBody ?? null;
    if (appContext == null) {
      debugPrint('Error!!! please init JDLoading before show.');
      return false;
    }
    try {
      if (!_isShowing) {
        _dialog = new _LoadingDialog();
        showDialog<dynamic>(
          context: JDLoading.appContext,
          barrierDismissible: _loadingDismissible,
          builder: (BuildContext context) {
            return Directionality(
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (BuildContext _context) {
                      return _dialog;
                    },
                  ),
                ],
              ),
              textDirection: TextDirection.ltr,
            );
          },
        );
        _isShowing = true;
        return true;
      } else {
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the dialog');
      debugPrint(err);
      return false;
    }
  }

  static Future<bool> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(JDLoading.appContext).pop();
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding dialog');
      debugPrint(err);
      return Future.value(false);
    }
  }
}

// ignore: must_be_immutable
class _LoadingDialog extends StatefulWidget {
  _LoadingDialogState _dialog = _LoadingDialogState();

  update() {
    _dialog.update();
  }

  @override
  State<StatefulWidget> createState() {
    return _dialog;
  }
}

class _LoadingDialogState extends State<_LoadingDialog> {
  update() {
    setState(() {});
  }

  @override
  void dispose() {
    _isShowing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (JDLoading._customBody != null) {
      JDLoading._loadingType = LoadingType.ME;
    }
    return getDialogBody();
  }

  Widget getDialogBody() {
    Widget _progressIconWidget = Image.asset(
      'assets/images/loading_jd_icon.png',
      package: 'jd_loading',
    );
    Widget _progressJdLoading = Image.asset(
      'assets/images/loading_jd_mall.gif',
      package: 'jd_loading',
    );
    switch (JDLoading._loadingType) {
      case LoadingType.NORMAL:
        {
          ///展示正常样式,显示JD字母;
          return Container(
            width: 66,
            height: 66,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: <Widget>[
                SizedBox(
                  width: 33,
                  height: 33,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 33,
                      height: 33,
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 217, 217, 217),
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                            Color.fromARGB(255, 167, 167, 167)),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 33,
                  height: 33,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 33,
                      height: 33,
                      child: _progressIconWidget,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        break;
      case LoadingType.JD_MALL:
        {
          ///京东物流APP loading动画;
          return Container(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 66,
                      height: 66,
                      child: _progressJdLoading,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        break;
      case LoadingType.ME:
        {
          ///自定义 loading动画;
          return Container(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 66,
                      height: 66,
                      child: JDLoading._customBody,
                    ),
                  ),
                )
              ],
            ),
          );
        }
        break;
      default:
        {
          ///默认展示正常样式,显示JD字母;
          return Container(
            width: 66,
            height: 66,
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: <Widget>[
                SizedBox(
                  width: 33,
                  height: 33,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 33,
                      height: 33,
                      child: CircularProgressIndicator(
                        backgroundColor: Color.fromARGB(255, 217, 217, 217),
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                            Color.fromARGB(255, 167, 167, 167)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        break;
    }
  }
}
