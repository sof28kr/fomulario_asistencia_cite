import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:fomulario_asistencia_cite/Models/ProviderParticipanteId.dart';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Views/EditarEvento.dart';
import 'package:fomulario_asistencia_cite/Views/EditarParticipantes.dart';
import 'package:fomulario_asistencia_cite/Views/FormularioEvento.dart';
import 'package:fomulario_asistencia_cite/Views/ListaEventos.dart';
import 'package:fomulario_asistencia_cite/Views/listaParticipantes.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderFirma()),
        ChangeNotifierProvider(create: (context) => ProviderParticipantes()),
        ChangeNotifierProvider(create: (context) => providerParticipanteId()),
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
