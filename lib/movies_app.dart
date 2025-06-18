import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movies/config/theme/my_theme.dart';
import 'package:movies/core/my_routes/my_routes.dart';
import 'package:movies/core/provider/language_provider.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class MoviesApp extends StatefulWidget {
  const MoviesApp({super.key});

  @override
  State<MoviesApp> createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp> {
  late bool toOnboarding;

  @override
  void initState() {
    toOnboarding = SharedPref().onBoardingIsOpen;
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LanguageProvider provider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.currentLanguage),
      onGenerateRoute: MyRoutes.route,
      initialRoute:toOnboarding
          ? FirebaseAuth.instance.currentUser == null
          ? MyRoutes.login
          : MyRoutes.mainLayout
          : MyRoutes.onBoarding,
      darkTheme: MyTheme.dark,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
