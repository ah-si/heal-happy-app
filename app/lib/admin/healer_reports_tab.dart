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
            style: TextStyle(color: context.theme.colorScheme.error),
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
          ExpansionTile(
            initiallyExpanded: (store.results?.stats.length ?? 0) == 0,
            title: Text(context.l10n.search),
            children: const [
              _SearchStats(),
            ],
          ),
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
                  Text(stats.name, style: context.textTheme.titleMedium),
                  Text(
                    store.specialities[stats.job] ?? stats.job,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: kSmallPadding),
                  Text(stats.adminAddress),
                  InkWell(
                    onTap: () {
                      launchUrlString('mailto:${stats.email}');
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
                        launchUrlString('tel:${stats.mobile}');
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
                Text(context.l10n.nbEventsFaceToFace(stats.totalEventsFaceToFace), style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(context.l10n.nbDuration(stats.totalDurationFaceToFace), style: const TextStyle(fontWeight: FontWeight.bold)),
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
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceEvenly,
        alignment: WrapAlignment.spaceEvenly,
        runSpacing: kNormalPadding,
        children: [
          _DateTimeRangeField(
            onDatesSelected: (range) {
              startState.value = range.start;
              endState.value = range.end;
            },
            label: context.l10n.rangeDate,
            start: startState.value,
            end: endState.value,
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
                launchUrlString(url);
              }
            },
            child: Text(context.l10n.exportButton),
          ),
        ],
      ),
    );
  }
}

class _DateTimeRangeField extends HookWidget {
  final DateTime? start;
  final DateTime? end;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final String label;
  final Function(DateTimeRange range) onDatesSelected;

  const _DateTimeRangeField({
    Key? key,
    this.start,
    this.end,
    this.lastDate,
    this.firstDate,
    required this.onDatesSelected,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: start == null ? '' : ('${kDateFormat.format(start!)} - ${kDateFormat.format(end!)}'));

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 220),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            final range = await showDateRangePicker(
              context: context,
              firstDate: firstDate ?? DateTime.now().subtract(const Duration(days: 365)),
              lastDate: lastDate ?? DateTime.now(),
              initialDateRange: start == null ? null : DateTimeRange(start: start!, end: end!),
            );
            if (range != null) {
              controller.text = ('${kDateFormat.format(range.start)} - ${kDateFormat.format(range.end)}');
              onDatesSelected(range);
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
