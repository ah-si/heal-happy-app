import 'package:flutter/material.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';

class CalendarLegend extends StatelessWidget {
  const CalendarLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.l10n.legendMessage),
        const SizedBox(height: kNormalPadding),
        _CalendarLegendRow(
          label: context.l10n.legendUrgency,
          color: kEventColorUrgency,
        ),
        _CalendarLegendRow(
          label: context.l10n.legendVisio,
          color: kEventColorVisio,
        ),
        _CalendarLegendRow(
          label: context.l10n.legendConsultation,
          color: kEventColorFaceToFace,
        ),
        /*_CalendarLegendRow(
          label: context.l10n.legendPending,
          color: kEventColorPending,
        ),*/
        _CalendarLegendRow(
          label: context.l10n.legendCancelled,
          color: kEventColorCancelled,
        ),
      ],
    );
  }
}

class _CalendarLegendRow extends StatelessWidget {
  final Color color;
  final String label;

  const _CalendarLegendRow({Key? key, required this.color, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ColoredBox(
          color: color,
          child: const SizedBox(
            width: kBigPadding,
            height: kBigPadding,
          ),
        ),
        const SizedBox(
          width: kSmallPadding,
        ),
        Expanded(child: Text(label)),
      ],
    );
  }
}
