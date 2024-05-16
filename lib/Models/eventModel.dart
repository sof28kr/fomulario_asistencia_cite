// models/event_model.dart
class EventModel {
  final String nombre;
  final String inicio;
  final String finalizacion;
  final String departamento;
  final String provincia;
  final String distrito;

  EventModel({
    required this.nombre,
    required this.inicio,
    required this.finalizacion,
    required this.departamento,
    required this.provincia,
    required this.distrito,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      nombre: map['nombre'],
      inicio: map['inicio'],
      finalizacion: map['finalizacion'],
      departamento: map['departamento'],
      provincia: map['provincia'],
      distrito: map['distrito'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'inicio': inicio,
      'finalizacion': finalizacion,
      'departamento': departamento,
      'provincia': provincia,
      'distrito': distrito,
    };
  }
}
