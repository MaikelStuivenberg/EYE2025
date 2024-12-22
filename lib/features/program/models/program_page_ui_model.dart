import 'package:eye2025/features/program/models/program.dart';

class ProgramPageUiModel {
  ProgramPageUiModel({
    required this.programs,
    required this.selectedFilters,
    required this.favorites,
  });

  final List<Program> programs;
  final Set<String> selectedFilters;
  final Set<String> favorites;

  bool get areAllFiltersSelected => selectedFilters.length == 8;
}
