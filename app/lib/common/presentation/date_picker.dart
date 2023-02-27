import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:heal_happy/common/utils/extensions.dart';

const double _kPickerSheetHeight = 232.0;

Future<TimeOfDay?> showModalTimePicker({
  required TimeOfDay? currentTime,
  required BuildContext context,
  TransitionBuilder? transitionBuilder,
}) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return _buildTimePickerIOS(context, currentTime!);
      },
    );
  }
  return showTimePicker(context: context, initialTime: currentTime!, builder: transitionBuilder);
}

Future<DateTime?> showModalDatePicker({
  required DateTime currentDate,
  required BuildContext context,
  DateTime? maxDate,
  DateTime? minDate,
}) {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return _buildDatePickerIOS(context, maxDate, minDate, currentDate);
      },
    );
  }
  return showDatePicker(context: context, initialDate: currentDate, firstDate: minDate!, lastDate: maxDate!);
}

Widget _buildTimePickerIOS(BuildContext context, TimeOfDay currentTime) {
  final localizations = context.l10n;
  final theme = Theme.of(context);
  var currentSelectedTime = currentTime;
  return Container(
    height: _kPickerSheetHeight,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {},
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context).pop(currentSelectedTime);
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: theme.primaryColor),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: Duration(minutes: currentTime.minute, hours: currentTime.hour),
                  onTimerDurationChanged: (duration) {
                    currentSelectedTime = TimeOfDay(hour: duration.inHours, minute: duration.inMinutes - duration.inHours * 60);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildDatePickerIOS(BuildContext context, DateTime? maxDate, DateTime? minDate, DateTime currentDate) {
  final localizations = context.l10n;
  final theme = Theme.of(context);
  var currentSelectedDate = currentDate;
  return Container(
    height: _kPickerSheetHeight,
    padding: const EdgeInsets.only(top: 6.0),
    color: CupertinoColors.white,
    child: DefaultTextStyle(
      style: const TextStyle(
        color: CupertinoColors.black,
        fontSize: 22.0,
      ),
      child: GestureDetector(
        // Blocks taps from propagating to the modal sheet and popping.
        onTap: () {},
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: [
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      localizations.cancel,
                      style: TextStyle(color: theme.textTheme.bodyText1!.color),
                    ),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pop(currentSelectedDate);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                ],
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoDatePicker(
                  maximumDate: maxDate,
                  minimumDate: minDate,
                  initialDateTime: currentDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (date) {
                    currentSelectedDate = date;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
