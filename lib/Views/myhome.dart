import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //indica el flujo de nuevos participantes
  final _participantesStream =
      //el nombre que va ahi es el nombre de la tabla
      Supabase.instance.client.from('participantes').stream(primaryKey: ['id']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('mi tabla'),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _participantesStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final Participantes = snapshot.data!;
            return ListView.builder(
                itemCount: Participantes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(Participantes[index]['nombre']),
                  );
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => context.push('/add'),
        ));
  }
}
