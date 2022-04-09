import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/patient/stores/healer_availabilities_store.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HealerAvailability extends HookConsumerWidget {
  final String id;
  final String healerName;
  final HealerEventType eventType;

  const HealerAvailability({Key? key, required this.id, required this.eventType, required this.healerName}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = useMemoized(() => StoreInfo(id, eventType, context.isMobile), [id, eventType]);
    final store = ref.watch(availabilitiesStoreProvider(info));
    final controller = useScrollController();
    late Widget child;
    if (store.isLoading) {
      child = ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 230),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.all(kNormalPadding),
              child: Loading(),
            ),
          ],
        ),
      );
    } else if (store.availabilities?.error != null) {
      child = ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 230),
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                store.availabilities!.error!.cause.twoLiner(context),
                style: TextStyle(color: context.theme.errorColor),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      final slots = store.availabilities!.slots;
      bool isEmpty = true;
      for (var i = 0; i < slots.length; i++) {
        if (slots[i].slots.isNotEmpty) {
          isEmpty = false;
          break;
        }
      }

      const minWidth = 80.0;

      child = Scrollbar(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 230),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: store.currentPage > 0
                              ? () {
                                  store.previousAvailabilitiesHealers();
                                }
                              : null,
                          icon: const Icon(Icons.skip_previous_outlined)),
                      ...slots
                          .map(
                            (e) => SizedBox(width: minWidth, child: Text(e.date, textAlign: TextAlign.center)),
                          )
                          .toList(growable: false),
                      IconButton(
                          onPressed: store.currentPage == 0
                              ? () {
                                  store.nextAvailabilitiesHealers();
                                }
                              : null,
                          icon: const Icon(Icons.skip_next_outlined)),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: isEmpty
                      ? Center(
                          child: Text(
                            context.l10n.noAvailabilities,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : HookBuilder(
                          builder: (context) {
                            final controller = useScrollController();
                            return Scrollbar(
                              controller: controller,
                              isAlwaysShown: true,
                              child: SingleChildScrollView(
                                controller: controller,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: slots
                                      .map(
                                        (e) => SizedBox(
                                          width: minWidth,
                                          child: Column(
                                            children: [
                                              ...e.slots
                                                  .map((slot) => Padding(
                                                        padding: const EdgeInsets.all(kSmallPadding),
                                                        child: ActionChip(
                                                          label: Text(slot.label),
                                                          labelStyle: const TextStyle(color: Colors.white),
                                                          backgroundColor: context.primaryColor,
                                                          onPressed: () => _showEventPopup(context, ref, store, slot),
                                                        ),
                                                      ))
                                                  .toList(growable: false),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(growable: false),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(2, 2), spreadRadius: .5, blurRadius: 8),
      ]),
      child: child,
    );
  }

  void _showEventPopup(BuildContext context, WidgetRef ref, AvailabilitiesStore store, SlotInfo slot) {
    final controller = TextEditingController();
    var isUrgent = false;
    final formKey = GlobalKey<FormState>();
    showAppDialog(
      context,
      (_) => Text(context.l10n.takeRdv),
      (context) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.l10n.takeRdvConfirm(healerName, slot.label)),
            TextFormField(
              controller: controller,
              maxLines: 3,
              validator: (value) => isRequired(value, context),
              decoration: InputDecoration(
                label: Text(context.l10n.messageForHealer),
                hintText: context.l10n.hintReasonConsultation,
              ),
            ),
            Text(context.l10n.consultationLimit),
            HookBuilder(
              builder: (context) {
                final urgentState = useState(isUrgent);
                return CheckboxListTile(
                  value: urgentState.value,
                  onChanged: (value) async {
                    if (value!) {
                      final confirm = await showConfirm(context, context.l10n.eventUrgencyTitle, context.l10n.eventUrgencyDesc);
                      if (confirm) {
                        isUrgent = value;
                        urgentState.value = isUrgent;
                      }
                    } else {
                      isUrgent = value;
                      urgentState.value = isUrgent;
                    }
                  },
                  title: Text(context.l10n.eventIsUrgency),
                );
              },
            ),
          ],
        ),
      ),
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
            final userStore = ref.read(userStoreProvider);
            final success = await showLoadingDialog(context, (_) => Text(context.l10n.creatingRdv), () async {
              await store.createEvent(userStore.user!.id!, slot.roomId, eventType, slot.dateTime, controller.text, isUrgent);
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
}
