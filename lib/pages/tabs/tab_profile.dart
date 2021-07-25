// import 'package:chat/helpers/mostrar_alerta.dart';
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
              height: 100,
              width: 100,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(
                  user.name
                      .toUpperCase()
                      .substring(0, 2), //Todo: Esto tiene que ser dinamico
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
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final registerOk = await authService.updateUser(
                          nameCtr.text.trim(),
                          emailCtr.text.trim(),
                          passCtr.text.trim(),
                          lastnameCtr.text.trim(),
                          phoneCtr.text.trim());

                      // if (registerOk == true) {
                      //   //TODO: Conectar al socket service
                      //   Navigator.pushReplacementNamed(context, 'usuarios');
                      // } else {
                      //   // Mostrar Alerta
                      //   mostrarAlerta(context, 'Registro Incorrecto', registerOk);
                      // }
                    },
            ),
            SizedBox(height: 10),
            BotonAzul(
              color: Colors.black54,
              text: 'Cerrar sesión',
              onPressed: () {
                AuthService.deleteToken();
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          ],
        ),
      ),
    );
  }
}
