import 'package:application/pages/splashscreen.dart';
import 'package:application/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/account_provider.dart';
import './providers/tickets_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFF8F8F8),
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFF8F8F8),
        ),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AccountProvider()),
              ChangeNotifierProvider(create: (_) => TicketsProvider()),
              ChangeNotifierProvider(create: (_) => RouteProvider()),
            ],
            child: MaterialApp(
                theme:
                    ThemeData(scaffoldBackgroundColor: const Color(0xFFF8F8F8)),
                debugShowCheckedModeBanner: false,
                home: const SplashScreen())));
  }
}
