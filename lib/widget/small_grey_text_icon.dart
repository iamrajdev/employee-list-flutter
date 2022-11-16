import 'package:flutter/material.dart';

class SmallGreyTextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? textColor;
  final Color? iconColor;
  final double? fontSize;
  const SmallGreyTextIcon(
      {Key? key,
      required this.text,
      required this.icon,
      this.textColor = const Color.fromARGB(255, 87, 87, 87),
      this.iconColor = const Color.fromARGB(255, 87, 87, 87),
      this.fontSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 14),
        const SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ],
    );
  }
}
