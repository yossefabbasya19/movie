import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/models/movie_DM/Movies.dart';
import 'package:movies/feature/authentication/data/repo/auth_repo_implement.dart';
import 'package:movies/feature/authentication/presentation/views/log_in/log_in.dart';
import 'package:movies/feature/authentication/presentation/views/register/register.dart';
import 'package:movies/feature/authentication/presentation/views_model/create_account_cubit/create_account_cubit.dart';
import 'package:movies/feature/authentication/presentation/views_model/login_cubit/login_cubit.dart';
import 'package:movies/feature/edit_profile/data/repo/edit_profile_repo_imple.dart';
import 'package:movies/feature/edit_profile/presentation/view_model/edit_profile_cubit.dart';
import 'package:movies/feature/edit_profile/presentation/views/edit_profile.dart';
import 'package:movies/feature/main_layout/presentation/views/main_layout.dart';
import 'package:movies/feature/movie_details/data/repo/movie_details_repo_imple.dart';
import 'package:movies/feature/movie_details/presentation/view_model/movie_detail_cubit.dart';
import 'package:movies/feature/movie_details/presentation/views/movie_details.dart';
import 'package:movies/feature/on_boarding/presentation/views/on_boarding.dart';

abstract class MyRoutes {
  static const String onBoarding = 'onBoarding';
  static const String login = 'login';
  static const String register = 'Register';
  static const String mainLayout = 'mainLayout';
  static const String editProfile = 'editProfile';
  static const String movieDetails = 'movieDetails';

  static Route? route(RouteSettings setting) {
    switch (setting.name) {
      case movieDetails:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => MovieDetailCubit(MovieDetailsRepoImple()),
                child: MovieDetails(movie: setting.arguments as Movies),
              ),
        );
      case register:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider<CreateAccountCubit>(
                create: (context) => CreateAccountCubit(AuthRepoImplement()),
                child: Register(),
              ),
        );
      case editProfile:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => EditProfileCubit(EditProfileRepoImple()),
                child: EditProfile(),
              ),
        );
      case login:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider<LoginCubit>(
                create: (context) => LoginCubit(AuthRepoImplement()),
                child: LogIn(),
              ),
        );
      case onBoarding:
        return MaterialPageRoute(builder: (context) => OnBoarding());
      case mainLayout:
        return MaterialPageRoute(builder: (context) => MainLayout());
    }
    return null;
  }
}
