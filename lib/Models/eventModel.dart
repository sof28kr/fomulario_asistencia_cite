// models/event_model.dart
class EventModel {
  final String nombre;
  final String inicio;
  final String finalizacion;
  final String departamento;
  final String provincia;
  final String distrito;
  final String servicio;

  EventModel({
    required this.nombre,
    required this.inicio,
    required this.finalizacion,
    required this.departamento,
    required this.provincia,
    required this.distrito,
    required this.servicio,
  });

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      nombre: map['nombre'],
      inicio: map['inicio'],
      finalizacion: map['finalizacion'],
      departamento: map['departamento'],
      provincia: map['provincia'],
      distrito: map['distrito'],
      servicio: map['servicio'],
    );
  }

  get supabase => null;

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'inicio': inicio,
      'finalizacion': finalizacion,
      'departamento': departamento,
      'provincia': provincia,
      'distrito': distrito,
      'servicio': servicio,
    };
  }

  Future<void> eliminarEvento(
    int nombreEvento,
  ) async {
    await supabase.from("eventos").delete().eq("nombre", nombreEvento);
  }
}
