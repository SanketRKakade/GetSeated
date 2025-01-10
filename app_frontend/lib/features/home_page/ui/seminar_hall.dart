import 'package:flutter/material.dart';

enum Hall { ComputerSeminarHall, ITSeminarHall, EnTCSeminarHall, Auditorium }

class SeminarHall extends StatefulWidget {
  SeminarHall({super.key});

  @override
  State<SeminarHall> createState() => _SeminarHallState();
}

class _SeminarHallState extends State<SeminarHall> {
  List<Session> events = [
    Session(
        hallName: Hall.EnTCSeminarHall,
        timing: DateTime.parse('2024-04-15 16:00:00Z'),
        title: 'IntraParicharcha',
        description: 'DEBSOC Event'),
    Session(
        hallName: Hall.ITSeminarHall,
        timing: DateTime.parse('2024-04-16 19:30:00Z'),
        title: 'IntraParicharcha',
        description: 'DEBSOC Event'),
    Session(
        hallName: Hall.ComputerSeminarHall,
        timing: DateTime.parse('2024-03-15 17:30:00Z'),
        title: 'Flutter SIG',
        description: 'PASC Event'),
    Session(
        hallName: Hall.Auditorium,
        timing: DateTime.parse('2024-04-05 10:00:00Z'),
        title: 'InC',
        description: 'Tech Fest'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return event.createTile();
      },
      separatorBuilder: (context, index) =>
          Divider(), // Simple divider separator
    );
  }
}

class Session {
  Hall hallName;
  DateTime timing;
  String title, description;
  Session(
      {required this.hallName,
      required this.timing,
      required this.title,
      required this.description});

  String getDate() {
    return this.timing.day.toString() +
        '/' +
        this.timing.month.toString() +
        '/' +
        this.timing.year.toString();
  }

  String getTime() {
    String hour = (this.timing.hour % 12).toString();
    int minute = this.timing.minute;
    String minstr = (minute / 10).toString() + (minute % 10).toString();
    String ampm = (this.timing.hour / 10 == 0) ? 'AM' : 'PM';
    return hour + ":" + minstr + " " + ampm;
  }

  String getHall() {
    return this.hallName.toString().substring(5);
  }

  ListTile createTile() {
    return ListTile(
      title: Text(
        this.title,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      titleTextStyle:
          const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      subtitle: Text('Hall: ${getHall()}\n'
          'Date: ${getDate()}\n'
          'Day: ${this.timing.weekday}\n'
          'Time: ${getTime()}\n'
          'Description: ${this.description}'),
      subtitleTextStyle: const TextStyle(fontSize: 15, color: Colors.black),
    );
  }
}
