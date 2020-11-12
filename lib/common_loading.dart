import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  static BuildContext loadingContext;

  ///展示类型
  static LoadingType _loadingType = LoadingType.JD_MALL;

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
      {LoadingType type, bool isDismissible, Widget customBody}) {
    appContext = context;
    return _show(
        type: type, isDismissible: isDismissible, customBody: customBody);
  }

  static Future<bool> show(
      {LoadingType type, bool isDismissible, Widget customBody}) {
    return _show(
        type: type, isDismissible: isDismissible, customBody: customBody);
  }

  static Future<bool> _show(
      {LoadingType type, bool isDismissible, Widget customBody}) async {
    _loadingType = type ?? LoadingType.JD_MALL;
    _loadingDismissible = isDismissible ?? true;
    _customBody = customBody ?? null;
    if (appContext == null) {
      print('Error!!! please init JDLoading before show.');
      return Future.value(false);
    }
    try {
      if (!_isShowing) {
        _isShowing = true;
        {
          _dialog = new _LoadingDialog();
          showDialog<dynamic>(
            context: JDLoading.appContext,
            barrierDismissible: _loadingDismissible,
            builder: (BuildContext context) {
              loadingContext = context;
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
          ).then((val) {
            print('yes,dismiss loading with showDialog');
            _isShowing = false;
          });
        }
      }
      return Future.value(true);
    } catch (err) {
      debugPrint('wa e,Exception while showing the dialog');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  ///隐藏loading
  static Future<bool> hide({bool rootNavigator = false}) {
    try {
      if (_isShowing) {
        _isShowing = false;
        if (rootNavigator) {
          Navigator.of(loadingContext, rootNavigator: true).pop();
        } else {
          Navigator.maybePop(loadingContext);
        }
      }
      return Future.value(true);
    } catch (err) {
      print(err);
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
    switch (JDLoading._loadingType) {
      case LoadingType.JD:
        {
          ///展示正常样式,显示JD字母
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
          ///京东APP joy loading动画;
          return Container(
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.passthrough,
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Lottie.asset('assets/images/loading.json',
                          package: 'jd_loading', width: 50, height: 50),
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
          ///默认展示正常样式
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

///拷贝自源码，为了修改dialog背景色
Future<T> showDialog<T>({
  @required
      BuildContext context,
  bool barrierDismissible = true,
  @Deprecated(
      'Instead of using the "child" argument, return the child from a closure '
      'provided to the "builder" argument. This will ensure that the BuildContext '
      'is appropriate for widgets built in the dialog. '
      'This feature was deprecated after v0.2.3.')
      Widget child,
  WidgetBuilder builder,
  bool useRootNavigator = true,
}) {
  assert(child == null || builder == null);
  assert(useRootNavigator != null);
  assert(debugCheckHasMaterialLocalizations(context));

  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = child ?? Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Color(0x01000000),
    transitionDuration: const Duration(milliseconds: 150),
    useRootNavigator: useRootNavigator,
  );
}
