import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Image img = Image.asset('');

class formulario1 extends StatefulWidget {
  const formulario1({super.key});

  @override
  State<formulario1> createState() => _formulario1State();
}

class _formulario1State extends State<formulario1> {
  //controladores
  final nombrevariable = TextEditingController();

  //variables que guardan los valores
  String nom = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('agregando'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: nombrevariable,
              decoration: InputDecoration(hintText: 'nombre'),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Ingrese su Firma'),
            FilledButton(
                onPressed: () => context.push('/firma'),
                child: Text('Registrar Firma')),
          ]),
          SizedBox(
            height: 40,
          ),
          FilledButton(
              onPressed: () async {
                //toma el valor del controlador y lo usa en la variable
                nom = nombrevariable.text;
                print(nom);

                // limpiar textfield
                nombrevariable.text = '';

                Navigator.of(context).pop();
              },
              child: Text('Registrar Participante'))
        ],
      ),
    );
  }
}
