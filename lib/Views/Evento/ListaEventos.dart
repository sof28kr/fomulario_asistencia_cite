import 'package:fomulario_asistencia_cite/Providers/ProviderParticipanteId.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProvider.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fomulario_asistencia_cite/Conexion/supabaseEvento.dart';

class listadoEventos extends StatefulWidget {
  const listadoEventos({super.key});

  @override
  State<listadoEventos> createState() => _listadoEventosState();
}

class _listadoEventosState extends State<listadoEventos> {
  //variables a moverse:
  final supabase = Supabase.instance.client;

  final participantesStream = Supabase.instance.client
      .from('neoParticipantes')
      .stream(primaryKey: ['id']);

  final eventosStream =
      Supabase.instance.client.from('eventos').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).extension<AppColors>();
    final providerEventos = Provider.of<ProviderEventos>(context);

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
                        'Listado de Eventos',
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

                      StreamBuilder<List<Map<String, dynamic>>>(
                          stream: eventosStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final Eventos = snapshot.data!;

                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: Eventos.length,
                                itemBuilder: (context, index) {
                                  final evento = Eventos[index];

                                  var nombreEvento =
                                      evento['nombre'] ?? 'no hay nombre';
                                  var inicioEvento = evento['inicio'] ??
                                      'no hay fecha de inicio';
                                  var finalizacionEvento = evento[
                                      'finalizacion' ??
                                          'no hay fecha de finalizacion'];
                                  var departamentoEvento = evento[
                                      'departamento' ??
                                          'no hay departamento registrado'];
                                  var provinciaEvento = evento['provincia' ??
                                      'no hay provincia registrada'];
                                  var distritoEvento = evento['distrito' ??
                                      'no hay distrito registrado'];

                                  return Card(
                                    child: ListTile(
                                      tileColor: colores.c6,
                                      onTap: () {
                                        // hacer click en el listtile
                                      },
                                      title: Text(evento['nombre'] ??
                                          'No registro nombre'),
                                      subtitle: Text(
                                          evento['inicio'].toString() ??
                                              'No hay fecha de inicio'),
                                      //trailing: Text(participante['created_at']
                                      //.toString() ??
                                      //'No hay fecha registrada'),

                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                context.push(
                                                    '/editarParticipantes');

                                                nombreEvento = evento['nombre'];
                                                inicioEvento = evento['inicio'];
                                                finalizacionEvento =
                                                    evento['finalizacion'];
                                                departamentoEvento =
                                                    evento['departamento'];
                                                provinciaEvento =
                                                    evento['provincia'];
                                                distritoEvento =
                                                    evento['distrito'];

                                                await providerEventos
                                                    .fetchEventByName(
                                                        nombreEvento, context);
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
                                                  await eliminarEvento(
                                                      nombreEvento);
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
                        label: '  Nuevo Evento   ',
                        onPressed: () => context.push('/formularioEventos'),
                        labelStyle: const TextStyle(fontSize: 20),
                        bgColor: const Color(0xffC4ACCD),
                        borderColor: const Color(0xff6C3082),
                        borderWidth: s3,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await providerEventos.fetchEventByName(
                              'primer', context);
                        },
                        child: Text('Buscar Evento'),
                      ),
                      SizedBox(height: 20),

                      Text('Nombre: ${providerEventos.provNombre}'),
                      Text('Inicio: ${providerEventos.provInicio}'),
                      Text('Final: ${providerEventos.provFinal}'),
                      Text('Departamento: ${providerEventos.provDepartamento}'),
                      Text('Provincia: ${providerEventos.provProvincia}'),
                      Text('Distrito: ${providerEventos.provDistrito}'),

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

  Future<void> eliminarEvento(
    String nombreEvento,
  ) async {
    await supabase.from("eventos").delete().eq("nombre", nombreEvento);
  }
}
