import 'package:flutter/material.dart';
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_rounded,
                        size: 40,
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100), 
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/CITEtex-Cusco.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Aplicativo de Registro de Asistencia',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                      color: colores?.c1),
                ),
                const SizedBox(height: 50),
                const SizedBox(height: 50),
                PrettyBorderButton(
                  label: '   Registrar Participante   ',
                  onPressed: () => context.push('/formularioParticipantes'),
                  labelStyle: const TextStyle(fontSize: 20),
                  bgColor: const Color(0xffC4ACCD),
                  borderColor: const Color(0xff6C3082),
                  borderWidth: s4,
                ),
                const SizedBox(
                  height: 50,
                ),
                PrettyBorderButton(
                  label: '   Eventos   ',
                  onPressed: () => context.push('/formularioEventos'),
                  labelStyle: const TextStyle(fontSize: 20),
                  bgColor: const Color(0xffC4ACCD),
                  borderColor: const Color(0xff6C3082),
                  borderWidth: s4,
                ), 
                const SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
