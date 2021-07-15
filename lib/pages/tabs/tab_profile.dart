import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/btn_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    final authService = Provider.of<AuthService>(context);
    final Usuario user = authService.usuario;

    nameCtr..text = user.name;
    lastnameCtr..text = user.lastname;
    emailCtr..text = user.email;
    phoneCtr..text = user.phone;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 50),
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: const Text(
                  'DA',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
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
            BotonAzul(
              text: 'Actualizar',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
