import 'package:chat/models/reservation.dart';
import 'package:chat/services/reservation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabAppointmentPage extends StatelessWidget {
  const TabAppointmentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: 5.0),
    //   child: ListView(
    //     children: [
    //       buildListProduct(context),
    //       buildListProduct(context),
    //       buildListProduct(context),
    //       buildListProduct(context),
    //     ],
    //   ),
    // );
    final getReservation =
        Provider.of<ReservationService>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: FutureBuilder(
        future: getReservation.getAllReservation(context),
        builder: (BuildContext _, AsyncSnapshot<List<Reservation>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final reservaciones = snapshot.data;
          return ListView.builder(
            itemCount: reservaciones.length,
            itemBuilder: (context, i) =>
                buildListProduct(context, reservaciones[i]),
          );
        },
      ),
    );
  }
}

Widget buildListProduct(BuildContext context, Reservation reservacion) {
  final kPrimaryColor = Theme.of(context).primaryColor;
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.access_alarms_sharp,
            color: kPrimaryColor,
            size: 40.0,
          ),
          title: Text(
            reservacion.service.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            reservacion.service.description,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
          trailing: Text(
            "\$ ${reservacion.service.price}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                '${reservacion.date.toString().replaceAll(' 00:00:00.000Z', '')} ${reservacion.hour}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Perform some action
                  },
                  child: Row(
                    children: [
                      Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
