import 'package:flutter/material.dart';
import 'dart:convert';

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
