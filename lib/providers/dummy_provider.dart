import 'package:flutter/material.dart';

class DummyProvider with ChangeNotifier {
  String value = "Hola desde Dummy";

  void updateValue(String nuevo) {
    value = nuevo;
    notifyListeners();
  }
}
