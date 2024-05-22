import 'package:fomulario_asistencia_cite/Conexion/supabaseEvento.dart';
import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProviderId.dart';
import 'package:fomulario_asistencia_cite/Providers/ProviderParticipanteId.dart';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProvider.dart';
import 'package:fomulario_asistencia_cite/Views/Evento/EditarEvento.dart';
import 'package:fomulario_asistencia_cite/Views/Evento/EditarEvento2.dart';
import 'package:fomulario_asistencia_cite/Views/Evento/ListaPartiEventos.dart';
import 'package:fomulario_asistencia_cite/Views/Participantes/EditarParticipantes.dart';
import 'package:fomulario_asistencia_cite/Views/Evento/FormularioEvento.dart';
import 'package:fomulario_asistencia_cite/Views/Evento/ListaEventos.dart';
import 'package:fomulario_asistencia_cite/Views/Participantes/listaParticipantes.dart';
import 'package:fomulario_asistencia_cite/Views/Participantes/prueba.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabaseService = SupabaseService(
    'https://oicgtegeayqbqvzoousx.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9pY2d0ZWdlYXlxYnF2em9vdXN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM4MTUyNTYsImV4cCI6MjAyOTM5MTI1Nn0.fyhjKUZqSBNuVWZNg5aXQUtH07I6iG-PWQKQrEiphPM',
  );
  await Supabase.initialize(
    url: 'https://oicgtegeayqbqvzoousx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9pY2d0ZWdlYXlxYnF2em9vdXN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM4MTUyNTYsImV4cCI6MjAyOTM5MTI1Nn0.fyhjKUZqSBNuVWZNg5aXQUtH07I6iG-PWQKQrEiphPM',
  );
  runApp(ChangeNotifierProvider(
    create: (context) => ProviderFirma(),
    //para que el modelo escuche los cambios
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final supabaseService = SupabaseService(
      'https://oicgtegeayqbqvzoousx.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9pY2d0ZWdlYXlxYnF2em9vdXN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM4MTUyNTYsImV4cCI6MjAyOTM5MTI1Nn0.fyhjKUZqSBNuVWZNg5aXQUtH07I6iG-PWQKQrEiphPM',
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderFirma()),
        ChangeNotifierProvider(create: (context) => ProviderParticipantes()),
        ChangeNotifierProvider(create: (context) => providerParticipanteId()),
        ChangeNotifierProvider(
            create: (context) =>
                ProviderEventos(supabaseService: supabaseService)),
        ChangeNotifierProvider(
            create: (context) =>
                ProviderEventosId(supabaseService: supabaseService))
      ],
      child: MaterialApp.router(
        routerConfig: GoRouter(initialLocation: '/inicio', routes: [
          GoRoute(
            path: '/inicio',
            builder: (context, state) => const Welcome(),
          ),

          //rutas participante

          GoRoute(
            path: '/formularioParticipantes',
            builder: (context, state) => const FormularioParticipantes(),
          ),
          GoRoute(
            path: '/firma',
            builder: (context, state) => IngresoFirma(),
          ),
          GoRoute(
              path: '/listaParticipantes',
              builder: (context, state) => const listadoParticipantes()),
          GoRoute(
              path: '/editarParticipantes',
              builder: (context, state) => const EditarParticipantes()),

          //rutas evento

          GoRoute(
              path: '/formularioEventos',
              builder: (context, state) => const FormularioEvento()),
          GoRoute(
              path: '/listaEventos',
              builder: (context, state) => const listadoEventos()),
          GoRoute(
              path: '/editarEventos',
              builder: (context, state) => const EditarEvento()),
          GoRoute(
              path: '/editarEventos2',
              builder: (context, state) => const EditarEvento2()),
          GoRoute(
              path: '/listaFiltrada',
              builder: (context, state) => const ListaPartiEventos()),
          GoRoute(path: '/prueba', builder: (context, state) => prueba()),
        ]),
        title: 'Flutter Demo',
        theme: ThemeData(extensions: const [
          AppColors(
            c1: Color(0xff2A3439),
            c2: Color(0xffCBA135),
            c3: Color(0xff6C3082),
            c4: Color(0xff89599B),
            c5: Color(0xffA783B4),
            c6: Color(0xffC4ACCD),
            c7: Color(0xffE2D6E6),
            c8: Color(0xffF0EAF3),
          )
        ], useMaterial3: true, fontFamily: 'Lato'),
      ),
    );
  }
}
