import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class prueba extends StatefulWidget {
  @override
  _pruebaState createState() => _pruebaState();
}

class _pruebaState extends State<prueba> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> options = [];
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    fetchOptions();
  }

  Future<void> fetchOptions() async {
    try {
      final response = await supabase
          .from('eventos')
          .select('id, nombre')
          .order('created_at', ascending: false)
          .limit(10);

      final data = response as List<Map<String, dynamic>>;
      setState(() {
        options = data;
        if (options.isNotEmpty) {
          selectedOption = options.first['id'].toString();
        }
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Demo'),
      ),
      body: Center(
        child: options.isEmpty
            ? CircularProgressIndicator()
            : DropdownButton<String>(
                hint: Text('Select an option'),
                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue;
                  });
                  print('Selected ID: $newValue');
                },
                items: options.map((option) {
                  return DropdownMenuItem<String>(
                    value: option['id'].toString(),
                    child: Text(option['nombre']),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
