class Encargo {
  String nombreAuto;
  String nombreEncargado;
  String id;

  Encargo({this.nombreAuto, this.nombreEncargado, this.id});

  Encargo.fromMap(Map<String, dynamic> data, String id)
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
