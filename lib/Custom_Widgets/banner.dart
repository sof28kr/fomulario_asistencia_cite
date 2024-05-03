import 'package:flutter/material.dart';

class bannerPersonalizado extends StatefulWidget {
  const bannerPersonalizado({super.key});

  @override
  State<bannerPersonalizado> createState() => _bannerPersonalizadoState();
}

class _bannerPersonalizadoState extends State<bannerPersonalizado> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: 140,
          height: 40,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/CITEtex-Cusco.png'),
                  fit: BoxFit.cover)),
        ),
      ]),
    );
  }
}
