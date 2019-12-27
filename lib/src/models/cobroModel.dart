class Cobros {
  String categoria;
  int dia;
  int mes;
  int valor;
  String nombrePortal;
  String nombreCon;
  String hora;
  String tarifa;
  String id;

  Cobros(
      {this.categoria,
      this.dia,
      this.mes,
      this.valor,
      this.nombrePortal,
      this.nombreCon,
      this.hora,
      this.tarifa,
      this.id});

  Cobros.fromMap(Map<String, dynamic> data, String id)
      : categoria = data["categoria"],
        dia = data['dia'],
        mes = data['mes'],
        valor = data['valor'],
        nombrePortal = data['nombrePortal'],
        nombreCon = data['nombreCon'],
        hora = data['hora'],
        tarifa = data['tarifa'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "categoria": categoria,
      "dia": dia,
      "mes": mes,
      "valor": valor,
      "nombrePortal": nombrePortal,
      "nombreCon": nombreCon,
      "hora": hora,
      "tarifa": tarifa,
    };
  }
}
