import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fomulario_asistencia_cite/Custom_Widgets/DropDownUbicacion.dart';

import 'package:fomulario_asistencia_cite/Views/Views.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProvider.dart';

import 'package:intl/intl.dart';

class FormularioEvento extends StatefulWidget {
  const FormularioEvento({super.key});

  @override
  State<FormularioEvento> createState() => _FormularioEventoState();
}

class _FormularioEventoState extends State<FormularioEvento> {
  final supabase = Supabase.instance.client;

  TextEditingController dateInput = TextEditingController();

  final TextEditingController controllerInputNombreEvento =
      TextEditingController();
  final TextEditingController controllerInputServicio = TextEditingController();
  final TextEditingController controllerInputInicio = TextEditingController();
  final TextEditingController controllerInputCierre = TextEditingController();

  final TextEditingController _fechaController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _finalController = TextEditingController();
  final TextEditingController _departamentoController = TextEditingController();
  final TextEditingController _provinciaController = TextEditingController();
  final TextEditingController _distritoController = TextEditingController();

  //variables controladoras
  DateTime? selectedDate;
  DateTime _date = DateTime.now();
  var doa;
  late String dep;

  datePicker(titulo, TextEditingController controller) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: titulo.toUpperCase(),
    );
    if (selectedDate != null && selectedDate != _date) {
      setState(() {
        _date = selectedDate!;
        // doa es el string con la fecha
        doa = DateFormat('dd-MM-yyyy').format(_date);
        controller.text = doa;
      });
    }
    return doa;
  }

  @override
  void dispose() {
    controllerInputServicio.dispose();
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerEventos = Provider.of<ProviderEventos>(context);
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

                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Nombre'),
                        ),
                        TextField(
                          controller: _inicioController,
                          decoration:
                              InputDecoration(labelText: 'Fecha de Inicio'),
                        ),
                        TextField(
                          controller: _finalController,
                          decoration:
                              InputDecoration(labelText: 'Fecha de Final'),
                        ),
                        TextField(
                          controller: _departamentoController,
                          decoration:
                              InputDecoration(labelText: 'Departamento'),
                        ),
                        TextField(
                          controller: _provinciaController,
                          decoration: InputDecoration(labelText: 'Provincia'),
                        ),
                        TextField(
                          controller: _distritoController,
                          decoration: InputDecoration(labelText: 'Distrito'),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: TextField(
                            controller: controllerInputServicio,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Nombre del Evento',
                              labelText: 'Ingrese el nombre del evento',
                              suffixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
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
                          child: Column(
                            children: [
                              //alineacion incluso si mas arriba en el arbol hay un center
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("fecha de inicio",
                                      textAlign: TextAlign.left)),
                              TextFormField(
                                onTap: () {
                                  setState(() {
                                    datePicker(
                                        "Ingrese la fecha de inicio del evento",
                                        controllerInputInicio);
                                  });
                                },
                                controller: controllerInputInicio,
                                decoration: InputDecoration(
                                  hintText: doa,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  labelText: "fecha de inicio del evento",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("fecha de fin del evento",
                                    textAlign: TextAlign.left),
                              ),
                              TextFormField(
                                onTap: () {
                                  setState(() {
                                    datePicker(
                                        "Ingrese la fecha de fin del evento",
                                        controllerInputCierre);
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: (doa.toString()),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  labelText: "fecha de cierre",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),
                        DropdownExample(
                          onDepartmentChanged: (department) {
                            print('Departamento seleccionado: $department');
                          },
                          onProvinceChanged: (province) {
                            print('Provincia seleccionada: $province');
                          },
                          onDistrictChanged: (district) {
                            print('Distrito seleccionado: $district');
                          },
                        ),
                        const SizedBox(height: 50),

                        ElevatedButton(
                            onPressed: () {
                              context.push('/prueba');
                              ;
                            },
                            child: Text('prueba')),

                        PrettyBorderButton(
                          label: '  Registrar Participacion   ',
                          onPressed: () {
                            providerEventos.changeProvParticipanteId(
                              newprovNombre: _nameController.text,
                              newprovInicio: _inicioController.text,
                              newprovFinal: _finalController.text,
                              newprovDepartamento: _departamentoController.text,
                              newprovProvincia: _provinciaController.text,
                              newprovDistrito: _distritoController.text,
                            );
                            providerEventos.saveEventToSupabase(context);
                          },
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
                          labelStyle:
                              TextStyle(fontSize: 16, color: colores.c3),
                          onPressed: () {
                            context.push('/listaParticipantes');
                          },
                          secondSlideColor: colores.c1,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
