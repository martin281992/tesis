// To parse this JSON data, do
//
//     final sociosModel = sociosModelFromJson(jsonString);
/*
import 'dart:convert';

SociosModel sociosModelFromJson(String str) => SociosModel.fromJson(json.decode(str));

String sociosModelToJson(SociosModel data) => json.encode(data.toJson());

class SociosModel {
    String id;
    String nombre;
    String correo;
    String informacion;
    bool estado;
    String encargado;

    SociosModel({
        this.id,
        this.nombre,
        this.correo,
        this.informacion,
        this.estado = true,
        this.encargado,
    });

    factory SociosModel.fromJson(Map<String, dynamic> json) => SociosModel(
        id: json["id"],
        nombre: json["nombre"],
        correo: json["correo"],
        informacion: json["informacion"],
        estado: json["estado"],
        encargado: json["encargado"]
    );

    Map<String, dynamic> toJson() => {
       // "id": id,
        "nombre": nombre,
        "correo": correo,
        "informacion": informacion,
        "estado": estado,
        "encargado": encargado,
    };
}

*/

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
