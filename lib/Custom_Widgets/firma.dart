import 'dart:convert';

import 'dart:typed_data';
import 'dart:ui';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';

Uint8List? imagenuit;

class IngresoFirma extends StatelessWidget {
  IngresoFirma({super.key});
  final keySignaturePad = GlobalKey<SfSignaturePadState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xffC4ACCD),
              Color(0xffF0EAF3),
            ],
          )),
          child: SingleChildScrollView(
              child: Column(children: [
            const bannerPersonalizado(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Ingrese su firma',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 28,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2A3439)),
                ),
                const SizedBox(
                  height: 50,
                ),
                SfSignaturePad(
                  key: keySignaturePad,
                  backgroundColor: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    PrettyBorderButton(
                      label: 'Guardar',
                      onPressed: () {
                        onSubmit(context);
                        Navigator.pop(context);
                      },
                      labelStyle: const TextStyle(fontSize: 15),
                      bgColor: Colors.yellow.withOpacity(0.2),
                      borderColor: const Color(0xff6C3082),
                      borderWidth: s2,
                    ),
                    PrettyBorderButton(
                      label: 'Borrar',
                      onPressed: () {
                        onClear();
                      },
                      labelStyle: const TextStyle(fontSize: 15),
                      bgColor: Colors.red.withOpacity(0.2),
                      borderColor: const Color(0xff6C3082),
                      borderWidth: s2,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ]))),
    ));
  }

  void onClear() {
    keySignaturePad.currentState?.clear(); // Borrar la firma actual
    // Restablecer la variable imageSignature a null si es necesario
  }

  Future<void> onSubmit(BuildContext context) async {
    try {
      final image =
          await keySignaturePad.currentState!.toImage(); // tipo imagen
      final imageSignature = await image.toByteData(
          format: ImageByteFormat.png); //tipo datos en formato png

      if (imageSignature != null) {
        Uint8List imagenuit = imageSignature.buffer.asUint8List();
        String base64Image = base64Encode(imagenuit);
        print('Imagen codificada en base64: $base64Image');

        context
            .read<ProviderFirma>()
            .ChangeFirmaString(newFirmaString: base64Image);

        base64Image = "";

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                const FormularioParticipantes()));

        // 'uint8List' contiene los bytes de la imagen
      } else {
        // Maneja el caso en que 'byteData' sea nulo
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('La firma no fue ingresada'),
          duration: Duration(seconds: 1),
        ));
        print("La variable ByteData es nula.");
      }

      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Firma guardada correctamente!'),
          duration:
              Duration(seconds: 2), // Ajusta la duración según tu preferencia
        ),
      ); // Close the dialog
    } catch (error) {
      // Handle any errors that occur during the asynchronous operations
      print('Error: $error');
      // Optionally show an error message to the user
    }
  }
}
