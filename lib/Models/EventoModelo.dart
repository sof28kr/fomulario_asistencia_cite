import 'package:flutter/material.dart';

class providerEventos extends ChangeNotifier {
  String provNombre;
  String provInicio;
  String provFinal;
  String provDepartamento;
  String provProvincia;
  String provDistrito;

  providerEventos({
    this.provNombre = 'No hay nombre registrado',
    this.provInicio = 'No hay fecha de inicio registrada',
    this.provFinal = 'No hay fecha de final registrada',
    this.provDepartamento = 'No hay departamento registrado',
    this.provProvincia = 'No hay provincia registrada',
    this.provDistrito = 'No hay distrito registrado',
  });

  void changeProvParticipanteId({
    required String newprovNombre,
    required String newprovInicio,
    required String newprovFinal,
    required String newprovDepartamento,
    required String newprovProvincia,
    required String newprovDistrito,
  }) async {
    provNombre = newprovNombre;
    provInicio = newprovInicio;
    provFinal = newprovFinal;
    provDepartamento = newprovDepartamento;
    provProvincia = newprovProvincia;
    provDistrito = newprovDistrito;
    notifyListeners();
  }
}
