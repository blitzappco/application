import 'package:blitz/pages/splashscreen.dart';
import 'package:blitz/providers/route_provider.dart';
import 'package:blitz/utils/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import './providers/account_provider.dart';
import './providers/tickets_provider.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  if (DEV) {
    runApp(const MyApp());
  } else {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://66aeb5f396b5cc7ab47ef1b9721736d8@o4507232887898112.ingest.de.sentry.io/4507724333318224';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
        options.enableMetrics = true;
        // The sampling rate for profiling is relative to tracesSampleRate
        // Setting to 1.0 will profile 100% of sampled transactions:
        options.profilesSampleRate = 1.0;
        (options) => options.autoSessionTrackingInterval =
            const Duration(milliseconds: 60000);
      },
      appRunner: () => runApp(
        DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: const MyApp(),
        ),
      ),
    );
  }
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
                navigatorObservers: [
                  SentryNavigatorObserver(),
                ],
                theme: ThemeData(
                    scaffoldBackgroundColor: const Color(0xFFF8F8F8),
                    bottomSheetTheme: const BottomSheetThemeData(
                      surfaceTintColor: Colors.white,
                    )),
                debugShowCheckedModeBanner: false,
                home: const SplashScreen())));
  }
}
