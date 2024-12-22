import 'package:eye2025/core/widgets/base_state_consumer.dart';
import 'package:eye2025/core/widgets/base_state_page.dart';
import 'package:eye2025/features/program/cubit/program_cubit.dart';
import 'package:eye2025/features/program/models/program_page_ui_model.dart';
import 'package:eye2025/shared/widgets/eye_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:eye2025/features/map/map.dart';
import 'package:eye2025/features/program/models/program.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({super.key});

  @override
  State<ProgramPage> createState() => _ProgramPageState();
}

class _ProgramPageState extends BaseStatePage<ProgramPage, ProgramCubit> {
  @override
  Widget build(BuildContext context) {
    return EyeScaffold(
      title: 'Program',
      body: RefreshIndicator(
        onRefresh: () => cubit.refresh(),
        child: BaseStateConsumer(
          cubit: cubit,
          onLoading: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          onData: (context, uiModel) {
            return _buildProgramTabs(uiModel);
          },
        ),
      ),
      bottomNavigationBar: true,
    );
  }

  Widget _buildProgramTabs(ProgramPageUiModel uiModel) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Thursday'),
              Tab(text: 'Friday'),
              Tab(text: 'Saturday'),
              Tab(text: 'Sunday'),
            ],
          ),
          _buildFilterChips(uiModel),
          Expanded(
            child: TabBarView(
              children: [
                _buildDayContent(uiModel, 'Thursday'),
                _buildDayContent(uiModel, 'Friday'),
                _buildDayContent(uiModel, 'Saturday'),
                _buildDayContent(uiModel, 'Sunday'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayContent(ProgramPageUiModel uiModel, String day) {
    final dayProgram = uiModel.programs.firstWhere((p) => p.day == day).events;
    final filteredEvents = dayProgram
        .where((event) =>
            event.name == 'Arrival' ||
            uiModel.selectedFilters.contains(event.area.name))
        .toList();
    return RefreshIndicator(
      onRefresh: () => cubit.refresh(),
      child: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          final event = filteredEvents[index];
          return ListTile(
            title: Text(
              event.name,
              style: TextStyle(
                fontFamily: 'Edmund',
                fontSize: 18,
              ),
            ),
            subtitle: Text('${event.startTime} - ${event.endTime}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapPage(
                          highlightedArea: event.area.name,
                        ),
                      ),
                    );
                  },
                  child: Chip(
                    label: Text(event.area.name),
                    labelStyle: TextStyle(fontSize: 12),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    event.favorite ? Icons.favorite : Icons.favorite_border,
                    color: event.favorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    cubit.toggleFavorite(event.name);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChips(ProgramPageUiModel uiModel) {
    final labels = [
      'Main',
      'Music',
      'Seminar',
      'Prayer',
      'Creative',
      'Sports',
      'Chill',
      'Food'
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            ...labels.map((label) => _buildFilterChip(uiModel, label)),
            _buildResetButton(uiModel),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(ProgramPageUiModel uiModel, String label) {
    final isSelected = uiModel.selectedFilters.contains(label);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          cubit.updateFilter(label, selected);
        },
      ),
    );
  }

  Widget _buildResetButton(ProgramPageUiModel uiModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: uiModel.areAllFiltersSelected
            ? cubit.removeAllFilters
            : cubit.resetFilters,
        child: Text(uiModel.areAllFiltersSelected ? 'Remove all' : 'Reset'),
      ),
    );
  }
}
