import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';

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
                      SizedBox(
                        height: 50,
                      ),
                      _visualizarDatos(),
                      SizedBox(
                        height: 50,
                      ),
                      PrettyBorderButton(
                        label: '  Nuevo Participante   ',
                        onPressed: () =>
                            context.push('/formularioParticipantes'),
                        labelStyle: const TextStyle(fontSize: 20),
                        bgColor: Color(0xffC4ACCD),
                        borderColor: Color(0xff6C3082),
                        borderWidth: s3,
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

  Widget _visualizarDatos() {
    return Column(
      children: [
        Text('visualizando'),
        Text(context.watch<ProviderParticipantes>().dni),
        Text(context.watch<ProviderParticipantes>().nombre),
        Text(context.watch<ProviderParticipantes>().telefono),
        Text(context.watch<ProviderParticipantes>().direccion),
        Text(context.watch<ProviderParticipantes>().email),
        Text(context.watch<ProviderParticipantes>().RUC),
        Text(context.watch<ProviderFirma>().firmaString),

        // mostrar la firma obtenida
      ],
    );
  }
}
