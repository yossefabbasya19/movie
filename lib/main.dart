import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movies/core/get_it/get_it.dart';
import 'package:movies/core/provider/language_provider.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:movies/feature/movie_details/data/repo/movie_details_repo_imple.dart';
import 'package:movies/feature/movie_details/presentation/views/movie_details.dart';
import 'package:movies/firebase_options.dart';
import 'package:movies/movies_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SharedPref().init();
  setup();
  runApp(
    ChangeNotifierProvider<LanguageProvider>(
      create: (context) => LanguageProvider(),
      child: MoviesApp(),
    ),
  );
}
