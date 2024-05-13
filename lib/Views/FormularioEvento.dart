import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormularioEvento extends StatefulWidget {
  const FormularioEvento({super.key});

  @override
  State<FormularioEvento> createState() => _FormularioEventoState();
}

class _FormularioEventoState extends State<FormularioEvento> {
  final supabase = Supabase.instance.client;
  DateTime selectedDate = DateTime.now();
  String dateString = '';

  final TextEditingController controllerInputServicio = TextEditingController();
  late TextEditingController controllerInputFechaInicio;

  @override
  void initState() {
    super.initState();
    dateString =
        "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}";
    controllerInputFechaInicio = TextEditingController(text: dateString);
  }

  @override
  void dispose() {
    controllerInputServicio.dispose();
    super.dispose();
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
                        'Ingreso de Datos del Evento',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: colores!.c1),
                      ),
                      // Cuerpo de los form fields
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputServicio,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Tipo de Servicio',
                              labelText: 'Ingrese el tipo de servicio',
                              suffixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputFechaInicio,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              hintText: 'Fecha de Inicio',
                              labelText: 'Inicio del evento',
                              suffixIcon: const Icon(Icons.data_array),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),

                          // https://www.youtube.com/watch?v=ntwS8G-LWFU
                        ),
                      ),

                      const SizedBox(height: 50),

                      PrettyBorderButton(
                        label: '  Registrar Participacion   ',
                        onPressed: () async {},
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

  // metodo para hacer el fetch de la data buscada segun el Dni
}
