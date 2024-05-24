import 'dart:convert';

import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Providers/ProviderParticipanteId.dart';

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

  final participantesStream = Supabase.instance.client
      .from('neoParticipantes')
      .stream(primaryKey: ['id']);

  String nombre = '';
  String dni = '';
  String telefono = '';
  String direccion = '';
  String email = '';
  String RUC = '';
  String firma = "";

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
    final identificacion =
        context.watch<providerParticipanteId>().provParticipanteId;
    final identificacionDNI = context.watch<providerParticipanteId>().provDNIid;
    final identificacionnombre =
        context.watch<providerParticipanteId>().provnombreid;
    final identificaciontelefono =
        context.watch<providerParticipanteId>().provtelefonoid;
    final identificaciondireccion =
        context.watch<providerParticipanteId>().provdireccionid;
    final identificacioncorreo =
        context.watch<providerParticipanteId>().provcorreoid;
    final identificacionruc = context.watch<providerParticipanteId>().provrucid;

    // inicializando controladores

    final TextEditingController controllerInputDni =
        TextEditingController(text: identificacionDNI.toString());
    final TextEditingController controllerInputNombre =
        TextEditingController(text: identificacionnombre);
    final TextEditingController controllerInputTelefono = TextEditingController(
        text: identificaciontelefono
            .toString()); // Controlador asociado a texto Email donde se escribe
    final TextEditingController controllerInputDireccion =
        TextEditingController(text: identificaciondireccion);
    final TextEditingController controllerInputEmail = TextEditingController(
        text:
            identificacioncorreo); // Controlador asociado a texto Email donde se escribe
    final TextEditingController controllerInputRuc =
        TextEditingController(text: identificacionruc.toString());

    final colores = Theme.of(context).extension<AppColors>();
    var indexParticipante =
        context.watch<providerParticipanteId>().provParticipanteId;
    // context es como un lago de valores en el modelo
    //value es un valor que podemos jalar
    //el tipo de consumer es segun el modelo que tenemos
    //en este caos el consumer esta como <providerParticipanteId>
    return Scaffold(
      //luego el scafold es que escucha y recive los cambios

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
            child: Column(
              children: [
                const bannerPersonalizado(),
                //textxfields del formulario
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Editar Datos del Participante',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: colores!.c1),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputDni,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'DNI',
                              labelText: 'Ingrese su DNI',
                              suffixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextFormField(
                          controller: controllerInputNombre,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Nombre Completo',
                              labelText: 'nombres y apellidos',
                              suffixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputTelefono,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Telefono',
                              labelText: 'Telefono fijo o celular',
                              suffixIcon: const Icon(Icons.phone),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputDireccion,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Direccion',
                              labelText: 'La direccion de su residencia',
                              suffixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputEmail,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Correo Electronico',
                              labelText: 'xyz@gmail.com',
                              suffixIcon: const Icon(Icons.mail),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputRuc,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Ruc',
                              labelText: 'Ingrese el numero de su RUC',
                              suffixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      const subirFirma(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: isBase64String(context
                                .watch<providerParticipanteId>()
                                .provfirmaid)
                            ? Expanded(
                                child: AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.memory(
                                    base64Decode(context
                                        .watch<providerParticipanteId>()
                                        .provfirmaid),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : const Text(
                                'No hay firma disponible',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                      const SizedBox(height: 50),
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

                          await updateParticipante(
                            indexParticipante,
                            controllerInputDni.text,
                            controllerInputNombre.text,
                            controllerInputTelefono.text,
                            controllerInputDireccion.text,
                            controllerInputEmail.text,
                            controllerInputRuc.text,
                            context.read<ProviderFirma>().firmaString,
                          );

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
                        bgColor: const Color(0xffC4ACCD),
                        borderColor: const Color(0xff6C3082),
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
    int participanteId,
    String updatedni,
    String updatenombre,
    String updatetelefono,
    String updatedireccion,
    String updateemail,
    String updateruc,
    String updatefirma,
  ) async {
    var telefono =
        updatetelefono.isNotEmpty ? int.tryParse(updatetelefono) : null;
    var ruc = updateruc.isNotEmpty ? int.tryParse(updateruc) : null;
    var dniverif = updatedni.isNotEmpty ? int.tryParse(updatedni) : null;
    await supabase.from("neoParticipantes").update({
      'DNI': dniverif,
      'nombre': updatenombre,
      'telefono': telefono,
      'direccion': updatedireccion,
      'correo': updateemail,
      'ruc': ruc,
      'firma': updatefirma,
    }).eq("id", participanteId);
  }
}
