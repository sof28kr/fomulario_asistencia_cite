// services/supabase_service.dart
import 'package:fomulario_asistencia_cite/Models/eventModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client;

  SupabaseService(String supabaseUrl, String supabaseKey)
      : _client = SupabaseClient(supabaseUrl, supabaseKey);

  Future<String?> insertEvent(EventModel event) async {
    final response = await _client.from('eventos').insert(event.toMap());
  }

  Future<EventModel?> fetchEventByName(String name) async {
    final PostgrestMap response =
        await _client.from('eventos').select().eq('nombre', name).single();
  }
}
