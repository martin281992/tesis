class Cliente {
  String nombreAuto;
  String nombreEncargado;
  String id;

  Cliente({this.nombreAuto, this.nombreEncargado, this.id});

  Cliente.fromMap(Map<String, dynamic> data, String id)
      : nombreAuto = data["nombreAuto"],
        nombreEncargado = data['nombreEncargado'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "nombreAuto": nombreAuto,
      "nombreEncargado": nombreEncargado,
    };
  }
}
