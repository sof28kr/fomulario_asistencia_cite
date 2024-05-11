import 'dart:convert';

import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:fomulario_asistencia_cite/Models/ProviderParticipanteId.dart';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormularioParticipantes extends StatefulWidget {
  const FormularioParticipantes({super.key});

  @override
  State<FormularioParticipantes> createState() =>
      _FormularioParticipantesState();
}

class _FormularioParticipantesState extends State<FormularioParticipantes> {
  final supabase = Supabase.instance.client;

  final participantesStream = Supabase.instance.client
      .from('neoParticipantes')
      .stream(primaryKey: ['id']);

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
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
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
                      Text(
                        'Ingreso de Datos del Participante',
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: PrettyBorderButton(
                          label: '  Autocompletar  ',
                          onPressed: () {
                            print('working till here');
                            context
                                .read<ProviderParticipantes>()
                                .setDni(controllerInputDni.text);

                            // fin de la funcion autocompletar
                          },
                          labelStyle: const TextStyle(fontSize: 16),
                          bgColor: Color(0xffC4ACCD),
                          borderColor: Color(0xff6C3082),
                          borderWidth: s5,
                        ),
                      ),
                      //funcion autocompletar
                      Consumer<ProviderParticipantes>(
                        builder: (context, ProviderParticipantes, child) {
                          return StreamBuilder<List<Map<String, dynamic>>>(
                            stream: participantesStream,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final Participantes = snapshot.data!;

                              String newDniaBuscar = ProviderParticipantes.dni;
                              // Filtra la lista de participantes para obtener solo el que coincida con newDniaBuscar
                              final participanteEncontrado =
                                  Participantes.firstWhere(
                                (participante) =>
                                    participante['DNI'] == newDniaBuscar,
                                orElse: () => {
                                  'id': 0,
                                  'nombre': '',
                                  'DNI': '',
                                  'direccion': '',
                                  'telefono': '',
                                  'correo': '',
                                  'ruc': '',
                                  'firma': '',
                                },
                              );

                              if (participanteEncontrado['id'] == 0 &&
                                  participanteEncontrado['nombre'] == '') {
                                // No se encontró ningún participante con el DNI buscado
                                return const Text(
                                    'No se encontraron resultados');
                              }

                              // Mostrar los datos del participante encontrado
                              return Column(
                                children: [
                                  Text('ID: ${participanteEncontrado['id']}'),
                                  Text(
                                      'Nombre: ${participanteEncontrado['nombre']}'),
                                  Text('DNI: ${participanteEncontrado['DNI']}'),
                                  Text(
                                      'Dirección: ${participanteEncontrado['direccion']}'),
                                  Text(
                                      'Teléfono: ${participanteEncontrado['telefono']}'),
                                  Text(
                                      'Correo: ${participanteEncontrado['correo']}'),
                                  Text('RUC: ${participanteEncontrado['ruc']}'),
                                  Text(
                                      'Firma: ${participanteEncontrado['firma']}'),
                                ],
                              );
                            },
                          );
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
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
                        label: '  Registrar Participacion   ',
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

  // metodo para hacer el fetch de la data buscada segun el Dni
}
