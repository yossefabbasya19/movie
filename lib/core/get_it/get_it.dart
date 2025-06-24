import 'package:get_it/get_it.dart';
import 'package:movies/feature/authentication/data/data_source/api_data_source.dart';
import 'package:movies/feature/authentication/data/repo/auth_repo_implement.dart';

final getIt = GetIt.instance;


void setup() {
  getIt.registerSingleton<AuthRepoImplement>(
    AuthRepoImplement(ApiDataSource()),
  );
}
