import 'package:flutter/material.dart';

class TabServicesPage extends StatefulWidget {
  @override
  _TabServicesPageState createState() => _TabServicesPageState();
}

class _TabServicesPageState extends State<TabServicesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: ListView(
        children: [buildCard()],
      ),
    );
  }
}

Widget buildCard() {
  final kPrimaryColor = Colors.red;
  final TextStyle dateStyle =
      TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold);
  return Card(
    elevation: 5.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: FadeInImage.assetNetwork(
            height: 300.0,
            width: double.infinity,
            fit: BoxFit.cover,
            image: 'https://pbs.twimg.com/media/DPPx1CLXkAAY6q7.jpg',
            placeholder: "assets/images/loading.gif",
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.new_releases,
            color: kPrimaryColor,
            size: 50.0,
          ),
          title: Text(
            'BOOM AHORRO: 2DO A MITAD DE PRECIO EN BLEMIL',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle:
              Text("COMPRA 1 LATA LECHE BLEMIL LLEVA EL 2DO A MITAD DE PRECIO"),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Text("Inicio: 15/Enero/2020", style: dateStyle),
              // SizedBox(width: 5.0),
              Text("Promoción válida hasta el 17/Julio/2021", style: dateStyle),
              // FlatButton(onPressed: () => {}, child: Text('Cancelar')),
              // FlatButton(onPressed: () => {}, child: Text('Ok')),
            ],
          ),
        )
      ],
    ),
  );
}
