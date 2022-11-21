part of 'widgets.dart';

class UiToast {
  BuildContext? context;

  UiToast(BuildContext ctx) {
    context = ctx;
  }

  static void toastOk(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Style.green500,
        textColor: Style.white,
        fontSize: 14);
  }

  static void toastErr(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Style.red500,
        textColor: Style.white,
        fontSize: 14);
  }

  static void toastWarning(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Style.yellow500,
        textColor: Style.white,
        fontSize: 14);
  }
}
