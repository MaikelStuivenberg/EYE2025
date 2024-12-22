import 'package:eye2025/core/network/api_service.dart';

mixin ProgramRepository {}

class ProgramRepositoryImpl with ProgramRepository {
  ProgramRepositoryImpl(this._apiService);

  final ApiService _apiService;
}
