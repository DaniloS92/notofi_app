import 'package:chat/widgets/btn_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class TabProfilePage extends StatefulWidget {
  @override
  _TabProfilePageState createState() => _TabProfilePageState();
}

class _TabProfilePageState extends State<TabProfilePage> {
  final nameCtr = TextEditingController();
  final lastnameCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            CustomInput(
                icon: Icons.perm_identity,
                placeholder: 'Nombres',
                keyboardType: TextInputType.text,
                textEditingController: nameCtr),
            CustomInput(
                icon: Icons.format_indent_decrease,
                placeholder: 'Apellidos',
                keyboardType: TextInputType.text,
                textEditingController: lastnameCtr),
            CustomInput(
                icon: Icons.mail_outline,
                placeholder: 'Correo',
                keyboardType: TextInputType.emailAddress,
                textEditingController: emailCtr),
            CustomInput(
                icon: Icons.phone,
                placeholder: 'Telf',
                keyboardType: TextInputType.text,
                textEditingController: phoneCtr),
            // Todo: Aqui hay que crear el boton
            BotonAzul(text: 'Actualizar', onPressed: null)
          ],
        ),
      ),
    );
  }
}
