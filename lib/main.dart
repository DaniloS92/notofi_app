import 'package:chat/routes/routes.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/services/get_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => GetServices()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        initialRoute: 'home_screen',
        routes: appRoutes,
      ),
    );
  }
}
