enum Area {
  Main,
  Music,
  Seminar,
  Prayer,
  Creative,
  Sports,
  Chill,
  Food,
  Sanitary,
}

class Program {
  final String day;
  final DateTime date;
  final List<Event> events;

  Program(this.day, this.date, this.events);
}

class Event {
  final String name;
  final String startTime;
  final String endTime;
  final Area area;
  bool favorite;

  Event(this.name, this.startTime, this.endTime, this.area, {this.favorite = false});
}
