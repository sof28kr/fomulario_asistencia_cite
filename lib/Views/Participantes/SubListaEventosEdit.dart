import 'package:fomulario_asistencia_cite/Providers/EventoProviderId.dart';
import 'package:fomulario_asistencia_cite/Providers/ProviderParticipanteId.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubListaEventosEdit extends StatefulWidget {
  const SubListaEventosEdit({super.key});

  @override
  State<SubListaEventosEdit> createState() => _SubListaEventosEditState();
}

class _SubListaEventosEditState extends State<SubListaEventosEdit> {
  //variables a moverse:
  final supabase = Supabase.instance.client;

  final participantesStream = Supabase.instance.client
      .from('neoParticipantes')
      .stream(primaryKey: ['id']);

  @override
  void initState() {
    super.initState();
    //traer el valor inicial
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).extension<AppColors>();
    String valor = context.read<ProviderEventosId>().provId.toString();

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
                      Text(
                        'Listado de Participantes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: colores!.c1),
                      ),
                      const SizedBox(
                        height: 50,
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      StreamBuilder<List<Map<String, dynamic>>>(
                          stream: participantesStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final Participantes = snapshot.data!;

                            final participantesConEventoSeleccionado =
                                Participantes.where((participante) =>
                                    participante['evento'] == valor).toList();

                            if (participantesConEventoSeleccionado.isEmpty) {
                              return Center(
                                child: Text(
                                  'Aun no hay participantes \nregistrados en este evento',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: colores.c1),
                                ),
                              );
                            }

                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    participantesConEventoSeleccionado.length,
                                itemBuilder: (context, index) {
                                  final participante =
                                      participantesConEventoSeleccionado[index];
                                  var participanteId = participante['id'];
                                  var participanteIdnombre =
                                      participante['nombre'] ?? 'no hay nombre';
                                  var participanteIdDNI =
                                      participante['DNI'] ?? 0;
                                  var participanteIdDireccion =
                                      participante['direccion'] ??
                                          'no hya direccion';
                                  var participanteIdTelefono =
                                      participante['telefono'] ?? 0;
                                  var participanteIdCorreo =
                                      participante['correo'] ?? 'no hay correo';
                                  var participanteIdRuc =
                                      participante['ruc'] ?? 0;
                                  var participanteIdFirma =
                                      participante['firma'] ?? 'no hay firma';

                                  return Card(
                                    child: ListTile(
                                      tileColor: colores.c6,
                                      onTap: () {
                                        // hacer click en el listtile
                                      },
                                      title: Text(participante['nombre'] ??
                                          'No registro nombre'),
                                      subtitle: Text(
                                          participante['DNI'].toString() ??
                                              'No registro Dni'),
                                      //trailing: Text(participante['created_at']
                                      //.toString() ??
                                      //'No hay fecha registrada'),

                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                context.push(
                                                    '/editarParticipantes');
                                                participanteId =
                                                    participante['id'];
                                                participanteIdnombre =
                                                    participante['nombre'] ??
                                                        'no hay';
                                                participanteIdDNI =
                                                    participante['DNI'] ?? 0;
                                                participanteIdDireccion =
                                                    participante['direccion'] ??
                                                        'no hay';
                                                participanteIdTelefono =
                                                    participante['telefono'] ??
                                                        0;
                                                participanteIdCorreo =
                                                    participante['correo'] ??
                                                        'no hay';
                                                participanteIdRuc =
                                                    participante['ruc'] ?? 0;
                                                participanteIdFirma =
                                                    participante['firma'] ??
                                                        'no hay';
                                                context
                                                    .read<
                                                        providerParticipanteId>()
                                                    .changeProvParticipanteId(
                                                        newprovParticipanteId:
                                                            participanteId,
                                                        newprovDNIid:
                                                            participanteIdDNI,
                                                        newprovnombreid:
                                                            participanteIdnombre,
                                                        newprovdireccionid:
                                                            participanteIdDireccion,
                                                        newprovcorreoid:
                                                            participanteIdCorreo,
                                                        newprovfirmaid:
                                                            participanteIdFirma,
                                                        newprovrucid:
                                                            participanteIdRuc,
                                                        newprovtelefonoid:
                                                            participanteIdTelefono);
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                              onPressed: () async {
                                                // implementar metodo para eliminacion

                                                bool deleteConfirmed =
                                                    await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Eliminar Registro del Participantes'),
                                                            content: const Text(
                                                                'Seguro que desea eliminar el registro del participante?'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        false);
                                                                  },
                                                                  child: const Text(
                                                                      'Cancelar')),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        true);
                                                                  },
                                                                  child: const Text(
                                                                      'Eliminar registro')),
                                                            ],
                                                          );
                                                        });
                                                if (deleteConfirmed) {
                                                  await eliminarParticipante(
                                                      participanteId);
                                                }
                                              },
                                              icon: const Icon(Icons.delete))
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),

                      const SizedBox(
                        height: 50,
                      ),

                      //_visualizarDatos(),
                      const SizedBox(
                        height: 50,
                      ),
                      PrettyBorderButton(
                        label: '  Nuevo Participante   ',
                        onPressed: () =>
                            context.push('/formularioParticipantes'),
                        labelStyle: const TextStyle(fontSize: 20),
                        bgColor: const Color(0xffC4ACCD),
                        borderColor: const Color(0xff6C3082),
                        borderWidth: s3,
                      ),
                      const SizedBox(
                        height: 50,
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

  Future<void> eliminarParticipante(
    int participanteId,
  ) async {
    await supabase.from("neoParticipantes").delete().eq("id", participanteId);
  }
}