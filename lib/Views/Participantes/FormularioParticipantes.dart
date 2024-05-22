import 'dart:convert';

import 'package:fomulario_asistencia_cite/Models/ParticipantesModelo.dart';
import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';

import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FormularioParticipantes extends StatefulWidget {
  const FormularioParticipantes({super.key});

  @override
  State<FormularioParticipantes> createState() =>
      _FormularioParticipantesState();
}

class _FormularioParticipantesState extends State<FormularioParticipantes> {
  final supabase = Supabase.instance.client;
  String firmaSearch = '';
  //variable para el dropdown eventos
  List<Map<String, dynamic>> options = [];
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    fetchOptions();
  }

  Future<void> fetchOptions() async {
    try {
      final response = await supabase
          .from('eventos')
          .select('id, nombre')
          .order('created_at', ascending: false)
          .limit(10);

      final data = response as List<Map<String, dynamic>>;
      setState(() {
        options = data;
        if (options.isNotEmpty) {
          selectedOption = options.first['id'].toString();
        }
      });
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  //variables a moverse:

  final TextEditingController controllerInputDni = TextEditingController();
  final TextEditingController controllerInputNombre =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputTelefono =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputDireccion =
      TextEditingController();
  final TextEditingController controllerInputEmail =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputRuc = TextEditingController();

  bool isBase64String(String str) {
    try {
      base64Decode(str);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    controllerInputDni.dispose();
    super.dispose();
  }

  Future<void> getInitialInfo(userdniSearch) async {
    final data = await supabase
        .from('db')
        .select()
        .eq('dni', userdniSearch)
        .maybeSingle()
        .limit(1);

    if (data == null) {
      // Mostrar diálogo si no se encontraron datos
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('No se encontraron datos'),
          content:
              Text('No se encontraron registros para el DNI $userdniSearch'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
      setState(() {
        controllerInputNombre.text = '';
        controllerInputDireccion.text = '';
        controllerInputTelefono.text = '';
        controllerInputEmail.text = '';

        firmaSearch = '';
      });
    } else {
      setState(() {
        controllerInputNombre.text = data['nombre'];
        controllerInputDireccion.text = data['direccion'];
        controllerInputTelefono.text = data['telefono'].toString();
        controllerInputEmail.text = data['correo'];
      });
    }
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

                Center(
                  child: options.isEmpty
                      ? CircularProgressIndicator()
                      : DropdownButton<String>(
                          hint: Text('Select an option'),
                          value: selectedOption,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedOption = newValue;
                            });
                            print('Selected ID: $newValue');
                          },
                          items: options.map((option) {
                            return DropdownMenuItem<String>(
                              value: option['id'].toString(),
                              child: Text(option['nombre']),
                            );
                          }).toList(),
                        ),
                ),

                //textxfields del formulario
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ingreso de Datos del Participante',
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
                          controller: controllerInputDni,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'DNI',
                              labelText: 'Ingrese su DNI',
                              suffixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: PrettyBorderButton(
                          label: '  Autocompletar  ',
                          onPressed: () {
                            final userdniSearch = controllerInputDni.text;
                            getInitialInfo(userdniSearch);
                            // fin de la funcion autocompletar
                          },
                          labelStyle: const TextStyle(fontSize: 16),
                          bgColor: const Color(0xffC4ACCD),
                          borderColor: const Color(0xff6C3082),
                          borderWidth: s5,
                        ),
                      ),
                      //funcion autocompletar

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: ValueListenableBuilder<TextEditingValue>(
                            valueListenable: controllerInputNombre,
                            builder: (context, value, child) {
                              return TextField(
                                controller: controllerInputNombre,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintText: 'Nombre Completo',
                                    labelText: 'nombres y apellidos',
                                    suffixIcon: const Icon(Icons.badge),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    )),
                              );
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: controllerInputTelefono,
                          builder: (context, value, child) {
                            return TextField(
                              controller: controllerInputTelefono,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Telefono',
                                  labelText: 'Telefono fijo o celular',
                                  suffixIcon: const Icon(Icons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ValueListenableBuilder(
                          valueListenable: controllerInputDireccion,
                          builder: (constant, value, child) {
                            return TextField(
                              controller: controllerInputDireccion,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: 'Direccion',
                                  labelText: 'La direccion de su residencia',
                                  suffixIcon: const Icon(Icons.badge),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ValueListenableBuilder(
                            valueListenable: controllerInputEmail,
                            builder: (context, value, child) {
                              return TextField(
                                controller: controllerInputEmail,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintText: 'Correo Electronico',
                                    labelText: 'xyz@gmail.com',
                                    suffixIcon: const Icon(Icons.mail),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    )),
                              );
                            }),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: ValueListenableBuilder(
                          valueListenable: controllerInputRuc,
                          builder: (context, value, child) {
                            return TextField(
                              controller: controllerInputRuc,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Ruc',
                                  labelText: 'Ingrese el numero de su RUC',
                                  suffixIcon: const Icon(Icons.badge),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  )),
                            );
                          },
                        ),
                      ),

                      const subirFirma(),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: isBase64String(
                                context.watch<ProviderFirma>().firmaString)
                            ? Expanded(
                                child: AspectRatio(
                                  aspectRatio: 2,
                                  child: Image.memory(
                                    base64Decode(context
                                        .watch<ProviderFirma>()
                                        .firmaString),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            : const Text(
                                'No hay firma disponible',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),

                      const SizedBox(height: 50),

                      PrettyBorderButton(
                        label: '  Registrar Participacion   ',
                        onPressed: () async {
                          final firmaString =
                              context.read<ProviderFirma>().firmaString;

                          context
                              .read<ProviderParticipantes>()
                              .changeParticipantes(
                                  newdni: controllerInputDni.text,
                                  newnombre: controllerInputNombre.text,
                                  newtelefono: controllerInputTelefono.text,
                                  newdireccion: controllerInputDireccion.text,
                                  newemail: controllerInputEmail.text,
                                  newRUC: controllerInputRuc.text);

                          int dniInt =
                              int.tryParse(controllerInputDni.text) ?? 0;
                          int telefonoInt =
                              int.tryParse(controllerInputTelefono.text) ?? 0;
                          int rucInt =
                              int.tryParse(controllerInputRuc.text) ?? 0;

                          await Supabase.instance.client
                              .from("neoParticipantes")
                              .insert({
                            'DNI': dniInt,
                            'nombre': controllerInputNombre.text,
                            'direccion': controllerInputDireccion.text,
                            'telefono': telefonoInt,
                            'correo': controllerInputEmail.text,
                            'ruc': rucInt,
                            'firma': context.read<ProviderFirma>().firmaString,
                            'evento': selectedOption.toString(),
                          });

                          controllerInputDni.clear();
                          controllerInputNombre.clear();
                          controllerInputTelefono.clear();
                          controllerInputDireccion.clear();
                          controllerInputEmail.clear();
                          controllerInputRuc.clear();
                          context.read<ProviderFirma>().resetFirmaString();

                          context.push('/listaParticipantes');
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
