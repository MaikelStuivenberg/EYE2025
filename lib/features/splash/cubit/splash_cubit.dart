import 'package:eye2025/shared/bloc/base_state.dart';
import 'package:eye2025/shared/bloc/common_cubit.dart';

class SplashCubit extends CommonCubit<void, void> {
  SplashCubit(
      // this._authRepository,
      // this._profilesRepository,
      )
      : super(const BaseState.loading());

  // final FamilyAuthRepository _authRepository;
  // final ProfilesRepository _profilesRepository;?

  @override
  Future<void> init() async {
    // await _authRepository.initAuth();
    // final user = _authRepository.getCurrentUser();
    // final profiles = await _profilesRepository.refreshProfiles();
  }
}
