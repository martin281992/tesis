class Cobros {
  String categoria;
  int dia;
  int mes;
  int valor;
  String id;

  Cobros({this.categoria, this.dia, this.mes, this.valor, this.id});

  Cobros.fromMap(Map<String, dynamic> data, String id)
      : categoria = data["categoria"],
        dia = data['dia'],
        mes = data['mes'],
        valor = data['valor'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "categoria": categoria,
      "dia": dia,
      "mes": mes,
      "valor": valor,
    };
  }
}
