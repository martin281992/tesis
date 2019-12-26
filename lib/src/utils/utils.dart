import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informacion incorrecta'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}

int diasEnMes(int mes) {
  var actual = DateTime.now();

  var ultimoDia = (mes < 12)
      ? new DateTime(actual.year, mes + 1, 0)
      : new DateTime(actual.year + 1, 1, 0);

  return ultimoDia.day;
}
