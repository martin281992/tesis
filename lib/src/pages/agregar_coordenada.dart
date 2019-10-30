import 'package:flutter/material.dart';

class AgregarCoordenada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _newMenu(context),
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Center(
        child: Text('hola mundo'),
      ),
    );
  }

  Drawer _newMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/fondo2.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Añadir coordenada'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Añadir portales'),
            onTap: () {
              Navigator.pushNamed(context, 'autos');
            },
          ),
          ListTile(
            leading: Icon(Icons.pages, color: Colors.deepPurple),
            title: Text('Añadir autopista'),
            onTap: () {
              Navigator.pushNamed(context, 'socios');
            },
          ),
        ],
      ),
    );
  }
}
