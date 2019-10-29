// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
    String id;
    String nombre;
    String marca;
    String patente;
    bool principal;

    CarModel({
        this.id,
        this.nombre,
        this.marca,
        this.patente,
        this.principal = true,
    });

    factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        nombre: json["nombre"],
        marca: json["marca"],
        patente: json["patente"],
        principal: json["principal"],
    );

    Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "marca": marca,
        "patente": patente,
        "principal": principal,
    };
}
