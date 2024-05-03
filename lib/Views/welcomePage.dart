import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:fomulario_asistencia_cite/Custom_Widgets/AppColors.dart';

import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).extension<AppColors>();
    return Scaffold(
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info_rounded,
                      size: 40,
                    ),
                    style: ButtonStyle(
                        iconColor: MaterialStatePropertyAll(colores!.c4)),
                  )
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/CITEtex-Cusco.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'Aplicativo de Registro de Asistencia',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: colores.c1),
              ),
              SizedBox(height: 50),
              PrettySlideUnderlineButton(
                label: 'Crear un nuevo evento ',
                labelStyle: TextStyle(fontSize: 16, color: colores.c3),
                onPressed: () {
                  context.push('/f2');
                },
                secondSlideColor: colores.c1,
              ),
              SizedBox(height: 50),
              PrettyBorderButton(
                label: '   Registrar Participante   ',
                onPressed: () => context.push('/ListadoParticipantes'),
                labelStyle: const TextStyle(fontSize: 20),
                bgColor: Color(0xffC4ACCD),
                borderColor: Color(0xff6C3082),
                borderWidth: s4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
