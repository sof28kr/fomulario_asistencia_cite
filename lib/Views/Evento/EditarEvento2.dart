import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fomulario_asistencia_cite/Custom_Widgets/DropDownUbicacion.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProviderId.dart';

import 'package:fomulario_asistencia_cite/Views/Views.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProvider.dart';

class EditarEvento2 extends StatefulWidget {
  const EditarEvento2({super.key});

  @override
  State<EditarEvento2> createState() => _EditarEvento2State();
}

class _EditarEvento2State extends State<EditarEvento2> {

  final TextEditingController controllerInputNombreEvento =
      TextEditingController();
  final TextEditingController controllerInputServicio = TextEditingController();
  final TextEditingController controllerInputInicio = TextEditingController();
  final TextEditingController controllerInputCierre = TextEditingController();

  String selectedDepartment = '';
  String selectedProvince = '';
  String selectedDistrict = '';

  final TextEditingController _fechaController = TextEditingController();

  //variables controladoras
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;

  Future<void> datePicker(
      String title, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();
    if (controller == controllerInputCierre && selectedStartDate != null) {
      initialDate = selectedStartDate!;
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: (controller == controllerInputInicio)
          ? DateTime.now()
          : selectedStartDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (controller == controllerInputInicio) {
        if (pickedDate
            .isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
          setState(() {
            selectedStartDate = pickedDate;
            controller.text = pickedDate.toLocal().toString().split(' ')[0];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('La fecha de inicio debe ser hoy o posterior.')),
          );
        }
      } else if (controller == controllerInputCierre) {
        if (selectedStartDate != null) {
          if (pickedDate.isAtSameMomentAs(selectedStartDate!) ||
              pickedDate.isAfter(selectedStartDate!)) {
            setState(() {
              selectedEndDate = pickedDate;
              controller.text = pickedDate.toLocal().toString().split(' ')[0];
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'La fecha de fin debe ser el mismo día o después de la fecha de inicio.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Debe seleccionar la fecha de inicio primero.')),
          );
        }
      }
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
    final providerEventos = Provider.of<ProviderEventos>(context);
    final colores = Theme.of(context).extension<AppColors>();
    var indexEvento = context.watch<ProviderEventosId>().provId;

    final nombreEvento = context.watch<ProviderEventosId>().provNombre;
    

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
                          nombreEvento,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: colores!.c1,
                          ),
                        ),

                        SizedBox(height: 50,),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: TextField(
                            controller: controllerInputNombreEvento,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Nombre del Evento',
                              labelText: nombreEvento,
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
                            keyboardType: TextInputType.text,
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
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Fecha de inicio",
                                    textAlign: TextAlign.left),
                              ),
                              TextFormField(
                                onTap: () async {
                                  await datePicker(
                                      "Ingrese la fecha de inicio del evento",
                                      controllerInputInicio);
                                },
                                controller: controllerInputInicio,
                                decoration: InputDecoration(
                                  hintText: 'Seleccionar fecha de inicio',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  labelText: "Fecha de inicio del evento",
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
                                child: Text("Fecha de fin del evento",
                                    textAlign: TextAlign.left),
                              ),
                              TextFormField(
                                onTap: () async {
                                  await datePicker(
                                      "Ingrese la fecha de fin del evento",
                                      controllerInputCierre);
                                },
                                controller: controllerInputCierre,
                                decoration: InputDecoration(
                                  hintText: 'Seleccionar fecha de fin',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  labelText: "Fecha de cierre",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text('Ubicacion del evento',
                                  textAlign: TextAlign.left),
                            ),
                            DropdownExample(
                              onDepartmentChanged: (department) {
                                setState(() {
                                  selectedDepartment = department!;
                                });
                              },
                              onProvinceChanged: (province) {
                                setState(() {
                                  selectedProvince = province!;
                                });
                              },
                              onDistrictChanged: (district) {
                                setState(() {
                                  selectedDistrict = district!;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),

                        PrettyBorderButton(
                          label: '  Editar Evento   ',
                          onPressed: () {
                            providerEventos.changeProviderEvento(
                              newprovServicio: controllerInputServicio.text,
                              newprovNombre: controllerInputNombreEvento.text,
                              newprovInicio: controllerInputInicio.text,
                              newprovFinal: controllerInputCierre.text,
                              newprovDepartamento: selectedDepartment,
                              newprovProvincia: selectedProvince,
                              newprovDistrito: selectedDistrict,
                            );
                            context.push('/listaEventos');

                            providerEventos.updateEventInSupabase(context, indexEvento );

                            controllerInputNombreEvento.clear();
                            controllerInputInicio.clear();
                            controllerInputCierre.clear();
                            selectedDepartment = '';
                            selectedProvince = '';
                            selectedDistrict = '';
                            controllerInputServicio.clear();
                          },
                          labelStyle: const TextStyle(fontSize: 20),
                          bgColor: const Color(0xffC4ACCD),
                          borderColor: const Color(0xff6C3082),
                          borderWidth: s3,
                        ),
                        const SizedBox(
                          height: 50,
                        ),

                        PrettySlideUnderlineButton(
                          label: 'Ver Listado de Eventos',
                          labelStyle:
                              TextStyle(fontSize: 16, color: colores.c3),
                          onPressed: () {
                            context.push('/listaEventos');
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
