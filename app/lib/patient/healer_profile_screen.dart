import 'package:flutter/material.dart' hide MenuItem;
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/patient/healer_availability.dart';
import 'package:heal_happy/patient/stores/healer_profile_store.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DesktopHealerProfile extends HookConsumerWidget {
  final String id;
  final HealerEventType eventType;

  const DesktopHealerProfile({required this.id, required this.eventType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(healerProfileStoreProvider(id));

    return BgContainer(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: Column(
                  children: [
                    Row(
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
                        const SizedBox(width: 2),
                      ],
                    ),
                    ColoredBox(
                      color: Colors.white.withOpacity(0.8),
                      child: Column(
                        children: [
                          HealerAvailability(
                            id: id,
                            eventType: eventType,
                            healerName: store.healerProfile?.profile?.name ?? '',
                          ),
                          if (store.healerProfile?.profile != null) _HealerInfo(healer: store.healerProfile!.profile!),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileHealerProfile extends HookConsumerWidget {
  final String id;
  final HealerEventType eventType;

  const MobileHealerProfile({required this.id, required this.eventType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(healerProfileStoreProvider(id));

    return BgContainer(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              children: [
                HealerAvailability(
                  id: id,
                  eventType: eventType,
                  healerName: store.healerProfile?.profile?.name ?? '',
                ),
                if (store.healerProfile?.profile != null) _HealerInfo(healer: store.healerProfile!.profile!),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(store.healerProfile?.profile?.name ?? ''),
      ),
    );
  }
}

class HealerProfileScreen extends HookConsumerWidget {
  static const route = '/healers/:id';
  final String id;
  final HealerEventType eventType;

  const HealerProfileScreen({Key? key, required this.eventType, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return context.isMobile ? MobileHealerProfile(id: id, eventType: eventType) : DesktopHealerProfile(id: id, eventType: eventType);
  }
}

class _HealerInfo extends HookConsumerWidget {
  final Healer healer;

  const _HealerInfo({Key? key, required this.healer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.read(userStoreProvider);
    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: ColoredBox(
        color: Colors.white.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!context.isMobile) Text(healer.name, style: context.textTheme.headline6),
              Text(store.specialities[healer.job] ?? '', style: context.textTheme.subtitle2),
              const SizedBox(height: kNormalPadding),
              Text(healer.address),
              if (!healer.description.isNullOrEmpty) const SizedBox(height: kNormalPadding),
              if (!healer.description.isNullOrEmpty)
                Text(
                  context.l10n.healerDescription,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              if (!healer.description.isNullOrEmpty) Text(healer.description!),
              if (!healer.diploma.isNullOrEmpty) const SizedBox(height: kNormalPadding),
              if (!healer.diploma.isNullOrEmpty)
                Text(
                  context.l10n.healerDiploma,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              if (!healer.diploma.isNullOrEmpty) Text(healer.diploma!),
              if (!healer.experiences.isNullOrEmpty) const SizedBox(height: kNormalPadding),
              if (!healer.experiences.isNullOrEmpty)
                Text(
                  context.l10n.healerExperiences,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              if (!healer.experiences.isNullOrEmpty) Text(healer.experiences!),
            ],
          ),
        ),
      ),
    );
  }
}
