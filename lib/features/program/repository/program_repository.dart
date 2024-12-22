import 'package:eye2025/core/network/api_service.dart';
import 'package:eye2025/features/program/models/program.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin ProgramRepository {
  Future<List<Program>> fetchProgram();
  Future<void> saveFavorite(String eventId);
  Future<void> removeFavorite(String eventId);
  Future<Set<String>> getFavorites();
}

class ProgramRepositoryImpl with ProgramRepository {
  ProgramRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<List<Program>> fetchProgram() async {
    // TODO: Implement actual API call
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return [
      Program('Thursday', DateTime(2025, 8, 7), [
        Event('Arrival', '16:00', '18:00', Area.Food),
        Event('Event 1', '10:00', '11:00', Area.Main),
        Event('Event 2', '11:00', '12:00', Area.Music),
        Event('Event 9', '12:00', '13:00', Area.Seminar),
        Event('Event 10', '13:00', '14:00', Area.Prayer),
        Event('Event 11', '14:00', '15:00', Area.Creative),
        Event('Event 12', '15:00', '16:00', Area.Sports),
        Event('Event 13', '16:00', '17:00', Area.Chill),
        Event('Event 14', '17:00', '18:00', Area.Main)
      ]),
      Program('Friday', DateTime(2025, 8, 8), [
        Event('Arrival', '08:00', '09:00', Area.Food),
        Event('Event 3', '10:00', '11:00', Area.Seminar),
        Event('Event 4', '11:00', '12:00', Area.Prayer),
        Event('Event 15', '12:00', '13:00', Area.Creative),
        Event('Event 16', '13:00', '14:00', Area.Sports),
        Event('Event 17', '14:00', '15:00', Area.Chill),
        Event('Event 18', '15:00', '16:00', Area.Main),
        Event('Event 19', '16:00', '17:00', Area.Music),
        Event('Event 20', '17:00', '18:00', Area.Seminar)
      ]),
      Program('Saturday', DateTime(2025, 8, 9), [
        Event('Arrival', '08:00', '09:00', Area.Food),
        Event('Event 5', '10:00', '11:00', Area.Creative),
        Event('Event 6', '11:00', '12:00', Area.Sports),
        Event('Event 21', '12:00', '13:00', Area.Chill),
        Event('Event 22', '13:00', '14:00', Area.Main),
        Event('Event 23', '14:00', '15:00', Area.Music),
        Event('Event 24', '15:00', '16:00', Area.Seminar),
        Event('Event 25', '16:00', '17:00', Area.Prayer),
        Event('Event 26', '17:00', '18:00', Area.Creative)
      ]),
      Program('Sunday', DateTime(2025, 8, 10), [
        Event('Arrival', '08:00', '09:00', Area.Food),
        Event('Event 7', '10:00', '11:00', Area.Chill),
        Event('Event 8', '11:00', '12:00', Area.Main),
        Event('Event 27', '12:00', '13:00', Area.Music),
        Event('Event 28', '13:00', '14:00', Area.Seminar),
        Event('Event 29', '14:00', '15:00', Area.Prayer),
        Event('Event 30', '15:00', '16:00', Area.Creative),
        Event('Event 31', '16:00', '17:00', Area.Sports),
        Event('Event 32', '17:00', '18:00', Area.Chill)
      ]),
    ];
  }

  @override
  Future<void> saveFavorite(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(eventId);
    await prefs.setStringList('favorites', favorites);
  }

  @override
  Future<void> removeFavorite(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    favorites.remove(eventId);
    await prefs.setStringList('favorites', favorites);
  }

  @override
  Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites')?.toSet() ?? {};
  }
}
