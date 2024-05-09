import 'dart:convert';

import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:fomulario_asistencia_cite/Models/ProviderParticipanteId.dart';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditarParticipantes extends StatefulWidget {
  const EditarParticipantes({super.key});

  @override
  State<EditarParticipantes> createState() => _EditarParticipantesState();
}

class _EditarParticipantesState extends State<EditarParticipantes> {
  final supabase = Supabase.instance.client;
  //variables a moverse:

  String nombre = '';
  String dni = '';
  String telefono = '';
  String direccion = '';
  String email = '';
  String RUC = '';
  String firma = "";

  final TextEditingController controllerInputDni = TextEditingController();
  final TextEditingController controllerInputNombre =
      TextEditingController(text: 'working on this');
  //inicializa el valor del controler
  // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputTelefono =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputDireccion =
      TextEditingController();
  final TextEditingController controllerInputEmail =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputRuc = TextEditingController();

  bool isBase64String(String str) {
    try {
      base64Decode(str);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).extension<AppColors>();
    // context es como un lago de valores en el modelo
    //value es un valor que podemos jalar
    //el tipo de consumer es segun el modelo que tenemos
    return Scaffold(
      //luego el scafold es que escucha y recive los cambios

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
                      Text(context
                          .watch<providerParticipanteId>()
                          .provParticipanteId
                          .toString()),
                      Text(
                        'Editar Datos del Participante',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: colores!.c1),
                      ),
                      // Cuerpo de los form fields
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputDni,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'DNI',
                              labelText: 'Ingrese su DNI',
                              suffixIcon: Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      autocompletar(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: controllerInputNombre,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Nombre Completo',
                              labelText: 'nombres y apellidos',
                              suffixIcon: Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputTelefono,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Telefono',
                              labelText: 'Telefono fijo o celular',
                              suffixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputDireccion,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Direccion',
                              labelText: 'La direccion de su residencia',
                              suffixIcon: Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputEmail,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Correo Electronico',
                              labelText: 'xyz@gmail.com',
                              suffixIcon: Icon(Icons.mail),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputRuc,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Ruc',
                              labelText: 'Ingrese el numero de su RUC',
                              suffixIcon: Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),

                      subirFirma(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: isBase64String(
                                context.watch<ProviderFirma>().firmaString)
                            ? Expanded(
                                child: AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.memory(
                                    base64Decode(context
                                        .watch<ProviderFirma>()
                                        .firmaString),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : Text(
                                'No hay firma disponible',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),

                      SizedBox(height: 50),

                      PrettyBorderButton(
                        label: '  Editar Participacion   ',
                        onPressed: () async {
                          final firmaString =
                              context.read<ProviderFirma>().firmaString;

                          context
                              .read<ProviderParticipantes>()
                              .changeParticipantes(
                                  newdni: controllerInputDni.text,
                                  newnombre: controllerInputNombre.text,
                                  newtelefono: controllerInputTelefono.text,
                                  newdireccion: controllerInputDireccion.text,
                                  newemail: controllerInputEmail.text,
                                  newRUC: controllerInputRuc.text);

                          int dniInt =
                              int.tryParse(controllerInputDni.text) ?? 0;
                          int telefonoInt =
                              int.tryParse(controllerInputTelefono.text) ?? 0;
                          int rucInt =
                              int.tryParse(controllerInputRuc.text) ?? 0;

                          await Supabase.instance.client
                              .from("neoParticipantes")
                              .insert({
                            'DNI': dniInt,
                            'nombre': controllerInputNombre.text,
                            'direccion': controllerInputDireccion.text,
                            'telefono': telefonoInt,
                            'correo': controllerInputEmail.text,
                            'ruc': rucInt,
                            'firma': context.read<ProviderFirma>().firmaString,
                          });

                          controllerInputDni.clear();
                          controllerInputNombre.clear();
                          controllerInputTelefono.clear();
                          controllerInputDireccion.clear();
                          controllerInputEmail.clear();
                          controllerInputRuc.clear();
                          context.read<ProviderFirma>().resetFirmaString();

                          context.push('/listaParticipantes');
                        },
                        labelStyle: const TextStyle(fontSize: 20),
                        bgColor: Color(0xffC4ACCD),
                        borderColor: Color(0xff6C3082),
                        borderWidth: s3,
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      PrettySlideUnderlineButton(
                        label: 'Ver Listado de Participantes',
                        labelStyle: TextStyle(fontSize: 16, color: colores.c3),
                        onPressed: () {
                          context.push('/listaParticipantes');
                        },
                        secondSlideColor: colores.c1,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
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

  Future<void> updateParticipante(
    String participanteId,
    String updatenombre,
    String updatetelefono,
    String updatedireccion,
    String updateemail,
    String updateruc,
    String updatefirma,
  ) async {
    await supabase.from("neoParticipantes").update({
      'nombre': updatenombre,
      'telefono': updatetelefono,
      'direccion': updatedireccion,
      'email': updateemail,
      'ruc': updateruc,
      'firma': updatefirma,
    }).eq("id", participanteId);
  }

  Future<void> eliminarParticipante(
    String participanteId,
  ) async {
    await supabase.from("neoParticipantes").delete().eq("id", participanteId);
  }
}