import 'package:eye2025/features/program/models/program.dart';

class HomePageUiModel {
  HomePageUiModel({required this.nextFavoriteEvent, required this.nextFavoriteEventDate});

  final Event? nextFavoriteEvent;
  final DateTime? nextFavoriteEventDate;
}