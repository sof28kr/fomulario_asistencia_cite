import 'package:flutter/material.dart';
import 'package:fomulario_asistencia_cite/Conexion/supabaseEvento.dart';
import 'package:fomulario_asistencia_cite/Models/eventModel.dart';

class ProviderEventos extends ChangeNotifier {
  String provNombre;
  String provInicio;
  String provFinal;
  String provDepartamento;
  String provProvincia;
  String provDistrito;
  final SupabaseService supabaseService;

  ProviderEventos({
    this.provNombre = 'No hay nombre registrado',
    this.provInicio = 'No hay fecha de inicio registrada',
    this.provFinal = 'No hay fecha de final registrada',
    this.provDepartamento = 'No hay departamento registrado',
    this.provProvincia = 'No hay provincia registrada',
    this.provDistrito = 'No hay distrito registrado',
    required this.supabaseService,
  });

  void changeProvParticipanteId({
    required String newprovNombre,
    required String newprovInicio,
    required String newprovFinal,
    required String newprovDepartamento,
    required String newprovProvincia,
    required String newprovDistrito,
  }) {
    provNombre = newprovNombre;
    provInicio = newprovInicio;
    provFinal = newprovFinal;
    provDepartamento = newprovDepartamento;
    provProvincia = newprovProvincia;
    provDistrito = newprovDistrito;
    notifyListeners();
  }

  Future<void> saveEventToSupabase(BuildContext context) async {
    final event = EventModel(
      nombre: provNombre,
      inicio: provInicio,
      finalizacion: provFinal,
      departamento: provDepartamento,
      provincia: provProvincia,
      distrito: provDistrito,
    );
    final errorMessage = await supabaseService.insertEvent(event);
    if (errorMessage != null) {
      _showErrorDialog(context, errorMessage);
    }
  }

  Future<void> fetchEventByName(String name, BuildContext context) async {
    final event = await supabaseService.fetchEventByName(name);
    if (event == null) {
      _showErrorDialog(context, 'No se encontró el evento.');
      return;
    }
    provNombre = event.nombre;
    provInicio = event.inicio;
    provFinal = event.finalizacion;
    provDepartamento = event.departamento;
    provProvincia = event.provincia;
    provDistrito = event.distrito;
    notifyListeners();
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
