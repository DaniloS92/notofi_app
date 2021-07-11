import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/btn_azul.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            //height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(titulo: 'Notify App'),
                _Form(),
                Labels(ruta: 'login', login: false),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtr = TextEditingController();
  final lastnameCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final passCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
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
          CustomInput(
              icon: Icons.lock_open_outlined,
              placeholder: 'Password',
              isPassword: true,
              textEditingController: passCtr),
          // Todo: Aqui hay que crear el boton
          BotonAzul(
            text: 'Registrarse',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final registerOk = await authService.register(
                        nameCtr.text.trim(),
                        emailCtr.text.trim(),
                        passCtr.text.trim(),
                        lastnameCtr.text.trim(),
                        phoneCtr.text.trim());

                    if (registerOk == true) {
                      //TODO: Conectar al socket service
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      // Mostrar Alerta
                      mostrarAlerta(context, 'Registro Incorrecto', registerOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
