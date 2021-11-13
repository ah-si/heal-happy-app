part of 'home_screen.dart';

class HealerReports extends HookConsumerWidget {
  const HealerReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(adminHealerStatsStoreProvider);

    late Widget child;

    if (store.isLoading) {
      child = const Loading();
    }

    if (store.results == null) {
      child = const SizedBox();
    } else if (store.results!.error != null) {
      child = Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.results!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (store.results!.stats.isEmpty) {
      child = Center(
        child: Text(
          context.l10n.emptyUsers,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      child = ListView.separated(
        itemBuilder: (context, index) {
          return _HealerStats(stats: store.results!.stats[index]);
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: store.results!.stats.length,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        children: [
          const _SearchStats(),
          const SizedBox(height: kNormalPadding),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _HealerStats extends HookConsumerWidget {
  final HealerStats stats;

  const _HealerStats({Key? key, required this.stats}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(stats.name, style: context.textTheme.subtitle1),
                  Text(
                    store.specialities[stats.job] ?? stats.job,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: kSmallPadding),
                  Text(stats.adminAddress),
                  InkWell(
                    onTap: () {
                      launch('mailto:${stats.email}');
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: stats.email));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.email_outlined),
                        const SizedBox(width: kSmallPadding),
                        Expanded(child: Text(stats.email)),
                      ],
                    ),
                  ),
                  if (!stats.mobile.isNullOrEmpty)
                    InkWell(
                      onTap: () {
                        launch('tel:${stats.mobile}');
                      },
                      onLongPress: () {
                        Clipboard.setData(ClipboardData(text: stats.mobile));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.phoneCopied)));
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.call_outlined),
                          const SizedBox(width: kSmallPadding),
                          Text(stats.mobile!),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Column(
              children: [
                Text(context.l10n.nbEvents(stats.totalEvents), style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(context.l10n.nbDuration(stats.totalDuration), style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchStats extends HookConsumerWidget {
  const _SearchStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = useState<DateTime?>(null);
    final endState = useState<DateTime?>(null);
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
            onDateSelected: (DateTime date) {
              endState.value = date;
            },
            value: endState.value,
          ),
          ElevatedButton(
            onPressed: () {
              if (startState.value != null && endState.value != null) {
                final store = ref.read(adminHealerStatsStoreProvider);
                store.getStats(startState.value!, endState.value!);
              }
            },
            child: Text(context.l10n.searchButton),
          ),
          ElevatedButton(
            onPressed: () {
              if (startState.value != null && endState.value != null) {
                String url = '${Config().baseUrl}/api/v1/admin/healers/stats?';
                if (startState.value != null) {
                  final serialized = serializers.serialize(
                    startState.value!.toDate(),
                    specifiedType: const FullType(Date),
                  );
                  url += 'start=$serialized&';
                }
                if (endState.value != null) {
                  final serialized = serializers.serialize(
                    endState.value!.toDate(),
                    specifiedType: const FullType(Date),
                  );
                  url += 'end=$serialized&';
                }
                final token = BackendApiProvider().getToken();
                url += 'token=$token&';
                launch(url);
              }
            },
            child: Text(context.l10n.exportButton),
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

class _DateTimeField extends HookWidget {
  final DateTime? value;
  final String label;
  final Function(DateTime date) onDateSelected;
  static final _dateFormatter = DateFormat('dd/MM/yyyy');

  const _DateTimeField({
    Key? key,
    this.value,
    required this.onDateSelected,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: value == null ? '' : _dateFormatter.format(value!));

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 200),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
            );
            if (date != null) {
              controller.text = _dateFormatter.format(date);
              onDateSelected(date);
            }
          },
          child: IgnorePointer(
            child: TextField(
              readOnly: true,
              controller: controller,
              decoration: InputDecoration(label: Text(label)),
            ),
          ),
        ),
      ),
    );
  }
}
