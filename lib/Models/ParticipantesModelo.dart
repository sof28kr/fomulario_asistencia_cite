import 'package:flutter/material.dart';

class ProviderParticipantes extends ChangeNotifier {
  String dni;
  String nombre;
  String telefono;
  String direccion;
  String email;
  String RUC;

  ProviderParticipantes({
    this.dni = "1",
    this.nombre = "1",
    this.telefono = "1",
    this.direccion = "1",
    this.email = "1",
    this.RUC = "1",
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
