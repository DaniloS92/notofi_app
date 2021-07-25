import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/get_services.dart';
import 'package:chat/services/push_notifications_services.dart';
import 'package:chat/services/reservation_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => GetServices()),
        ChangeNotifierProvider(create: (_) => ReservationService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sbelta App',
        initialRoute: 'login',
        routes: appRoutes,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es'), // Spanish
        ],
      ),
    );
  }
}
