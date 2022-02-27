part of 'home_screen.dart';

class _HealerEvents extends HookConsumerWidget {
  const _HealerEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(healerStoreProvider);
    final userStore = ref.watch(userStoreProvider);
    final hideCancelled = useState(true);
    final seeOnlyUrgency = useState(false);
    final _dataSource = useMemoized(
      () => _ConsultationDataSource(store.eventsResults?.events.where((element) {
            if (seeOnlyUrgency.value) {
              if (hideCancelled.value) {
                return element.isCancelled == false && element.isUrgent;
              }
              return element.isUrgent;
            } else if (hideCancelled.value) {
              return !element.isCancelled;
            }
            return true;
          }).toList() ??
          []),
      [hideCancelled.value, seeOnlyUrgency.value, store.eventsResults],
    );

    useEffect(() {
      store.loadEvents();
      return null;
    }, const []);

    if (store.eventsResults == null || store.isLoading) {
      return Center(
        child: SizedBox(
          child: const Loading(),
          height: MediaQuery.of(context).size.height,
        ),
      );
    }

    if (store.eventsResults?.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.eventsResults!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (store.eventUrgent > 0)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 410),
                child: CheckboxListTile(
                  value: seeOnlyUrgency.value,
                  onChanged: (value) {
                    seeOnlyUrgency.value = value!;
                  },
                  title: Text(
                    context.l10n.seeOnlyUrgencies,
                  ),
                ),
              ),
            if (store.eventCancelled > 0)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: CheckboxListTile(
                  value: hideCancelled.value,
                  onChanged: (value) {
                    hideCancelled.value = value!;
                  },
                  title: Text(context.l10n.hideCancelled),
                ),
              ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              SfCalendar(
                view: context.isMobile ? CalendarView.schedule : CalendarView.week,
                firstDayOfWeek: 1,
                timeSlotViewSettings: TimeSlotViewSettings(
                  timeFormat: 'H:mm',
                  timeInterval: Duration(minutes: userStore.user?.consultationDuration ?? 60),
                ),
                showDatePickerButton: true,
                showCurrentTimeIndicator: true,
                onViewChanged: (details) {},
                onTap: (event) {
                  if (event.targetElement == CalendarElement.calendarCell && (event.appointments ?? []).isEmpty) {
                    final userStore = ref.read(userStoreProvider);
                    createEvent(context, event, store, userStore);
                  } else if (event.targetElement == CalendarElement.appointment) {
                    showEvent(context, event);
                  }
                },
                showWeekNumber: true,
                showNavigationArrow: true,
                dataSource: _dataSource,
                monthViewSettings: const MonthViewSettings(showAgenda: true),
                allowedViews: const [
                  CalendarView.day,
                  CalendarView.week,
                  CalendarView.month,
                  CalendarView.schedule,
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(kSmallPadding),
                  child: ElevatedButton(
                    onPressed: () {
                      showAppDialog(
                        context,
                        (_) => Text(context.l10n.calendarEventsLegend),
                        (context) => const CalendarLegend(),
                      );
                    },
                    child: Text(context.l10n.showCalendarLegend),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void createEvent(
    BuildContext context,
    CalendarTapDetails event,
    HealerStore store,
    UserStore userStore,
  ) {
    final formKey = GlobalKey<FormState>();
    DateTime date = event.date!;
    HealerEventType type = HealerEventType.visio;
    final email = TextEditingController();
    final message = TextEditingController();
    final firstName = TextEditingController();
    final lastName = TextEditingController();
    final mobile = TextEditingController();
    String? roomId;
    var showPatientForm = false;
    final listener = ChangeNotifier();
    showAppDialog(
      context,
      (_) => Text(context.l10n.createRdv),
      (context) => HookBuilder(builder: (context) {
        useListenable(listener);
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateTimeButton(
                initialDate: date,
                firstDate: date.copyWith(day: 1),
                lastDate: date.add(const Duration(days: 25)),
                onDateChanged: (newDate) {
                  date = newDate;
                },
              ),
              if (userStore.user?.canDoFaceToFace ?? false)
                DropdownButtonFormField<HealerEventType>(
                  items: HealerEventType.values
                      .map((e) => DropdownMenuItem(
                            child: Text(context.l10n.consultationLabel(e)),
                            value: e,
                          ))
                      .toList(growable: false),
                  decoration: InputDecoration(labelText: context.l10n.consultationType),
                  isExpanded: true,
                  value: type,
                  onChanged: (value) {
                    type = value!;
                    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                    listener.notifyListeners();
                  },
                ),
              if (type == HealerEventType.faceToFace && store.rooms.isNotEmpty)
                DropdownButtonFormField<String>(
                  items: store.rooms
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e.room.name + ' (${e.office.name})'),
                          value: e.room.id,
                        ),
                      )
                      .toList(growable: false),
                  decoration: InputDecoration(labelText: context.l10n.consultationAddress),
                  isExpanded: true,
                  value: null,
                  onChanged: (value) {
                    roomId = value;
                  },
                ),
              TextFormField(
                controller: email,
                validator: (value) => isRequired(value, context),
                decoration: InputDecoration(
                  labelText: context.l10n.patientEmailField,
                ),
              ),
              if (showPatientForm)
                TextFormField(
                  controller: firstName,
                  validator: (value) => isRequired(value, context),
                  decoration: InputDecoration(
                    labelText: context.l10n.patientFirstNameField,
                  ),
                ),
              if (showPatientForm)
                TextFormField(
                  controller: lastName,
                  validator: (value) => isRequired(value, context),
                  decoration: InputDecoration(
                    labelText: context.l10n.patientNameField,
                  ),
                ),
              if (showPatientForm)
                TextFormField(
                  controller: mobile,
                  validator: (value) => isRequired(value, context),
                  decoration: InputDecoration(
                    labelText: context.l10n.patientPhoneField,
                  ),
                ),
              TextFormField(
                controller: message,
                validator: (value) => isRequired(value, context),
                decoration: InputDecoration(
                  labelText: context.l10n.messageForPatient,
                ),
                maxLines: 3,
              ),
            ],
          ),
        );
      }),
      actions: [
        DialogAction(
          text: MaterialLocalizations.of(context).cancelButtonLabel,
          callback: (BuildContext context) {
            Navigator.of(context).pop();
          },
        ),
        DialogAction(
          text: MaterialLocalizations.of(context).okButtonLabel,
          callback: (BuildContext context) async {
            if (!(formKey.currentState?.validate() ?? false)) {
              return;
            }
            final success = await showLoadingDialog(context, (_) => Text(context.l10n.creatingRdv), () async {
              await store.createEvent(
                userStore.user!.id!,
                roomId,
                type,
                date,
                email.text,
                mobile.text,
                firstName.text,
                lastName.text,
                message.text,
              );
            }, onError: (err, stack) {
              if (err is ErrorResultException && err.cause == ErrorResult.noUser) {
                showPatientForm = true;
                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                listener.notifyListeners();
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  formKey.currentState?.validate();
                });
                showAlert(context, context.el10n.noUser, (_) => Text(context.el10n.noUserHint));
              } else {
                showErrorDialog(context, err, stack);
              }
            });
            if (success) {
              Navigator.of(context).pop();
              showAlert(context, context.l10n.rdvCreated, (_) => Text(context.l10n.rdvCreatedDescription));
            }
          },
        ),
      ],
    );
  }

  void showEvent(BuildContext context, CalendarTapDetails event) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final size = context.isMobile ? 0.75 : 0.6;
        return DraggableScrollableSheet(
          initialChildSize: size,
          maxChildSize: size,
          minChildSize: size,
          expand: true,
          builder: (context, controller) {
            return ColoredBox(
              color: Colors.white,
              child: _HealerEventDetails(event: event.appointments!.first),
            );
          },
        );
      },
    );
  }
}

