import 'package:eye2025/core/widgets/base_state_consumer.dart';
import 'package:eye2025/core/widgets/base_state_page.dart';
import 'package:eye2025/features/home/cubit/home_cubit.dart';
import 'package:eye2025/shared/widgets/eye_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:eye2025/features/map/map.dart';
import 'package:eye2025/features/program/models/program.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseStatePage<HomePage, HomeCubit> {
  @override
  Widget build(BuildContext context) {
    return EyeScaffold(
      title: 'Home',
      body: BaseStateConsumer(
        cubit: cubit,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onData: (context, uiModel) {
          final event = uiModel.nextFavoriteEvent;
          final eventDate = uiModel.nextFavoriteEventDate;
          return Card(
            margin: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'UPCOMING',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (event != null && eventDate != null)
                        Text(
                          _getTimeLeft(event.startTime, eventDate),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                ListTile(
                  title: event != null
                      ? Text(
                          event.name,
                          style: TextStyle(
                            fontFamily: 'Edmund',
                            fontSize: 24,
                          ),
                        )
                      : Text('No upcoming favorite program item'),
                  subtitle: event != null
                      ? Text('${event.startTime} to ${event.endTime}')
                      : null,
                  trailing: event != null
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapPage(
                                  highlightedArea: event.area.toString().split('.').last,
                                ),
                              ),
                            );
                          },
                          child: Chip(
                            label: Text(event.area.toString().split('.').last),
                            labelStyle: TextStyle(fontSize: 12),
                            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: true,
    );
  }

  String _getTimeLeft(String startTime, DateTime eventDate) {
    final now = DateTime.now();
    final startDateTime = DateTime(
      eventDate.year,
      eventDate.month,
      eventDate.day,
      int.parse(startTime.split(':')[0]),
      int.parse(startTime.split(':')[1]),
    );
    final difference = startDateTime.difference(now);

    if (difference.inDays > 1) {
      return '${difference.inDays} days';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours';
    } else {
      return '${difference.inMinutes} min';
    }
  }
}
