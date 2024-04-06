import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onfly/firebase_options.dart';
import 'package:onfly/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onfly/shared/theme/colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp.router(
            routerConfig: router,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('pt', 'BR'),
            ],
            locale: const Locale('pt', 'BR'),
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: DefaultColors().primary,
              ).copyWith(
                primary: DefaultColors().primary,
              ),
              appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(color: DefaultColors().primary, fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ),
          );
        } else {
          return Container(
            color: DefaultColors().primary,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
