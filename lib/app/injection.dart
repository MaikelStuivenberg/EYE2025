import 'package:eye2025/core/network/api_service.dart';
import 'package:eye2025/features/splash/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.allowReassignment = true;
  await initAPIService();

  /// Init repositories
  // initRepositories();
  initCubits();
}

Future<void> initAPIService() async {
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(),
  );
}

void initCubits() {
  getIt
    ..registerLazySingleton<SplashCubit>(() => SplashCubit() // getIt()),
        );
}
