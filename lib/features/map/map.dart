import 'package:eye2025/core/widgets/base_state_consumer.dart';
import 'package:eye2025/core/widgets/base_state_page.dart';
import 'package:eye2025/features/map/cubit/map_cubit.dart';
import 'package:eye2025/shared/widgets/eye_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:eye2025/features/program/models/program.dart';

class MapPage extends StatefulWidget {
  final String? highlightedArea;

  const MapPage({super.key, this.highlightedArea});

  @override
  State<MapPage> createState() => _MapPageState();
}

class CustomChip extends StatelessWidget {
  final Widget label;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry labelPadding;

  const CustomChip({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.padding,
    required this.labelPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: labelPadding,
        child: label,
      ),
    );
  }
}

class _MapPageState extends BaseStatePage<MapPage, MapCubit> {
  bool _showAllAreas = true;
  bool _showSanitary = false;
  bool _highlighted = false;

  @override
  void initState() {
    super.initState();
    if (widget.highlightedArea != null) {
      setState(() {
        _showAllAreas = true;
        _showSanitary =
            widget.highlightedArea == Area.Sanitary.toString().split('.').last;
        _highlighted = true;
      });
    }
  }

  Widget _buildCustomChip(String label, double top, double left,
      {bool highlighted = false}) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 1),
      top: top,
      left: left,
      child: CustomChip(
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            height: 0,
          ),
        ),
        backgroundColor: highlighted
            ? Colors.red.withOpacity(0.7)
            : Colors.black54.withOpacity(0.5),
        padding: EdgeInsets.zero,
        labelPadding: const EdgeInsets.all(4),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            _buildAllAreasChip(),
            _buildSanitaryChip(),
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllAreasChip() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text('Areas'),
        selected: _showAllAreas,
        onSelected: (selected) {
          setState(() {
            _showAllAreas = selected;
          });
        },
      ),
    );
  }

  Widget _buildSanitaryChip() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
        label: Text('Sanitary'),
        selected: _showSanitary,
        onSelected: (selected) {
          setState(() {
            _showSanitary = selected;
          });
        },
      ),
    );
  }

  Widget _buildResetButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _showAllAreas = true;
            _showSanitary = false;
          });
        },
        child: Text('Reset'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EyeScaffold(
      title: 'Map',
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: BaseStateConsumer(
              cubit: cubit,
              onLoading: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
              onData: (context, uiModel) => Center(
                child: PhotoView.customChild(
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  childSize: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/map.png'),
                      if (_showAllAreas) ...[
                        _buildCustomChip('Main Area', 410, 90,
                            highlighted: widget.highlightedArea == 'Main'),
                        _buildCustomChip('Food Area', 440, 110,
                            highlighted: widget.highlightedArea == 'Food'),
                        _buildCustomChip('Music Area', 400, 260,
                            highlighted: widget.highlightedArea == 'Music'),
                        _buildCustomChip('Seminar Area', 500, 80,
                            highlighted: widget.highlightedArea == 'Seminar'),
                        _buildCustomChip('Prayer Area', 435, 50,
                            highlighted: widget.highlightedArea == 'Prayer'),
                        _buildCustomChip('Creative Area', 360, 210,
                            highlighted: widget.highlightedArea == 'Creative'),
                        _buildCustomChip('Sports Area', 60, 230,
                            highlighted: widget.highlightedArea == 'Sports'),
                        _buildCustomChip('Chill Area', 465, 70,
                            highlighted: widget.highlightedArea == 'Chill'),
                      ],
                      if (_showSanitary) ...[
                        _buildCustomChip('Toilets', 190, 270,
                            highlighted: widget.highlightedArea == 'Toilets'),
                        _buildCustomChip('Toilets', 390, 350,
                            highlighted: widget.highlightedArea == 'Toilets'),
                        _buildCustomChip('Toilets', 410, 230,
                            highlighted: widget.highlightedArea == 'Toilets'),
                        _buildCustomChip('Toilets', 500, 100,
                            highlighted: widget.highlightedArea == 'Toilets'),
                        _buildCustomChip('Toilets', 440, 120,
                            highlighted: widget.highlightedArea == 'Toilets'),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: true,
    );
  }
}