class _ConsultationDataSource extends CalendarDataSource<UserEvent> {
  _ConsultationDataSource(List<UserEvent> events) {
    appointments = events;
  }

  @override
  Color getColor(int index) {
    if (appointments![index].isCancelled) {
      return kEventColorCancelled;
    } else if (appointments![index].isUrgent) {
      return kEventColorUrgency;
    } else if (appointments![index].type == HealerEventType.faceToFace) {
      return kEventColorFaceToFace;
    }
    return kEventColorVisio;
  }

  @override
  String? getLocation(int index) {
    return appointments![index].link;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end.toLocal();
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start.toLocal();
  }

  @override
  Object? getId(int index) {
    return appointments![index].id;
  }

  @override
  String? getNotes(int index) {
    return appointments![index].description;
  }

  @override
  String getSubject(int index) {
    return (appointments![index].patient as MinimalUser).name;
  }
}

class _HealerEventDetails extends HookConsumerWidget {
  final UserEvent event;

  static final DateFormat _dateFormat = DateFormat('EEE dd MMM à HH:mm');
  static final DateFormat _dateFormatCreation = DateFormat('EEE dd MMM');

  const _HealerEventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(kNormalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(_dateFormat.format(event.start.toLocal()), style: context.textTheme.headline6)),
                      if (!event.isCancelled && event.start.toLocal().isAfter(DateTime.now()))
                        IconButton(
                          onPressed: () async {
                            final now = DateTime.now();
                            var date = await showDatePicker(
                              context: context,
                              initialDate: event.start.toLocal(),
                              firstDate: now.subtract(Duration(days: now.day - 1)),
                              lastDate: now.add(
                                const Duration(days: 15),
                              ),
                            );
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(event.start.toLocal()),
                              );
                              if (time != null) {
                                date = date.toLocal().copyWith(hour: time.hour, minute: time.minute);
                                final message = await showPrompt(context, context.l10n.updateEventMessage);
                                if (message != null) {
                                  final store = ref.read(healerStoreProvider);
                                  final success = await showLoadingDialog(
                                    context,
                                    (_) => Text(context.l10n.sending),
                                    () => store.updateEvent(event, date!, message),
                                  );
                                  if (success) {
                                    context.pop();
                                  }
                                }
                              }
                            }
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      IconButton(
                        onPressed: () async {
                          context.navigator.pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: kSmallPadding),
                  const Divider(),
                  Text('Type: ' + context.l10n.consultationLabel(event.type), style: context.textTheme.subtitle2),
                  const SizedBox(height: kSmallPadding),
                  Text(context.l10n.yourPatient, style: context.textTheme.subtitle2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(event.patient.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(context.l10n.eventCreatedAt(_dateFormatCreation.format(event.createdAt.toLocal()))),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                        child: InkWell(
                          onTap: () {
                            launch('mailto:${event.patient.email}');
                          },
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(text: event.patient.email));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.email_outlined),
                              const SizedBox(width: kSmallPadding),
                              Expanded(child: Text(event.patient.email)),
                            ],
                          ),
                        ),
                      ),
                      if (!event.patient.mobile.isNullOrEmpty)
                        InkWell(
                          onTap: () {
                            launch('tel:${event.patient.mobile}');
                          },
                          onLongPress: () {
                            Clipboard.setData(ClipboardData(text: event.patient.mobile));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Téléphone'))));
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.call_outlined),
                              const SizedBox(width: kSmallPadding),
                              Text(event.patient.mobile),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: kSmallPadding),
                  if (event.isCancelled) Text(context.l10n.patientCancelledMessage, style: context.textTheme.subtitle2),
                  if (!event.isCancelled && !event.description.isNullOrEmpty) Text(context.l10n.patientMessage, style: context.textTheme.subtitle2),
                  if (!event.description.isNullOrEmpty || !event.cancelledDescription.isNullOrEmpty)
                    InkWell(
                      onTap: () {
                        showAlert(
                          context,
                          event.isCancelled ? context.l10n.patientCancelledMessage : context.l10n.patientMessage,
                          (context) => ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 300),
                            child: SingleChildScrollView(
                              child: Text(event.isCancelled ? event.cancelledDescription ?? 'Aucun' : event.description!),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        event.isCancelled ? event.cancelledDescription ?? 'Aucun' : event.description!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
          ),
          ButtonBar(
            children: [
              if (!event.isCancelled && event.start.toLocal().isAfter(DateTime.now()))
                TextButton(
                  onPressed: () async {
                    final message = await showPrompt(
                      context,
                      context.l10n.cancelConsultation,
                      validator: (value) => isRequired(value, context),
                      description: context.l10n.cancelConsultationConfirm(event.patient.name),
                      label: context.l10n.patientCancelledMessage,
                    );
                    if (!message.isNullOrEmpty) {
                      final cancelled = await showLoadingDialog(context, (_) => Text(context.l10n.canceling), () async {
                        await ref.read(healerStoreProvider).cancelEvent(event.id, message!);
                      });
                      if (cancelled) {
                        context.navigator.pop();
                        showAlert(context, context.l10n.cancelTitle, (_) => Text(context.l10n.consultationCanceled(event.healer.name)));
                      }
                    }
                  },
                  child: Text(context.l10n.cancelButton),
                ),
              if (event.type == HealerEventType.visio)
                TextButton(
                  onPressed: () {
                    ref.read(userStoreProvider).acceptEvent(event.id);
                    if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
                      launch(event.link);
                    } else {
                      var options = JitsiMeetingOptions(
                        roomNameOrUrl: event.link,
                        userDisplayName: event.healer.firstName,
                        subject: 'Consultation Soignez Heureux',
                      );
                      JitsiMeetWrapper.joinMeeting(options: options);
                    }
                  },
                  child: Text(context.l10n.joinVisioButton),
                ),
            ],
          )
        ],
      ),
    );
    return event.isUrgent || event.isCancelled
        ? Banner(
            location: BannerLocation.topStart,
            message: event.isCancelled ? 'Annulée' : 'Urgent',
            child: content,
          )
        : content;
  }
}
