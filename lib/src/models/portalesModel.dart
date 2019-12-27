class Portal {
  String nombreC;
  String nombreP;
  String costo;
  String costoMedia;
  String costoAlta;
  String latitud;
  String longitud;
  String categoria;
  String id;

  Portal(
      {this.nombreC,
      this.nombreP,
      this.costo,
      this.latitud,
      this.longitud,
      this.costoMedia,
      this.costoAlta,
      this.categoria,
      this.id});

  Portal.fromMap(Map<String, dynamic> data, String id)
      : nombreC = data["nombreC"],
        nombreP = data['nombreP'],
        costo = data['costo'],
        costoMedia = data['costoMedia'],
        costoAlta = data['costoAlta'],
        latitud = data['latitud'],
        longitud = data['longitud'],
        categoria = data['categoria'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "nombreC": nombreC,
      "nombreP": nombreP,
      "costo": costo,
      "costoMedia": costoMedia,
      "costoAlta": costoAlta,
      "latitud": latitud,
      "longitud": longitud,
      "categoria": categoria,
    };
  }
}
