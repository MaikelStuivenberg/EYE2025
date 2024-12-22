import 'package:eye2025/core/network/api_service.dart';
import 'package:eye2025/features/map/cubit/map_cubit.dart';
import 'package:eye2025/features/program/cubit/program_cubit.dart';
import 'package:eye2025/features/program/repository/program_repository.dart';
import 'package:eye2025/features/splash/cubit/splash_cubit.dart';
import 'package:eye2025/features/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.allowReassignment = true;
  await initAPIService();

  /// Init repositories
  initRepositories();
  initCubits();
}

Future<void> initAPIService() async {
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(),
  );
}

void initCubits() {
  getIt
    ..registerLazySingleton<SplashCubit>(() => SplashCubit())
    ..registerLazySingleton<HomeCubit>(() => HomeCubit(getIt()))
    ..registerLazySingleton<ProgramCubit>(() => ProgramCubit(getIt()))
    ..registerLazySingleton<MapCubit>(() => MapCubit());
}

void initRepositories() {
  getIt.registerLazySingleton<ProgramRepository>(
      () => ProgramRepositoryImpl(getIt()));
}
