class Socios {
   String nombre;
   String correo;
   String encargado;
   String informacion;
   String id;

  Socios({this.nombre, this.correo, this.encargado, this.informacion, this.id});

  Socios.fromMap(Map<String, dynamic> data, String id)
      : nombre = data["nombre"],
        correo = data['correo'],
        encargado = data['encargado'],
        informacion = data['informacion'],
        id = id;

  Map<String, dynamic> toMap() {
    return {
      "nombre": nombre,
      "correo": correo,
      "encargado": encargado,
      "informacion": informacion,
    };
  }
}
