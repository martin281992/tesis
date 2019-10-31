import 'package:apptagit/src/pages/login_page.dart';
import 'package:flutter/material.dart';

class LoginSocios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        body: Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginSocio(context),
          ],
        ));
  }

  Widget _buttonBack(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 90.0),
        child: Row(
          children: <Widget>[
            FlatButton(
              child: Text('Regresa Home', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic,),),
              onPressed: () => Navigator.pushNamed(context, 'login'),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginSocio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: 230.0,
          ),
        ),
        Container(
            width: size.width * 0.75,
            padding: EdgeInsets.symmetric(vertical:20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color.fromRGBO(90, 63, 156, 1.0),
                  Color.fromRGBO(60, 70, 120, 1.0)
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  ' "No te dejes cobrar demas" ',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
                SizedBox(height: 10.0, width: double.infinity),
                _tokenSocio(),
                SizedBox(height: 15.0, width: double.infinity),
                _botonIngreso(),
                _buttonBack(context),
              ],
            )),
      ],
    ));
  }

  Widget _botonIngreso() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
        child: Text('Ingresa'),
      ),
      elevation: 0.0,
      color: Colors.white,
      textColor: Colors.deepPurpleAccent,
      onPressed: () {},
    );
  }

  Widget _tokenSocio() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            icon: Icon(Icons.time_to_leave, color: Colors.white),
            hintText: 'ejemplo: ASDKSADK20FCN3E',
            labelText: 'Token invitacion'),
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 1,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(90, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ],
        ),
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.0, width: double.infinity),
              Text(
                'Bienvenido Socio',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
