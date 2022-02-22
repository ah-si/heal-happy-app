import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/l10n/common_localizations.dart';
import 'package:heal_happy/common/presentation/datetime_button.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/profile/store/opening_store.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class StepCalendarInfo extends HookConsumerWidget {
  final VoidCallback onSave;
  final String? userId;

  const StepCalendarInfo({required this.onSave, this.userId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final openingStore = ref.watch(openingStoreProvider(userId));
    final userStore = ref.watch(userStoreProvider);
    final userInfo = ref.watch(userInfoProvider);
    final controllerConsultation = useTextEditingController(text: userInfo.consultationDuration?.toString() ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final dataSource = useMemoized(() => _CalendarDataSource(openingStore.results?.slots ?? [], context.l10n), [openingStore.results]);

    useEffect(() {
      openingStore.loadOpenings();
      return null;
    }, const []);

    if (openingStore.results == null) {
      return const Loading();
    }

    if (openingStore.results?.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            openingStore.results!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: formKey,
          child: TextFormField(
            controller: controllerConsultation,
            validator: (value) {
              final result = isRequired(value, context);
              final intValue = int.tryParse(value!) ?? 0;
              if (result == null && (intValue < 30 || intValue > 120)) {
                return context.l10n.wrongConsultationDuration;
              }
              return result;
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              label: Text(context.l10n.consultationDurationField),
              hintText: context.l10n.consultationDurationHint,
              suffix: ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    userInfo.consultationDuration = int.tryParse(controllerConsultation.text);
                    onSave();
                  }
                },
                child: Text(context.l10n.saveButton),
              ),
            ),
          ),
        ),
        const SizedBox(height: kSmallPadding),
        Text(
          context.l10n.calendarIntro,
          style: context.textTheme.subtitle2,
        ),
        const SizedBox(height: kSmallPadding),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SfCalendar(
                  firstDayOfWeek: 1,
                  cellEndPadding: 0,
                  dataSource: dataSource,
                  timeSlotViewSettings: const TimeSlotViewSettings(
                    timeFormat: 'H:mm',
                    timeInterval: Duration(hours: 2),
                  ),
                  allowViewNavigation: false,
                  showNavigationArrow: true,
                  showDatePickerButton: true,
                  view: CalendarView.week,
                  onTap: (details) {
                    if (details.targetElement == CalendarElement.calendarCell) {
                      showOpeningDialog(context, userStore, openingStore, details.date!, null);
                    } else if (details.targetElement == CalendarElement.appointment) {
                      final appointment = details.appointments!.first;
                      late HealerOpening opening;
                      if (appointment is Appointment) {
                        opening = openingStore.results!.slots.firstWhere((element) => element.id == appointment.id);
                      } else {
                        opening = appointment;
                      }
                      showOpeningDialog(context, userStore, openingStore, details.date!, opening);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showOpeningDialog(
    BuildContext context,
    UserStore userStore,
    OpeningStore store,
    DateTime date,
    HealerOpening? opening,
  ) {
    OpeningType type = opening?.type ?? OpeningType.visio;
    OpeningRepeatType? repeat = opening?.repeat;
    DateTime start = opening?.start ?? date;
    DateTime end = opening?.end ?? date.add(const Duration(hours: 4));
    showAppDialog(
      context,
      (_) => Text(context.l10n.openingPopupTitle),
      (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.l10n.startDate),
            DateTimeButton(
              initialDate: start,
              firstDate: start.copyWith(day: 1),
              lastDate: start.add(const Duration(days: 25)),
              onDateChanged: (newDate) {
                start = newDate;
              },
            ),
            const SizedBox(height: kSmallPadding),
            Text(context.l10n.endDate),
            DateTimeButton(
              initialDate: end,
              firstDate: end.copyWith(day: 1),
              lastDate: end.add(const Duration(days: 25)),
              onDateChanged: (newDate) {
                end = newDate;
              },
            ),
            DropdownButtonFormField<OpeningType>(
              items: OpeningType.values
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(context.l10n.openingLabel(e)),
                      value: e,
                    ),
                  )
                  .toList(growable: false),
              decoration: InputDecoration(labelText: context.l10n.openingType),
              isExpanded: true,
              value: type,
              onChanged: (value) {
                type = value!;
              },
            ),
            DropdownButtonFormField<OpeningRepeatType>(
              items: [
                DropdownMenuItem(
                  child: Text(context.l10n.openingRepeatLabel(null)),
                  value: null,
                ),
                ...OpeningRepeatType.values
                    .where((p0) => p0 != OpeningRepeatType.daily)
                    .map((e) => DropdownMenuItem(
                          child: Text(context.l10n.openingRepeatLabel(e)),
                          value: e,
                        ))
                    .toList(growable: false)
              ],
              decoration: InputDecoration(labelText: context.l10n.openingRepeat),
              isExpanded: true,
              value: repeat,
              onChanged: (value) {
                repeat = value;
              },
            ),
          ],
        );
      },
      actions: [
        DialogAction(
          text: MaterialLocalizations.of(context).cancelButtonLabel,
          callback: (BuildContext context) {
            Navigator.of(context).pop();
          },
        ),
        if (opening != null)
          DialogAction(
            text: MaterialLocalizations.of(context).deleteButtonTooltip.toUpperCase(),
            callback: (BuildContext context) async {
              final confirm = await showConfirm(context, context.l10n.deleteOpening, context.l10n.deleteOpeningMessage);
              if (confirm) {
                final success = await showLoadingDialog(
                  context,
                  (_) => Text(context.l10n.deleting),
                  () async {
                    await store.deleteOpening(opening.id!);
                  },
                );
                if (success) {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        DialogAction(
          text: MaterialLocalizations.of(context).okButtonLabel,
          callback: (BuildContext context) async {
            if (start.isAfter(end)) {
              showErrorDialog(context, ErrorResult.dateStartAfterEnd, null);
              return;
            }

            final success = await showLoadingDialog(context, (_) => Text(context.l10n.creatingRdv), () async {
              if (opening == null) {
                await store.createOpening(userStore.user!.id!, type, repeat, start, end);
              } else {
                await store.updateOpening(opening.rebuild((HealerOpeningBuilder b) {
                  b.repeat = repeat;
                  b.type = type;
                  b.start = start.toUtc();
                  b.end = end.toUtc();
                  b.userId = userStore.user!.id!;
                  return b;
                }));
              }
            });
            if (success) {
              Navigator.of(context).pop();
              showAlert(context, context.l10n.openingCreated, (_) => Text(context.l10n.openingCreatedDescription));
            }
          },
        ),
      ],
    );
  }
}

class _CalendarDataSource extends CalendarDataSource<HealerOpening> {
  final CommonLocalizations localizations;

  _CalendarDataSource(List<HealerOpening> items, this.localizations) {
    appointments = items;
  }

  @override
  Object? getId(int index) {
    return appointments![index].id;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start.toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end.toLocal();
  }

  @override
  Color getColor(int index) {
    final HealerOpening opening = appointments![index];
    switch (opening.type){
      case OpeningType.faceToFace:
        return kEventColorFaceToFace;
      case OpeningType.unavailable:
        return kEventColorCancelled;
      case OpeningType.visio:
        return kEventColorVisio;
    }
    return Colors.yellow.shade700;
  }

  @override
  String getSubject(int index) {
    final HealerOpening opening = appointments![index];
    switch (opening.type) {
      case OpeningType.faceToFace:
        return localizations.openingFaceToFace;
      case OpeningType.unavailable:
        return localizations.openingUnavailable;
      case OpeningType.visio:
        return localizations.openingVisio;
    }
    return super.getSubject(index);
  }

  @override
  String? getRecurrenceRule(int index) {
    final HealerOpening event = appointments![index];
    final start = event.start;
    if (event.repeat == null) {
      return null;
    }
    RecurrenceProperties recurrenceProperty;

    switch (event.repeat) {
      case OpeningRepeatType.weekly:
        recurrenceProperty = RecurrenceProperties(startDate: start, recurrenceType: RecurrenceType.weekly, weekDays: [WeekDaysExtension.from(start)]);
        break;
      case OpeningRepeatType.monthly:
        recurrenceProperty = RecurrenceProperties(
          startDate: start,
          recurrenceType: RecurrenceType.monthly,
          dayOfMonth: start.day,
        );
        break;
      default:
        recurrenceProperty = RecurrenceProperties(
          startDate: start,
          recurrenceType: RecurrenceType.daily,
        );
        break;
    }

    return SfCalendar.generateRRule(
      recurrenceProperty,
      start,
      start,
    );
  }
}
