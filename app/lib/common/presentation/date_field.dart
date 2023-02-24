import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/presentation/date_picker.dart';
import 'package:heal_happy/common/utils/date_utils.dart';

class DateFormField extends FormField<DateTime> {
  DateFormField({
    super.key,
    required String label,
    DateTime? date,
    DateTime? maxDate,
    bool withTime = false,
    DateTime? minDate,
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: date,
          builder: (FormFieldState<DateTime> state) {
            return HookBuilder(
              builder: (context) {
                useEffect(
                  () {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      state.didChange(date);
                    });
                    return null;
                  },
                  [date],
                );
                return _DateFormField(
                  onChange: state.didChange,
                  label: label,
                  date: date,
                  withTime: withTime,
                  error: state.errorText,
                  minDate: minDate,
                  maxDate: maxDate,
                );
              },
            );
          },
        );
}

class _DateFormField extends HookWidget {
  final String label;
  final DateTime? date;
  final DateTime? maxDate;
  final DateTime? minDate;
  final void Function(DateTime? date) onChange;
  final String? error;
  final bool withTime;

  const _DateFormField({
    required this.label,
    this.date,
    required this.onChange,
    this.maxDate,
    this.minDate,
    this.error,
    this.withTime = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (date != null) {
            controller.text = DateUtils().formatTo(date!);
          }
        });
        return null;
      },
      [date],
    );
    final now = DateTime.now();
    return MaterialButton(
      padding: const EdgeInsets.all(0),
      onPressed: () async {
        final selectedDate = await showModalDatePicker(
          context: context,
          currentDate: date ?? minDate ?? now,
          minDate: minDate ?? now.subtract(const Duration(days: 36500)), // 100 years ago
          maxDate: maxDate ?? now,
        );

        if (withTime && selectedDate != null) {
          final dateTime = date ?? minDate ?? now;
          final selectedTime = await showModalTimePicker(
            context: context,
            currentTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
          );
          final selectedDateAndTime = selectedTime == null
              ? null
              : DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
          onChange(selectedDateAndTime);
          if (selectedDateAndTime == null) {
            controller.text = '';
          } else {
            controller.text = DateUtils().formatTo(selectedDateAndTime, format: 'dd/MM/yyyy HH:mm');
          }
        } else {
          onChange(selectedDate);
          if (selectedDate == null) {
            controller.text = '';
          } else {
            controller.text = DateUtils().formatTo(selectedDate);
          }
        }
      },
      child: IgnorePointer(
        child: TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: const Icon(Icons.calendar_today),
            errorText: error,
          ),
        ),
      ),
    );
  }
}
