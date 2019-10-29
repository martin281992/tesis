import 'package:apptagit/src/models/carModel.dart';
import 'package:apptagit/src/providers/car_provider.dart';
import 'package:flutter/material.dart';

class Autos extends StatefulWidget {
  @override
  _AutosState createState() => _AutosState();
}

class _AutosState extends State<Autos> {
  final tituloTexto = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

  final subtitulo = TextStyle(fontSize: 17.0, color: Colors.grey);

  final carProvider = new CarProvider();

  @override
  Widget build(BuildContext context) {
    // tomo el modelo con data que viene en el argumento desde auto.dart en el metodo  onTap: () => Navigator.pushNamed(context, 'addcar', arguments: car),

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis vehiculos'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _crearImagen(),
            _crearTitulo(),
            _listCars(),
          ],
        ),
      ),
      floatingActionButton: _crearButton(context),
    );
  }

  Widget _crearImagen() {
    return Container(
      width: double.infinity,
      child: Image(
        image: NetworkImage('https://img.yapo.cl/images/58/5883627718.jpg'),
        height: 200.0,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Auto principa del usuario',
                    style: tituloTexto,
                  ),
                  SizedBox(
                    height: 7.0,
                  ),
                  Text('Marca, patente', style: subtitulo),
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.red, size: 30.0),
            Text('41', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }

  _crearButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'addcar'),
    );
  }

  Widget _listCars() {
    return FutureBuilder(
      future: carProvider.listCar(),
      //metodo builder que regresa lista de carMODEL
      builder: (BuildContext context, AsyncSnapshot<List<CarModel>> snapshot) {
        if (snapshot.hasData) {
          final cars = snapshot.data;
          return new ListView.builder(
            shrinkWrap: true, //si no puede hacer wrap no se muestra en pantalla
            itemCount: cars.length,
            itemBuilder: (context, i) => _searchCars(context, cars[i]),
            //esto es una instancia del widget listcar que lo requiere
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _searchCars(BuildContext context, CarModel car) {
    //int _act = 1;
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.purple[200],
      ),
      onDismissed: (vehiculo) {
        carProvider.deleteCars(car.id);
        //TO-DO
      },
      child: ListTile(
        //leading: 'fotodecarro(size: 56.0)'.
        title: Text('${car.nombre}-${car.marca}'),
        subtitle: Text('${car.patente}'),
        trailing:
            Icon(Icons.more_vert), // tres puntos a la derecha de cada item
        //subtitle: _act != 2 ?  Text('${car.patente}') : null,
        //enabled: _act == 2, //se desactiva en la pantalla la opcion de click para editar el onntap se desactiva
        // isThreeLine: true, // da mas espacio entre las row
        //dense: true, // hace mas pequeño la lista
        //selected: false, // enable and disable whit select
        onTap: () => Navigator.pushNamed(context, 'addcar', arguments: car),
      ),
    );
  }
}
