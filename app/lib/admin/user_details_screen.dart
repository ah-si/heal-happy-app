import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/user/home_screen.dart';
import 'package:heal_happy/user/user_profile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserDetailsScreen extends HookConsumerWidget {
  static const route = '/admin/healer/:id';
  final String id;

  const UserDetailsScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BgContainer(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    MenuItem(
                      label: context.l10n.backButton,
                      onTap: () {
                        context.goNamed(HomeScreen.name);
                      },
                      selected: false,
                    ),
                    const SizedBox(width: 2),
                  ],
                ),
                Expanded(
                  child: ColoredBox(
                    color: Colors.white.withOpacity(0.8),
                    child: UserProfile(id: id, showTerms: false),
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
