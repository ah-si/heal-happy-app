part of 'home_screen.dart';

class _Events extends HookConsumerWidget {
  const _Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminEventsSearchStoreProvider);
    late Widget child;
    if (store.isLoading) {
      child = const Loading();
    } else if (store.searchResults == null) {
      child = const SizedBox();
    } else if (store.searchResults!.error != null) {
      child = Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.searchResults!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (store.searchResults!.events.isEmpty) {
      child = Center(
        child: Text(
          context.l10n.emptyEvents,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      child = Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: store.searchResults!.events.map((item) {
                      return _EventItem(event: item);
                    }).toList(growable: false),
                  ),
                ),
              ),
            ),
            Pagination(
              total: store.searchResults!.totalPages,
              current: store.searchResults!.currentPage,
              onPageSelected: (int selectedPage) {
                store.loadEventsPage(selectedPage);
              },
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExpansionTile(
          initiallyExpanded: (store.searchResults?.events.length ?? 0) == 0,
          title: Text(context.l10n.search),
          children: [
            _EventsSearch(),
          ],
        ),
        Expanded(child: child),
      ],
    );
  }
}

class _EventsSearch extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = useState<DateTime?>(null);
    final endState = useState<DateTime?>(null);
    final urgent = useState<bool?>(null);
    final cancelled = useState<bool?>(null);
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        children: [
          _DateTimeField(
            label: context.l10n.startDate,
            onDateSelected: (DateTime date) {
              startState.value = date;
            },
            value: startState.value,
          ),
          _DateTimeField(
            label: context.l10n.endDate,
            lastDate: DateTime.now().add(const Duration(days: 1)),
            onDateSelected: (DateTime date) {
              endState.value = date;
            },
            value: endState.value ?? DateTime.now().add(const Duration(days: 1)),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: CheckboxListTile(
              value: urgent.value,
              onChanged: (value) {
                urgent.value = value;
              },
              tristate: true,
              title: Text(context.l10n.adminEventIsUrgency, maxLines: 1),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: CheckboxListTile(
              value: cancelled.value,
              onChanged: (value) {
                cancelled.value = value;
              },
              tristate: true,
              title: Text(context.l10n.adminEventIsCancelled, maxLines: 1),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (startState.value != null && endState.value != null) {
                final store = ref.read(adminEventsSearchStoreProvider);
                store.getEvents(0, startState.value!, endState.value!, urgent.value, cancelled.value);
              }
            },
            child: Text(context.l10n.searchButton),
          ),
        ],
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceEvenly,
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: kNormalPadding,
      ),
    );
  }
}

class _EventItem extends HookConsumerWidget {
  final AdminUserEvent event;

  static final DateFormat _dateFormat = DateFormat('EEE dd MMM à HH:mm');
  static final DateFormat _dateFormatCreation = DateFormat('EEE dd MMM');

  const _EventItem({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = Column(
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
                                final store = ref.read(adminEventsSearchStoreProvider);
                                showLoadingDialog(
                                  context,
                                  (_) => Text(context.l10n.sending),
                                  () => store.updateEvent(event, date!, message),
                                );
                              }
                            }
                          }
                        },
                        icon: const Icon(Icons.edit),
                      ),
                  ],
                ),
                Text(context.l10n.eventCreatedAt(_dateFormatCreation.format(event.createdAt.toLocal()))),
                const SizedBox(height: kSmallPadding),
                Text(context.l10n.yourHealer, style: context.textTheme.subtitle2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(event.healer.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                      child: InkWell(
                        onTap: () {
                          launch('mailto:${event.healer.email}');
                        },
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: event.healer.email));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email_outlined),
                            const SizedBox(width: kSmallPadding),
                            Expanded(child: Text(event.healer.email)),
                          ],
                        ),
                      ),
                    ),
                    if (!event.healer.mobile.isNullOrEmpty)
                      InkWell(
                        onTap: () {
                          launch('tel:${event.healer.mobile}');
                        },
                        onLongPress: () {
                          Clipboard.setData(ClipboardData(text: event.healer.mobile));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Téléphone'))));
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.call_outlined),
                            const SizedBox(width: kSmallPadding),
                            Text(event.healer.mobile!),
                          ],
                        ),
                      ),
                  ],
                ),
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
                            Text(event.patient.mobile!),
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
            if (!event.isCancelled)
              TextButton(
                onPressed: () async {
                  final message = await showPrompt(context, context.l10n.cancelConsultation,
                      validator: (value) => isRequired(value, context), description: context.l10n.cancelConsultationConfirm(event.patient.name));
                  if (!message.isNullOrEmpty) {
                    final cancelled = await showLoadingDialog(context, (_) => Text(context.l10n.canceling), () async {
                      await ref.read(adminEventsSearchStoreProvider).cancelEvent(event.id, message!);
                    });
                    if (cancelled) {
                      showAlert(context, context.l10n.cancelTitle, (_) => Text(context.l10n.consultationCanceled(event.healer.name)));
                    }
                  }
                },
                child: Text(context.l10n.cancelButton),
              ),
          ],
        )
      ],
    );
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 450),
      child: Card(
        margin: const EdgeInsets.all(kSmallPadding),
        child: event.isUrgent || event.isCancelled
            ? Banner(
                location: BannerLocation.topEnd,
                message: event.isUrgent ? 'Urgent' : 'Annulée',
                child: content,
              )
            : content,
      ),
    );
  }
}
