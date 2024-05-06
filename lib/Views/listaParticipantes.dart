import 'dart:convert';

import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:fomulario_asistencia_cite/Custom_Widgets/firma.dart';

class listadoParticipantes extends StatefulWidget {
  const listadoParticipantes({super.key});

  @override
  State<listadoParticipantes> createState() => _listadoParticipantesState();
}

class _listadoParticipantesState extends State<listadoParticipantes> {
  //variables a moverse:

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).extension<AppColors>();

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xffC4ACCD),
              Color(0xffF0EAF3),
            ],
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                bannerPersonalizado(),
                //textxfields del formulario
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Listado de Participantes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: colores!.c1),
                      ),
                      // Cuerpo de los form fields
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
