

import 'package:fomulario_asistencia_cite/Providers/EventoProvider.dart';
import 'package:fomulario_asistencia_cite/Providers/EventoProviderId.dart';

import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditarEvento extends StatefulWidget {
  const EditarEvento({super.key});

  @override
  State<EditarEvento> createState() => _EditarEventoState();
}

class _EditarEventoState extends State<EditarEvento> {
  final supabase = Supabase.instance.client;

  //variables a moverse:

  final eventoStream =
      Supabase.instance.client.from('eventos').stream(primaryKey: ['id']);

  String nombre = '';
  String inicio = '';
  String finalizacion = '';
  String departamento = '';
  String provincia = '';
  String distrito = '';
  String firma = "";

  // jalar los valores del provider 
  



  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).extension<AppColors>();

    final indentificacion = context.watch<ProviderEventosId>().provId;


    final TextEditingController controllerInputNombreEvento = TextEditingController(text: )

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
                      Text(context
                          .watch<ProviderEventos>()
                          .provNombre
                          .toString()),
                      Text(
                        'Editar Datos del Evento',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: colores!.c1),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: TextField(
                            controller: controllerInputNombreEvento,
                            keyboardType: TextInputType.text,
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
                            Align(
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
                          label: '  Registrar Evento   ',
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
                            providerEventos.saveEventToSupabase(context);

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

  Future<void> updateParticipante(
    int participanteId,
    String updatedni,
    String updatenombre,
    String updatetelefono,
    String updatedireccion,
    String updateemail,
    String updateruc,
    String updatefirma,
  ) async {
    var telefono =
        updatetelefono.isNotEmpty ? int.tryParse(updatetelefono) : null;
    var ruc = updateruc.isNotEmpty ? int.tryParse(updateruc) : null;
    var dniverif = updatedni.isNotEmpty ? int.tryParse(updatedni) : null;
    await supabase.from("neoParticipantes").update({
      'DNI': dniverif,
      'nombre': updatenombre,
      'telefono': telefono,
      'direccion': updatedireccion,
      'correo': updateemail,
      'ruc': ruc,
      'firma': updatefirma,
    }).eq("id", participanteId);
  }
}
