import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _pagina1(),
          _pagina2(),
        ],
      ),
    );
  }

  _pagina1() {
    return Stack(
      children: <Widget>[
        _imagenFondo(),
        _colorFondo(),
        _textosInicio(),
      ],
    );
  }

  _pagina2() {
    final estiloTextos = TextStyle(color: Colors.red, fontSize: 30.0);

    return Center(
      child: Text(
        'INFORMACIONES',
        style: estiloTextos,
      ),
    );
  }
}

_colorFondo() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    //color: Color.fromRGBO(8, 192, 218, 0.0),
  );
}

_imagenFondo() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Image(
      image: AssetImage('asset/fondo3.jpg'),
      fit: BoxFit.cover,
    ),
  );
}

_textosInicio() {
  final estiloTextos = TextStyle(color: Colors.white, fontSize: 30.0);
  final estiloTextos2 = TextStyle(color: Colors.white, fontSize: 14.0);

  return SafeArea(
    child: Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          'Hora punta',
          style: estiloTextos,
        ),
        SizedBox(height: 280),
        Container(
          child: Center(
            child: RaisedButton(
              shape: StadiumBorder(),
              color: Colors.blue,
              textColor: Colors.white,
              child: Text(
                'incia session',
                style: TextStyle(fontSize: 20.0),
              ),
              onPressed: () {},
            ),
          ),
        ),
        Expanded(
          child: Container(),
        ),
        Text('informaciones', style: estiloTextos2),
        Icon(Icons.keyboard_arrow_down, size: 70.0, color: Colors.white),
      ],
    ),
  );
}
