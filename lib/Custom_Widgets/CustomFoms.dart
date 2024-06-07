import 'package:fomulario_asistencia_cite/Views/Views.dart';

Widget crearFormField(
  titulo,
  indicacion,
  icono,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: TextField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
          hintText: titulo,
          labelText: indicacion,
          suffixIcon: icono,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
    ),
  );
}

Widget autocompletar() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: PrettyBorderButton(
      label: '  Autocompletar  ',
      onPressed: () {},
      labelStyle: const TextStyle(fontSize: 16),
      bgColor: const Color(0xffC4ACCD),
      borderColor: const Color(0xff6C3082),
      borderWidth: s5,
    ),
  );
}

class subirFirma extends StatefulWidget {
  const subirFirma({super.key});

  @override
  State<subirFirma> createState() => _subirFirmaState();
}

class _subirFirmaState extends State<subirFirma> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: PrettyBorderButton(
        label: '  Ingresar Firma  ',
        onPressed: () => context.push('/firma'),
        labelStyle: const TextStyle(fontSize: 16),
        bgColor: const Color(0xffC4ACCD),
        borderColor: const Color(0xff6C3082),
        borderWidth: s2,
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.label,
    this.labelWidget,
    this.labelStyle,
    required this.onPressed,
    this.bgColor = Colors.white,
    this.borderColor = Colors.teal,
    this.borderWidth = 2.0,
    this.icon,
  })  : assert(label != null || labelWidget != null,
            'Either label or labelWidget must be provided.'),
        super(key: key);

  final String? label;
  final Widget? labelWidget;
  final TextStyle? labelStyle;
  final VoidCallback onPressed;
  final Color bgColor;
  final Color borderColor;
  final double borderWidth;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        side: BorderSide(color: borderColor, width: borderWidth),
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: labelStyle?.color),
            SizedBox(width: 8),
          ],
          labelWidget ??
              Text(
                label!,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff2A3439),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0 // Usa la fuente Lato
                    ),
              ),
        ],
      ),
    );
  }
}
