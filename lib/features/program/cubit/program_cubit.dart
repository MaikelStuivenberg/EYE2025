import 'package:eye2025/features/program/models/program.dart';
import 'package:eye2025/features/program/models/program_page_ui_model.dart';
import 'package:eye2025/shared/bloc/base_state.dart';
import 'package:eye2025/shared/bloc/common_cubit.dart';
import 'package:eye2025/features/program/repository/program_repository.dart';

class ProgramCubit extends CommonCubit<ProgramPageUiModel, void> {
  ProgramCubit(this._programRepository) : super(const BaseState.loading());

  final ProgramRepository _programRepository;
  final Set<String> _selectedFilters = {
    'Main',
    'Music',
    'Seminar',
    'Prayer',
    'Creative',
    'Sports',
    'Chill',
    'Food'
  };

  List<Program>? _cachedProgram;
  Set<String> _favorites = {};

  @override
  Future<void> init() async {
    await _fetchProgram();
    _favorites = await _programRepository.getFavorites();
    emitData(ProgramPageUiModel(
      programs: _filterProgram(_cachedProgram!),
      selectedFilters: _selectedFilters,
      favorites: _favorites,
    ));
  }

  Future<void> refresh() async {
    try {
      final program = await _programRepository.fetchProgram();
      _cachedProgram = program;
      _favorites = await _programRepository.getFavorites();
      emitData(ProgramPageUiModel(
        programs: _filterProgram(program),
        selectedFilters: _selectedFilters,
        favorites: _favorites,
      ));
    } catch (e) {
      emitError(e.toString());
    }
  }

  Future<void> _fetchProgram() async {
    try {
      final program = await _programRepository.fetchProgram();
      _cachedProgram = program;
      emitData(ProgramPageUiModel(
        programs: _filterProgram(program),
        selectedFilters: _selectedFilters,
        favorites: _favorites,
      ));
    } catch (e) {
      emitError(e.toString());
    }
  }

  void updateFilter(String area, bool isSelected) {
    if (isSelected) {
      _selectedFilters.add(area);
    } else {
      _selectedFilters.remove(area);
    }
    emitData(ProgramPageUiModel(
      programs: _filterProgram(_cachedProgram!),
      selectedFilters: _selectedFilters,
      favorites: _favorites,
    ));
  }

  void resetFilters() {
    _selectedFilters.clear();
    _selectedFilters.addAll([
      'Main',
      'Music',
      'Seminar',
      'Prayer',
      'Creative',
      'Sports',
      'Chill',
      'Food'
    ]);
    emitData(ProgramPageUiModel(
      programs: _filterProgram(_cachedProgram!),
      selectedFilters: _selectedFilters,
      favorites: _favorites,
    ));
  }

  void removeAllFilters() {
    _selectedFilters.clear();
    emitData(ProgramPageUiModel(
      programs: _filterProgram(_cachedProgram!),
      selectedFilters: _selectedFilters,
      favorites: _favorites,
    ));
  }

  Future<void> toggleFavorite(String eventId) async {
    if (_favorites.contains(eventId)) {
      await _programRepository.removeFavorite(eventId);
      _favorites.remove(eventId);
    } else {
      await _programRepository.saveFavorite(eventId);
      _favorites.add(eventId);
    }
    emitData(ProgramPageUiModel(
      programs: _filterProgram(_cachedProgram!),
      selectedFilters: _selectedFilters,
      favorites: _favorites,
    ));
  }

  bool get areAllFiltersSelected => _selectedFilters.length == 8;

  List<Program> _filterProgram(List<Program> program) {
    return program.map((p) {
      final filteredEvents = p.events
          .where((event) => _selectedFilters.contains(event.area.name))
          .map((event) => Event(event.name, event.startTime, event.endTime, event.area, favorite: _favorites.contains(event.name)))
          .toList();
      return Program(p.day, p.date, filteredEvents);
    }).toList();
  }
}
