import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/models/service.dart';
import 'package:chat/services/get_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final getServices = Provider.of<GetServices>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: FutureBuilder(
        future: getServices.getAllServices(),
        builder: (BuildContext _, AsyncSnapshot<List<Service>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final servicios = snapshot.data;
          return RefreshIndicator(
            onRefresh: () {
              getServices.arrayServices = [];
              return getServices.getAllServices();
            },
            child: ListView.builder(
              itemCount: servicios.length,
              itemBuilder: (context, i) => buildCard(context, servicios[i]),
            ),
          );
        },
      ),
    );
  }
}

Widget buildCard(BuildContext context, Service servicio) {
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
            image: servicio.image != null
                ? servicio.image
                : 'https://st2.depositphotos.com/7865540/11071/i/450/depositphotos_110717374-stock-photo-businessman-showing-paper.jpg',
            placeholder: "assets/images/loading.gif",
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.new_releases,
            // color: kPrimaryColor,
            size: 50.0,
          ),
          title: Text(
            servicio.name,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(servicio.description),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Text("Promoción válida hasta el 17/Julio/2021", style: dateStyle),
              // FlatButton(onPressed: () => {}, child: Text('Cancelar')),
              TextButton(
                  onPressed: () => {addReservation(context, servicio.id)},
                  child: Text('Reservar')),
            ],
          ),
        )
      ],
    ),
  );
}
