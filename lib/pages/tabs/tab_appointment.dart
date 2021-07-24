import 'package:flutter/material.dart';

class TabAppointmentPage extends StatelessWidget {
  const TabAppointmentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: ListView(
        children: [
          buildListProduct(context),
          buildListProduct(context),
          buildListProduct(context),
          buildListProduct(context),
        ],
      ),
    );
  }
}

Widget buildListProduct(BuildContext context) {
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
            'Masajes Reductores',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Limpieza de cutiz, barros y espinillas',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
          trailing: Text(
            "\$ 45.00",
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
                '17/07/2021 15:30',
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
