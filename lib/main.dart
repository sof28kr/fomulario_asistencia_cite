import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:provider/provider.dart';
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
    create: (context) => ParticipantesModelo(),
    //para que el modelo escuche los cambios
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(initialLocation: '/inicio', routes: [
        GoRoute(path: '/add', builder: (context, state) => formulario1()),
        GoRoute(
          path: '/inicio',
          builder: (context, state) => Welcome(),
        ),
        GoRoute(
          path: '/f2',
          builder: (context, state) => FormularioParticipantes(),
        ),
        GoRoute(
          path: '/firma',
          builder: (context, state) => IngresoFirma(),
        ),
        GoRoute(
          path: '/ListadoParticipantes',
          builder: (context, state) => MyHomePage(title: 'Lista Participantes'),
        ),
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
    );
  }
}
