import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/core/shared_pref/shared_pref.dart';
import 'package:movies/feature/main_layout/data/repo/main_layout_repo.dart';

part 'fetch_user_info_state.dart';

class FetchUserInfoCubit extends Cubit<FetchUserInfoState> {
  FetchUserInfoCubit(this.mainLayoutRepo) : super(FetchUserInfoInitial());
  final MainLayoutRepo mainLayoutRepo;

  Future<void> getUserInfo() async {
    emit(FetchUserInfoLoading());
    var result = await mainLayoutRepo.getUserInfo(SharedPref().userToken!);
    result.fold(
      (left) {
        emit(FetchUserInfoFailure());
      },
      (right) {
        emit(FetchUserInfoSuccess());
      },
    );
  }
}
