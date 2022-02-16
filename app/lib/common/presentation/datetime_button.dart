import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';

class DateTimeButton extends HookWidget {
  final DateTime initialDate;
  final DateTime lastDate;
  final DateTime firstDate;
  final Function(DateTime) onDateChanged;

  const DateTimeButton({required this.onDateChanged, required this.initialDate, required this.lastDate, required this.firstDate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dynamicDate = useState(initialDate.toLocal());
    return HookBuilder(builder: (context) {
      return Row(
        children: [
          TextButton(
            onPressed: () async {
              final newDate = await showDatePicker(
                context: context,
                initialDate: dynamicDate.value,
                firstDate: firstDate.toLocal(),
                lastDate: lastDate.toLocal(),
              );
              if (newDate != null) {
                final d = dynamicDate.value.copyWith(year: newDate.year, month: newDate.month, day: newDate.day);
                onDateChanged(d);
                dynamicDate.value = d;
              }
            },
            child: Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: kSmallPadding),
                Text(kDateFormat.format(dynamicDate.value)),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(dynamicDate.value),
              );
              if (time != null) {
                final d = dynamicDate.value.copyWith(hour: time.hour, minute: time.minute);
                onDateChanged(d);
                dynamicDate.value = d;
              }
            },
            child: Row(
              children: [
                const Icon(Icons.access_time),
                const SizedBox(width: kSmallPadding),
                Text(kHourFormat.format(dynamicDate.value)),
              ],
            ),
          ),
        ],
      );
    });
  }
}
