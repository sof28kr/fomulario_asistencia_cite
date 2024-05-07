import 'package:flutter/material.dart';

class ProviderFirma extends ChangeNotifier {
  String firmaString;

  ProviderFirma({this.firmaString = 'no hay firma'});

  void ChangeFirmaString({
    required String newFirmaString,
  }) async {
    firmaString = newFirmaString;
    notifyListeners();
  }
}
