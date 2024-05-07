import 'package:flutter/material.dart';

class ProviderParticipantes extends ChangeNotifier {
  String dni;
  String nombre;
  String telefono;
  String direccion;
  String email;
  String RUC;

  ProviderParticipantes({
    this.dni = "",
    this.nombre = "",
    this.telefono = "",
    this.direccion = "",
    this.email = "",
    this.RUC = "",
  });

  void changeParticipantes({
    required String newdni,
    required String newnombre,
    required String newtelefono,
    required String newdireccion,
    required String newemail,
    required String newRUC,
  }) async {
    dni = newdni;
    nombre = newnombre;
    telefono = newtelefono;
    direccion = newdireccion;
    email = newemail;
    RUC = newRUC;

    notifyListeners();
  }
}
