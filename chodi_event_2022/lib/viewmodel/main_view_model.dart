import 'package:flutter/cupertino.dart';
import 'package:flutter_chodi_app/screens/impact/impact_screen.dart';

class MainScreenViewModel with ChangeNotifier {
  Widget _widget = const ImpactScreen();

  // widget change
  void setWidget(Widget widget) {
    _widget = widget;
    notifyListeners();
  }

  get widget => _widget;
}
