import 'package:chat/pages/tabs/tab_appointment.dart';
import 'package:chat/pages/tabs/tab_profile.dart';
import 'package:chat/pages/tabs/tab_services_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sbelta App"),
          centerTitle: true,
        ),
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.messenger_sharp),
          onPressed: () async {
            final link = WhatsAppUnilink(
              phoneNumber: '+593-987176673',
              text: "Hola, necesito informacion",
            );
            // Convert the WhatsAppUnilink instance to a string.
            // Use either Dart's string interpolation or the toString() method.
            // The "launch" method is part of "url_launcher".
            await launch('$link');
          },
        ),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Servicios',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.point_of_sale),
          label: 'Mis Citas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      // physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        TabServicesPage(),
        TabAppointmentPage(),
        TabProfilePage(),
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int valor) {
    this._paginaActual = valor;

    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
