import 'package:flutter/material.dart';

Widget crearFormField(
  titulo,
  indicacion,
  icono,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15),
    child: TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintText: titulo,
          labelText: indicacion,
          suffixIcon: icono,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
    ),
  );
}

Widget BusquedaDni() {
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [Text('data'), Text('data')],
      ));
}


