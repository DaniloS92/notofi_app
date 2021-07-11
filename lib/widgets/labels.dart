import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String ruta;
  final bool login;

  const Labels({
    Key key, 
    @required this.ruta, 
    this.login = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            (this.login) ? 'No tienes cuenta?' : 'Ya tienes una cuenta?',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            child: Text(
              (this.login) ? 'Crea una ahora!' : 'Inicia session aqui!',
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
