part of 'widgets.dart';

class UiLoading {
  static Container loading() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Style.transparent,
      child: SpinKitRing(
        size: 56,
        color: Style.white,
        lineWidth: 4,
      ),
    );
  }

  static Container loadingDropdown() {
    return Container(
      alignment: Alignment.center,
      width: 32,
      height: 32,
      color: Style.transparent,
      child: SpinKitRing(
        size: 32,
        color: Style.white,
        lineWidth: 4,
      ),
    );
  }

  static Container loadingBlock() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      color: Style.black,
      child: SpinKitRing(
        size: 56,
        color: Style.white,
        lineWidth: 4,
      ),
    );
  }
}
