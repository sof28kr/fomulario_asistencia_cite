import 'package:flutter/material.dart';
import 'package:fomulario_asistencia_cite/Views/Views.dart';

class bannerPersonalizado extends StatefulWidget {
  const bannerPersonalizado({super.key});

  @override
  State<bannerPersonalizado> createState() => _bannerPersonalizadoState();
}

class _bannerPersonalizadoState extends State<bannerPersonalizado> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: 140,
          height: 40,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/CITEtex-Cusco.png'),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
              onPressed: () {
                context.push('/inicio');
              },
              icon: const Icon(
                Icons.home_outlined,
                size: 40,
              ),
            )
          ]),
        ),
      ]),
    );
  }
}
