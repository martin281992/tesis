class Portal {
  String nombreC;
  String nombreP;
  String costo;
  String latitud;
  String longitud;
  String id;

  Portal(
      {this.nombreC,
      this.nombreP,
      this.costo,
      this.latitud,
      this.longitud,
      this.id});

  Portal.fromMap(Map<String, dynamic> data, String id)
      : nombreC = data["nombreC"],
        nombreP = data['nombreP'],
        costo = data['costo'],
        latitud = data['latitud'],
        longitud = data['longitud'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "nombreC": nombreC,
      "nombreP": nombreP,
      "costo": costo,
      "latitud": latitud,
      "longitud": longitud,
    };
  }
}
