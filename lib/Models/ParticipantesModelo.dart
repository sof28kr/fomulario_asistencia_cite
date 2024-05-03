import 'package:flutter/material.dart';

class ParticipantesModelo extends ChangeNotifier {
  String nombreprueba = "";
  String get nombre => nombreprueba;

  void agregar() {
    nombreprueba = "" + "plus";
    notifyListeners();
  }
}
