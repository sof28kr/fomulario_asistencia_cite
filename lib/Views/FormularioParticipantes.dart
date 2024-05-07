import 'dart:convert';

import 'package:fomulario_asistencia_cite/Models/ProvidersFirma.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';
import 'package:fomulario_asistencia_cite/Custom_Widgets/firma.dart';

class FormularioParticipantes extends StatefulWidget {
  const FormularioParticipantes({super.key});

  @override
  State<FormularioParticipantes> createState() =>
      _FormularioParticipantesState();
}

class _FormularioParticipantesState extends State<FormularioParticipantes> {
  //variables a moverse:

  String nombre = '';
  String dni = '';
  String telefono = '';
  String direccion = '';
  String email = '';
  String password = '';
  String RUC = '';
  String firma = "";

  final TextEditingController controllerInputNombre =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputDni = TextEditingController();
  final TextEditingController controllerInputTelefono =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputDireccion =
      TextEditingController();
  final TextEditingController controllerInputEmail =
      TextEditingController(); // Controlador asociado a texto Email donde se escribe
  final TextEditingController controllerInputPassword = TextEditingController();
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xffC4ACCD),
              Color(0xffF0EAF3),
            ],
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                bannerPersonalizado(),
                //textxfields del formulario
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
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
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          controller: controllerInputDni,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'DNI',
                              labelText: 'Ingrese su DNI',
                              suffixIcon: Icon(Icons.badge),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )),
                        ),
                      ),

                      autocompletar(),
                      //  aun por implementar

                      crearFormField('Nombre Completo', 'nombres y apellidos',
                          Icon(Icons.person)),
                      crearFormField('Direccion',
                          'La direccion de su residencia', Icon(Icons.badge)),
                      crearFormField('Telefono', 'Telefono fijo o celular',
                          Icon(Icons.phone)),
                      crearFormField('Correo Electronico', 'xyz@gmail.com',
                          Icon(Icons.mail)),
                      crearFormField('Ruc', 'Ingrese el numero de su RUC',
                          Icon(Icons.badge)),
                      subirFirma(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
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
                            : Text(
                                'No hay firma disponible',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),

                      SizedBox(height: 50),
                      PrettyBorderButton(
                        label: '  Registrar Participacion   ',
                        onPressed: () {
                          context.push('/ListadoParticipantes');

                          //obtencion de valores

                          print('El nombre es:${controllerInputNombre.text}');
                          print('El DNI es:${controllerInputDni.text}');
                          print(
                              'El Telefono es:${controllerInputTelefono.text}');
                          print(
                              'La direccion es:${controllerInputDireccion.text}');
                          print('El correo es:${controllerInputEmail.text}');
                          print('El ruc es:${controllerInputRuc.text}');
                          setState(() {
                            // Necesitamos redibujar para que el campo Text que visualiza el email lo muestre
                            nombre = controllerInputNombre.text;
                            dni = controllerInputDni.text;
                            telefono = controllerInputTelefono.text;
                            direccion = controllerInputDireccion.text;
                            email = controllerInputEmail.text;
                            RUC = controllerInputRuc.text;
                          });
                        },
                        labelStyle: const TextStyle(fontSize: 20),
                        bgColor: Color(0xffC4ACCD),
                        borderColor: Color(0xff6C3082),
                        borderWidth: s3,
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      PrettySlideUnderlineButton(
                        label: 'Ver Listado de Participantes',
                        labelStyle: TextStyle(fontSize: 16, color: colores.c3),
                        onPressed: () {
                          context.push('/cards');
                        },
                        secondSlideColor: colores.c1,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _visualizarDatos(),
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

  Widget _visualizarDatos() {
    return Column(
      children: [
        Text('Nombre del asistente: $nombre'),
        Text('Dni del asistente: $dni'),
        Text('Telefono del asistente: $telefono'),
        Text('Direccion del asistente: $direccion'),
        Text('Email del asistente: $email'),
        Text('Ruc del asistente: $RUC'),
        Text('Password: $password'),
        Text('Firma: $firma')

        // mostrar la firma obtenida
      ],
    );
  }
}
