import 'package:flutter/foundation.dart';

class TitleProvider with ChangeNotifier {
  String _title = 'u2stk';

  String get title => _title;

  void updateTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}
