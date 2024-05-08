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

  void resetFirmaString() {
    firmaString =
        'no hay firma'; // Puedes cambiar esto por '' si prefieres que esté completamente en blanco
    notifyListeners();
  }
}
