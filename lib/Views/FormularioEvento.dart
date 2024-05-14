import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class FormularioEvento extends StatefulWidget {
  const FormularioEvento({super.key});

  @override
  State<FormularioEvento> createState() => _FormularioEventoState();
}

class _FormularioEventoState extends State<FormularioEvento> {
  final supabase = Supabase.instance.client;

  TextEditingController dateInput = TextEditingController();

  final TextEditingController controllerInputServicio = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  DateTime? _fechaSeleccionada;

  //variables controladoras 
  DateTime? selectedDate;
  DateTime _date = DateTime.now();
  var doa;

    datePicker() async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Application Date'.tr().toUpperCase(),
    );
    if (selectedDate != null && selectedDate != _date) {
      setState(() {
        _date = selectedDate!;
        doa = DateFormat('dd-MM-yyyy')
            .format(_date); //change date format on your need
        print(
          doa.toString(),
        );
      });
    }
  }

  @override
  void dispose() {
    controllerInputServicio.dispose();
    _fechaController.dispose();
    super.dispose();
  }

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
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const bannerPersonalizado(),
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
                          color: colores!.c1,
                        ),
                      ),
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
                            ),
                          ),
                        ),
                      ),

                      // Agrega el TextField con el DatePicker
                     
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Mi Texto',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text('Texto con borde'),
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
}
