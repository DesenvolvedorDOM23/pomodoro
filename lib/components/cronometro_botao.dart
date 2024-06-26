import 'package:flutter/material.dart';

class CronometroBotao extends StatelessWidget {
  final String texto;
  final IconData icone;
  final void Function()? clik;

  const CronometroBotao({
    required this.texto,
    required this.icone,
    this.clik,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        textStyle: const TextStyle(
          fontSize: 25,
        ),
      ),
      onPressed: clik,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              icone,
              size: 35,
            ),
          ),
          Text(texto),
        ],
      ),
    );
  }
}
