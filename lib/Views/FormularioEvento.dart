import 'package:flutter/material.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormularioEvento extends StatefulWidget {
  const FormularioEvento({super.key});

  @override
  State<FormularioEvento> createState() => _FormularioEventoState();
}

class _FormularioEventoState extends State<FormularioEvento> {
  final supabase = Supabase.instance.client;

  final TextEditingController controllerInputServicio = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  DateTime? _fechaSeleccionada;

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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: GestureDetector(
                          onTap: () async {
                            final fechaSeleccionada = await showDatePicker(
                              context: context,
                              initialDate: _fechaSeleccionada ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );

                            if (fechaSeleccionada != null) {
                              setState(() {
                                _fechaSeleccionada = fechaSeleccionada;
                                _fechaController.text =
                                    _fechaSeleccionada.toString().split(' ')[0];
                              });
                            }
                          },
                          child: TextField(
                            controller: _fechaController,
                            enabled: false,
                            style: TextStyle(
                              color:
                                  Colors.blue, // Cambia el color de las letras
                            ),
                            decoration: InputDecoration(
                              hintText: 'Fecha del Evento',
                              labelText: 'Selecciona la fecha',
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color:
                                      Colors.red, // Cambia el color del borde
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Mi Texto',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text('Texto con borde'),
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
