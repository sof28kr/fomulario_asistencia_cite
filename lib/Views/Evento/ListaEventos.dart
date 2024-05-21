import 'package:fomulario_asistencia_cite/Providers/EventoProvider.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProviderId.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class listadoEventos extends StatefulWidget {
  const listadoEventos({super.key});

  @override
  State<listadoEventos> createState() => _listadoEventosState();
}

class _listadoEventosState extends State<listadoEventos> {
  //variables a moverse:
  final supabase = Supabase.instance.client;

  final eventosStream =
      Supabase.instance.client.from('eventos').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).extension<AppColors>();

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
                          // Obtener los eventos del snapshot
                          final eventos = snapshot.data!;
                          // Limitar a los últimos 10 eventos, o mostrar todos si hay menos de 10
                          final eventosLimitados = (eventos.length > 10)
                              ? eventos.sublist(eventos.length - 10)
                              : eventos;

                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: eventosLimitados.length,
                            itemBuilder: (context, index) {
                              final evento = eventosLimitados[index];

                              var idEvento = evento['id'];

                              var nombreEvento =
                                  evento['nombre'] ?? 'no hay nombre';
                              var servicioEvento =
                                  evento['servicio'] ?? 'no hay tipo';
                              var inicioEvento =
                                  evento['inicio'] ?? 'no hay fecha de inicio';
                              var finalizacionEvento = evento['finalizacion'] ??
                                  'no hay fecha de finalizacion';
                              var departamentoEvento = evento['departamento'] ??
                                  'no hay departamento registrado';
                              var provinciaEvento = evento['provincia'] ??
                                  'no hay provincia registrada';
                              var distritoEvento = evento['distrito'] ??
                                  'no hay distrito registrado';

                              return Card(
                                child: ListTile(
                                  tileColor: colores.c6,
                                  onTap: () {
                                    // hacer click en el listtile
                                  },
                                  title: Text(
                                      evento['nombre'] ?? 'No registro nombre'),
                                  subtitle: Text(evento['inicio'].toString() ??
                                      'No hay fecha de inicio'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.list_alt)),
                                      IconButton(
                                        onPressed: () {
                                          context.push('/editarEventos');
                                          idEvento = evento['id'];
                                          servicioEvento =
                                              evento['servicio'] ?? 'no hay';
                                          nombreEvento =
                                              evento['nombre'] ?? 'no hay';
                                          inicioEvento =
                                              evento['inicio'] ?? 'no hay';
                                          finalizacionEvento =
                                              evento['finalizacion'] ??
                                                  'no hay';
                                          departamentoEvento =
                                              evento['departamento'] ??
                                                  'no hay';
                                          provinciaEvento =
                                              evento['provincia'] ?? 'no hay';
                                          distritoEvento =
                                              evento['distrito'] ?? 'no hay';

                                          context
                                              .read<ProviderEventosId>()
                                              .changeProviderEventoId(
                                                newprovId: idEvento,
                                                newprovNombre: nombreEvento,
                                                newprovInicio: inicioEvento,
                                                newprovFinal:
                                                    finalizacionEvento,
                                                newprovDepartamento:
                                                    departamentoEvento,
                                                newprovDistrito: distritoEvento,
                                                newprovProvincia:
                                                    provinciaEvento,
                                                newprovServicio: servicioEvento,
                                              );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          // implementar metodo para eliminacion

                                          bool deleteConfirmed =
                                              await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Eliminar Registro del Evento'),
                                                content: const Text(
                                                    'Seguro que desea eliminar el registro del evento?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, false);
                                                    },
                                                    child:
                                                        const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context, true);
                                                    },
                                                    child: const Text(
                                                        'Eliminar Evento'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );

                                          if (deleteConfirmed) {
                                            await eliminarEvento(
                                                nombreEvento, idEvento);
                                          }
                                        },
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),

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

  Future<void> eliminarEvento(String nombreEvento, int idEvento) async {
    await supabase
        .from("eventos")
        .delete()
        .match({"nombre": nombreEvento, "id": idEvento});
  }
}
