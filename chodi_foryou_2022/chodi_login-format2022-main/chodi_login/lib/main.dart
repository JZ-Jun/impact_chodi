import 'package:flutter/material.dart';
import 'package:flutter_chodi_app/screens/welcome_screen.dart';
import 'package:flutter_chodi_app/services/firebase_authentication_service.dart';
import 'package:flutter_chodi_app/viewmodel/main_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chodi_app/services/google_authentication_service/google_authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var _provider = [
    ListenableProvider(create: (_) => MainScreenViewModel()),
  ];
  runApp(MultiProvider(
    providers: _provider,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ListenableProvider<GoogleAuthentication>(
            create: (context) => GoogleAuthentication(),
          ),
          ListenableProvider<FirebaseService>(
            create: (context) => FirebaseService(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: WelcomeScreen(),
        ),
      );
}

//const WelcomeScreen()