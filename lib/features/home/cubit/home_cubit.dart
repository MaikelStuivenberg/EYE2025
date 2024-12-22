import 'package:eye2025/features/home/models/home_page_ui_model.dart';
import 'package:eye2025/features/program/models/program.dart';
import 'package:eye2025/features/program/repository/program_repository.dart';
import 'package:eye2025/shared/bloc/base_state.dart';
import 'package:eye2025/shared/bloc/common_cubit.dart';

class HomeCubit extends CommonCubit<HomePageUiModel, void> {
  HomeCubit(this._programRepository) : super(const BaseState.loading());

  final ProgramRepository _programRepository;

  @override
  Future<void> init() async {
    final programs = await _programRepository.fetchProgram();
    final favorites = await _programRepository.getFavorites();
    final nextFavoriteEvent = _getNextFavoriteEvent(programs, favorites);
    final nextFavoriteEventDate = _getNextFavoriteEventDate(programs, nextFavoriteEvent);
    emitData(HomePageUiModel(
      nextFavoriteEvent: nextFavoriteEvent,
      nextFavoriteEventDate: nextFavoriteEventDate,
    ));
  }

  Event? _getNextFavoriteEvent(List<Program> programs, Set<String> favorites) {
    final now = DateTime.now();

    for (final program in programs) {
      for (final event in program.events) {
        final eventDateTime = DateTime(
          program.date.year,
          program.date.month,
          program.date.day,
          int.parse(event.startTime.split(':')[0]),
          int.parse(event.startTime.split(':')[1]),
        );
        if ((favorites.contains(event.name) || event.name == 'Arrival') && eventDateTime.isAfter(now)) {
          return event;
        }
      }
    }
    return null;
  }

  DateTime? _getNextFavoriteEventDate(List<Program> programs, Event? event) {
    if (event == null) return null;
    for (final program in programs) {
      if (program.events.contains(event)) {
        return program.date;
      }
    }
    return null;
  }
}
