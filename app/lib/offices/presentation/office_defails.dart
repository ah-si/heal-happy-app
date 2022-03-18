import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/offices/stores/office_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart' hide OfficeInfo;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class OfficeDetailsScreen extends HookConsumerWidget {
  static const route = '/offices/:id';
  final Office? office;
  final String id;

  const OfficeDetailsScreen({required this.id, this.office, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final info = useMemoized(() => OfficeInfo(id, office), [id, office]);
    final store = ref.watch(officeStoreProvider(info));
    final controller = useScrollController();

    useEffect(() {
      store.loadOffice();
      return null;
    }, const []);

    late Widget child;

    if (store.result == null) {
      child = const Loading();
    } else if (store.result!.error != null) {
      child = Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.result!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else if (store.selectedTab == OfficeTabs.home) {
      child = Scrollbar(
        isAlwaysShown: true,
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          child: _OfficeDetails(
            office: store.result!.office!,
            store: store,
          ),
        ),
      );
    } else if (store.selectedTab == OfficeTabs.planing) {
      child = _OfficePlaning(
        store: store,
      );
    }

    return BgContainer(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SingleChildScrollView(
                  child: Row(
                    children: [
                      MenuItem(
                        label: context.l10n.backButton,
                        onTap: () {
                          try {
                            context.pop();
                          } catch (e) {
                            context.go('/');
                          }
                        },
                        selected: false,
                      ),
                      const SizedBox(width: kNormalPadding),
                      MenuItem(
                        label: store.result?.office?.name ?? '',
                        onTap: () {
                          store.selectedTab = OfficeTabs.home;
                        },
                        selected: store.selectedTab == OfficeTabs.home,
                      ),
                      const SizedBox(width: kSmallPadding),
                      MenuItem(
                        label: context.l10n.officePlaning,
                        onTap: () {
                          store.selectedTab = OfficeTabs.planing;
                        },
                        selected: store.selectedTab == OfficeTabs.planing,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OfficePlaning extends HookWidget {
  final OfficeStore store;

  const _OfficePlaning({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataSource = useMemoized(() => _CalendarDataSource(store.planingResult?.events ?? []), [store.planingResult?.events]);
    useEffect(() {
      store.loadPlaning();
      return null;
    }, const []);

    late Widget child;
    if (store.planingResult == null) {
      child = const Center(child: Loading());
    } else if (store.planingResult!.error != null) {
      child = Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            store.planingResult!.error!.cause.twoLiner(context),
            style: TextStyle(color: context.theme.errorColor),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      child = SfCalendar(
        firstDayOfWeek: 1,
        //cellEndPadding: 0,
        dataSource: dataSource,
        timeSlotViewSettings: const TimeSlotViewSettings(
          timeFormat: 'H:mm',
          timeInterval: Duration(hours: 1),
        ),
        allowViewNavigation: false,
        showNavigationArrow: true,
        showDatePickerButton: true,
        view: CalendarView.timelineWeek,
      );
    }

    return Center(child: child);
  }
}

class _CalendarDataSource extends CalendarDataSource<UserEvent> {
  final Map<String, Color> colorForRoom = {};

  _CalendarDataSource(List<UserEvent> items) {
    appointments = items;
    Set<OfficeRoom> rooms = {};
    for (var item in items) {
      if (!rooms.contains(item.room) && item.room != null) {
        rooms.add(item.room!);
        colorForRoom[item.room!.id!] = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      }
    }
    resources = rooms.map((e) => CalendarResource(id: e.id!, color: colorForRoom[e.id!]!, displayName: e.name)).toList();
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
    final UserEvent event = appointments![index];
    return colorForRoom[event.room!.id!]!;
  }

  @override
  String getSubject(int index) {
    final UserEvent event = appointments![index];

    return event.patient.firstName + ' ' + event.patient.lastName;
  }

  @override
  List<Object>? getResourceIds(int index) {
    final UserEvent event = appointments![index];

    return event.room == null ? null : [event.room!.id!];
  }
}

class _OfficeDetails extends StatelessWidget {
  final Office office;
  final OfficeStore store;

  const _OfficeDetails({Key? key, required this.office, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ManagerPanel(
          store: store,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kNormalPadding),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(kNormalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.l10n.manageOfficeRooms,
                          style: context.textTheme.headline6,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final roomName = await showPrompt(context, context.l10n.addRoom, label: context.l10n.nameField);
                          if (roomName != null) {
                            await showLoadingDialog(context, (_) => Text(context.l10n.sending), () => store.addRoom(roomName));
                          }
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const Divider(),
                  ...(store.result!.office!.rooms.toList()..sort((r1, r2) => r1.name.toLowerCase().compareTo(r2.name.toLowerCase()))).map(
                    (room) => _RoomPanel(store: store, room: room),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ManagerPanel extends StatelessWidget {
  final OfficeStore store;

  const _ManagerPanel({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.officeManagers,
                      style: context.textTheme.headline6,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final email = await showPrompt(context, context.l10n.addManager, label: context.l10n.emailField);
                        if (email != null) {
                          await showLoadingDialog(context, (_) => Text(context.l10n.sending), () => store.addManager(email));
                        }
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
              const Divider(),
              Wrap(
                spacing: kNormalPadding,
                runSpacing: kNormalPadding,
                children: store.result!.office!.managers
                    .map(
                      (manager) => Chip(
                        backgroundColor: Colors.cyanAccent.withOpacity(.3),
                        label: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(manager.name),
                            SelectableText(manager.email),
                            if (!manager.mobile.isNullOrEmpty) SelectableText(manager.mobile!),
                          ],
                        ),
                        onDeleted: () async {
                          final success = await showConfirm(context, context.l10n.deleteOfficePermission, context.l10n.deleteManagerConfirm);
                          if (success) {
                            showLoadingDialog(context, (_) => Text(context.l10n.deleting), () => store.removeManager(manager.id!));
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoomPanel extends StatelessWidget {
  final OfficeStore store;
  final OfficeRoom room;

  const _RoomPanel({
    Key? key,
    required this.store,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      room.name,
                      style: context.textTheme.headline6,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final success = await showConfirm(context, context.l10n.deleteRoom, context.l10n.deleteRoomConfirm);
                      if (success) {
                        await showLoadingDialog(context, (_) => Text(context.l10n.deleting), () => store.deleteRoom(room.id!));
                      }
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () async {
                      final name = await showPrompt(
                        context,
                        context.l10n.renameRoom,
                        label: context.l10n.nameField,
                        initialValue: room.name,
                      );
                      if (name != null) {
                        await showLoadingDialog(context, (_) => Text(context.l10n.sending), () => store.updateRoom(room.id!, name));
                      }
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ],
              ),
              const Divider(),
              _HealerPanel(roomId: room.id!, store: store),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealerPanel extends StatelessWidget {
  final OfficeStore store;
  final String roomId;

  const _HealerPanel({
    Key? key,
    required this.roomId,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.officeHealers,
                      style: context.textTheme.headline6,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final email = await showPrompt(context, context.l10n.addOfficeHealer, label: context.l10n.emailField);
                        if (email != null) {
                          await showLoadingDialog(context, (_) => Text(context.l10n.sending), () => store.addHealer(roomId, email));
                        }
                      },
                      icon: const Icon(Icons.add)),
                ],
              ),
              const Divider(),
              Wrap(
                spacing: kNormalPadding,
                children: store.result!.office!.rooms
                    .firstWhere((room) => room.id == roomId)
                    .healers
                    .map(
                      (healer) => Chip(
                        backgroundColor: Colors.cyanAccent.withOpacity(.3),
                        label: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(healer.name),
                            SelectableText(healer.email),
                            if (!healer.mobile.isNullOrEmpty) SelectableText(healer.mobile!),
                          ],
                        ),
                        onDeleted: () async {
                          final success = await showConfirm(context, context.l10n.deleteOfficePermission, context.l10n.deleteHealerConfirm);
                          if (success) {
                            showLoadingDialog(context, (_) => Text(context.l10n.deleting), () => store.removeHealer(roomId, healer.id!));
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
