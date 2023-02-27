import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/auth/models/user_info.dart';
import 'package:heal_happy/common/errors.dart';
import 'package:heal_happy/common/l10n/common_localizations.dart';
import 'package:heal_happy/common/presentation/date_field.dart';
import 'package:heal_happy/common/presentation/datetime_button.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/healer/stores/healer_store.dart';
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
    final controllerPrice = useTextEditingController(text: userInfo.consultationPrice?.toString() ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final dataSource = useMemoized(() => _CalendarDataSource(openingStore.results?.slots ?? [], userStore.rooms, userStore.user?.id ?? '', context.l10n),
        [openingStore.results, userStore.rooms]);

    useEffect(() {
      openingStore.loadOpenings();
      userStore.loadOffices();
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
            style: TextStyle(color: context.theme.colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final suffixButton = ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          userInfo.consultationPrice = int.tryParse(controllerPrice.text);
          userInfo.consultationDuration = int.tryParse(controllerConsultation.text);
          onSave();
        }
      },
      child: Text(context.l10n.saveButton),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              if (userStore.requiredUser.type == UserTypeEnum.admin && !userInfo.isSuspended)
                DateFormField(
                  minDate: (userInfo.dateSubscription != null && userInfo.dateSubscription!.isBefore(DateTime.now())) ? userInfo.dateSubscription : DateTime.now(),
                  date: userInfo.dateSubscription,
                  maxDate: DateTime.now().add(const Duration(days: 360)),
                  label: context.l10n.adminHealerSubscription,
                  onSaved: (value) {
                    userInfo.dateSubscription = value?.add(const Duration(hours: 10));
                  },
                ),
              TextFormField(
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
                  suffix: (userInfo.isSuspended) ? suffixButton : null,
                ),
              ),
              if (!(userInfo.isSuspended))
                TextFormField(
                  controller: controllerPrice,
                  validator: (value) {
                    final result = isRequired(value, context);
                    final intValue = int.tryParse(value!);
                    if (result != null && intValue == null) {
                      return context.l10n.wrongConsultationPrice;
                    }
                    return result;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    label: Text(context.l10n.consultationDurationPrice),
                    hintText: context.l10n.consultationDurationPriceHint,
                    suffix: suffixButton,
                  ),
                ),

            ],
          ),
        ),
        const SizedBox(height: kSmallPadding),
        Text(
          context.l10n.calendarIntro,
          style: context.textTheme.titleSmall,
        ),
        const SizedBox(height: kSmallPadding),
        if (openingStore.isInMedicalOffice)
          CheckboxListTile(
            value: openingStore.showExternalOpenings,
            onChanged: (value) {
              openingStore.filterOpenings(value!);
            },
            contentPadding: EdgeInsets.zero,
            title: Text(context.l10n.calendarShowExternalOpenings),
            subtitle: Text(context.l10n.calendarShowExternalOpeningsDesc),
          ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SfCalendar(
                  firstDayOfWeek: 1,
                  monthViewSettings: const MonthViewSettings(showAgenda: true),
                  allowedViews: const [
                    CalendarView.week,
                    CalendarView.month,
                  ],
                  //cellEndPadding: 0,
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
                    final healerStore = ref.read(healerStoreProvider);
                    if (details.targetElement == CalendarElement.calendarCell) {
                      showOpeningDialog(context, userStore, healerStore, openingStore, details.date!, null);
                    } else if (details.targetElement == CalendarElement.appointment) {
                      final appointment = details.appointments!.first;
                      late HealerOpening opening;
                      if (appointment is Appointment) {
                        opening = openingStore.results!.slots.firstWhere((element) => element.id == appointment.id);
                      } else {
                        opening = appointment;
                      }
                      final canBeEdited = opening.userId == (userId ?? userStore.user?.id);
                      if (canBeEdited) {
                        showOpeningDialog(context, userStore, healerStore, openingStore, details.date!, opening);
                      }
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
    HealerStore healerStore,
    OpeningStore store,
    DateTime date,
    HealerOpening? opening,
  ) {
    OpeningType type = opening?.type ?? OpeningType.visio;
    OpeningRepeatType? repeat = opening?.repeat;
    String? roomId = opening?.roomId;
    DateTime start = opening?.start ?? date;
    DateTime end = opening?.end ?? date.add(const Duration(hours: 4));
    final listener = ChangeNotifier();
    showAppDialog(
      context,
      (_) => Text(context.l10n.openingPopupTitle),
      (context) {
        return HookBuilder(builder: (context) {
          useListenable(listener);
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
              if (userStore.user?.canDoFaceToFace ?? false)
                DropdownButtonFormField<OpeningType>(
                  items: OpeningType.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(context.l10n.openingLabel(e)),
                        ),
                      )
                      .toList(growable: false),
                  decoration: InputDecoration(labelText: context.l10n.openingType),
                  isExpanded: true,
                  value: type,
                  onChanged: (value) {
                    type = value!;
                    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                    listener.notifyListeners();
                  },
                ),
              if ((type == OpeningType.faceToFace || type == OpeningType.unavailable) && userStore.rooms.isNotEmpty)
                DropdownButtonFormField<String>(
                  items: userStore.rooms
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.room.id,
                          child: Text('${e.room.name} (${e.office.name})'),
                        ),
                      )
                      .toList(growable: false),
                  decoration: InputDecoration(labelText: context.l10n.consultationAddress),
                  isExpanded: true,
                  value: roomId,
                  onChanged: (value) {
                    roomId = value;
                  },
                ),
              DropdownButtonFormField<OpeningRepeatType>(
                items: [
                  DropdownMenuItem(
                    value: null,
                    child: Text(context.l10n.openingRepeatLabel(null)),
                  ),
                  ...OpeningRepeatType.values
                      .where((p0) => p0 != OpeningRepeatType.daily)
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(context.l10n.openingRepeatLabel(e)),
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
        });
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
            if (start.isAfter(end) || start == end) {
              showErrorDialog(context, ErrorResult.dateStartAfterEnd, null);
              return;
            }

            final success = await showLoadingDialog(context, (_) => Text(context.l10n.creatingRdv), () async {
              if (opening == null) {
                await store.createOpening(userStore.user!.id!, type, roomId, repeat, start, end);
              } else {
                await store.updateOpening(opening.rebuild((HealerOpeningBuilder b) {
                  b.repeat = repeat;
                  b.type = type;
                  b.roomId = roomId;
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
  final List<HealerRoom> rooms;
  final String currentUserId;

  _CalendarDataSource(List<HealerOpening> items, this.rooms, this.currentUserId, this.localizations) {
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
    if (opening.userId != currentUserId && opening.roomId != null) {
      return kEventColorCancelled;
    }
    switch (opening.type) {
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
        if (opening.userId != currentUserId && opening.roomId != null) {
          final room = rooms.firstWhereOrNull((element) => element.room.id == opening.roomId);
          return '${opening.user?.name ?? ''} ${room!.office.name} (${room.room.name})';
        } else if (opening.roomId != null) {
          final room = rooms.firstWhereOrNull((element) => element.room.id == opening.roomId);
          if (room == null) {
            return 'Cabinet supprimé';
          }
          return '${localizations.openingFaceToFace} ${room.office.name} (${room.room.name})';
        }
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
