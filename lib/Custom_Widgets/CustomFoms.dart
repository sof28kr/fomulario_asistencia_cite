import 'package:fomulario_asistencia_cite/Views/Views.dart';

Widget crearFormField(
  titulo,
  indicacion,
  icono,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
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

Widget autocompletar() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: PrettyBorderButton(
      label: '  Autocompletar  ',
      onPressed: () {},
      labelStyle: const TextStyle(fontSize: 16),
      bgColor: const Color(0xffC4ACCD),
      borderColor: const Color(0xff6C3082),
      borderWidth: s5,
    ),
  );
}

class subirFirma extends StatefulWidget {
  const subirFirma({super.key});

  @override
  State<subirFirma> createState() => _subirFirmaState();
}

class _subirFirmaState extends State<subirFirma> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: PrettyBorderButton(
        label: '  Ingresar Firma  ',
        onPressed: () => context.push('/firma'),
        labelStyle: const TextStyle(fontSize: 16),
        bgColor: const Color(0xffC4ACCD),
        borderColor: const Color(0xff6C3082),
        borderWidth: s2,
      ),
    );
  }
}
