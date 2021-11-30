import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heal_happy/common/config.dart';
import 'package:heal_happy/common/presentation/bg_container.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/menu_item.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/healer/stores/healer_store.dart';
import 'package:heal_happy/user/user_profile.dart';
import 'package:heal_happy/user/user_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HealerHomeScreen extends HookConsumerWidget {
  const HealerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);
    final store = ref.watch(healerStoreProvider);

    late Widget child;

    switch (store.selectedTab) {
      case HomeTabs.home:
        child = const _HealerHomePage();
        break;
      case HomeTabs.profile:
        child = const UserProfile();
        break;
      case HomeTabs.history:
        child = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(kNormalPadding),
              child: Text(context.l10n.eventHistoryIntro),
            ),
            const Expanded(child: SingleChildScrollView(child: _HealerEvents(showHistory: true))),
          ],
        );
        break;
      case HomeTabs.help:
        child = const SingleChildScrollView(child: _Help());
        break;
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
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            MenuItem(
                              label: context.l10n.home,
                              onTap: () {
                                store.selectedTab = HomeTabs.home;
                              },
                              selected: store.selectedTab == HomeTabs.home,
                            ),
                            const SizedBox(width: 2),
                            MenuItem(
                              label: context.l10n.eventsHistory,
                              onTap: () {
                                store.selectedTab = HomeTabs.history;
                              },
                              selected: store.selectedTab == HomeTabs.history,
                            ),
                            const SizedBox(width: 2),
                            MenuItem(
                              label: context.l10n.profile,
                              onTap: () {
                                store.selectedTab = HomeTabs.profile;
                              },
                              selected: store.selectedTab == HomeTabs.profile,
                            ),
                            const SizedBox(width: 2),
                            MenuItem(
                              label: context.l10n.help,
                              onTap: () {
                                store.selectedTab = HomeTabs.help;
                              },
                              selected: store.selectedTab == HomeTabs.help,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    MenuItem(
                      label: context.l10n.disconnect,
                      onTap: () async {
                        final success = await showConfirm(context, context.l10n.disconnect, context.l10n.disconnectConfirm);
                        if (success) {
                          final store = ref.read(userStoreProvider);
                          store.logout();
                        }
                      },
                      selected: true,
                    ),
                  ],
                ),
                if (!(userStore.user?.isActivated ?? true))
                  ColoredBox(
                    color: context.theme.errorColor.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(kSmallPadding),
                      child: Column(
                        children: [
                          Text(
                            context.l10n.accountNotVerified,
                            style: const TextStyle(color: Colors.white),
                          ),
                          if (!userStore.activationEmailResent)
                            TextButton(
                              onPressed: () async {
                                final success = await showLoadingDialog(context, (_) => Text(context.l10n.sending), () => userStore.resendActivationLink());
                                if (success) {
                                  showAlert(context, context.l10n.resendActivationLinkTitle, (_) => Text(context.l10n.resendActivationLinkSuccess));
                                }
                              },
                              child: Text(context.l10n.resendActivationLink),
                            ),
                        ],
                      ),
                    ),
                  ),
                if (!(userStore.user?.isVerified ?? true))
                  ColoredBox(
                    color: context.theme.errorColor.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(kSmallPadding),
                      child: Text(
                        context.l10n.accountPending,
                        style: const TextStyle(color: Colors.white),
                      ),
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

class _Help extends HookConsumerWidget {
  const _Help();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.l10n.helpYoutube),
          const SizedBox(height: kNormalPadding),
          TextButton(
            onPressed: () {
              launch(kUrlYoutube);
            },
            onLongPress: () {
              Clipboard.setData(const ClipboardData(text: kUrlYoutube));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
            },
            child: const Text('Voir la chaine Youtube'),
          ),
          const SizedBox(height: kNormalPadding),
          if (userStore.user?.isVerified ?? false) Text(context.l10n.helpIntro),
          const SizedBox(height: kNormalPadding),
          if (userStore.user?.isVerified ?? false)
            TextButton(
              onPressed: () {
                launch(userStore.user!.telegramUrl);
              },
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: userStore.user!.telegramUrl));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.itemCopied('Email'))));
              },
              child: Text(userStore.user!.telegramUrl),
            ),
        ],
      ),
    );
  }
}

class _UploadFileCard extends StatelessWidget {
  final String description;
  final String dialogTitle;
  final Widget? downloadButton;
  final Function(FilePickerResult result) onFilePicked;

  const _UploadFileCard({
    Key? key,
    this.downloadButton,
    required this.description,
    required this.onFilePicked,
    required this.dialogTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kNormalPadding),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300, maxHeight: 150, minWidth: 200),
          child: Column(
            children: [
              Expanded(child: Text(description)),
              ButtonBar(
                children: [
                  if (downloadButton != null) downloadButton!,
                  TextButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        dialogTitle: dialogTitle,
                        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
                        type: FileType.custom,
                      );
                      if (result != null) {
                        onFilePicked(result);
                      }
                    },
                    child: Text(context.l10n.uploadButton),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealerHomePage extends HookConsumerWidget {
  const _HealerHomePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStore = ref.watch(userStoreProvider);

    final needFileUpload = !(userStore.user?.isVerified ?? false) && (userStore.user?.diplomaFile == null || userStore.user?.healerTermsFile == null);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (needFileUpload)
            Padding(
              padding: const EdgeInsets.all(kNormalPadding),
              child: Wrap(
                children: [
                  if (userStore.user?.diplomaFile == null)
                    _UploadFileCard(
                      description: context.l10n.diplomaUpload,
                      dialogTitle: context.l10n.diplomaDialogTitle,
                      onFilePicked: (FilePickerResult result) async {
                        await showLoadingDialog(
                          context,
                          (_) => Text(context.l10n.uploading),
                          () => userStore.uploadDiploma(result),
                        );
                      },
                    ),
                  if (userStore.user?.healerTermsFile == null)
                    _UploadFileCard(
                      description: context.l10n.termsUpload,
                      downloadButton: TextButton(
                        onPressed: () {
                          launch('${Config().baseUrl}/assets/assets/files/healerTerms.pdf');
                        },
                        child: Text(context.l10n.downloadTerms),
                      ),
                      dialogTitle: context.l10n.termsDialogTitle,
                      onFilePicked: (FilePickerResult result) async {
                        await showLoadingDialog(
                          context,
                          (_) => Text(context.l10n.uploading),
                          () => userStore.uploadTerms(result),
                        );
                      },
                    ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(kNormalPadding),
            child: Text(context.l10n.eventsDescription),
          ),
          const _HealerEvents(),
        ],
      ),
    );
  }
}

class _HealerEvents extends HookConsumerWidget {
  final bool showHistory;

  const _HealerEvents({this.showHistory = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(healerStoreProvider);

    useEffect(() {
      store.loadEvents(showHistory);
    }, const []);

    if (store.eventsResults == null || store.isLoading) {
      return SizedBox(
        child: const Loading(),
        height: MediaQuery.of(context).size.height,
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

    if (store.eventsResults!.events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Text(
            showHistory ? context.l10n.noEventHistory : context.l10n.noEvents,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(kNormalPadding),
      child: Wrap(
        children: store.eventsResults!.events.map((e) => _HealerEventDetails(event: e)).toList(growable: false),
      ),
    );
  }
}

class _HealerEventDetails extends HookConsumerWidget {
  final UserEvent event;

  static final DateFormat _dateFormat = DateFormat('EEE dd MMM à HH:mm');

  const _HealerEventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320, maxHeight: 280),
      child: Card(
        margin: const EdgeInsets.all(kSmallPadding),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kNormalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(_dateFormat.format(event.start), style: context.textTheme.headline6),
                    const SizedBox(height: kSmallPadding),
                    Text(context.l10n.yourPatient, style: context.textTheme.subtitle2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(event.patient.name, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                    if (!event.description.isNullOrEmpty) Text(context.l10n.patientMessage, style: context.textTheme.subtitle2),
                    if (!event.description.isNullOrEmpty)
                      InkWell(
                        onTap: () {
                          showAlert(
                              context,
                              context.l10n.patientMessage,
                              (context) => ConstrainedBox(
                                  constraints: const BoxConstraints(maxHeight: 300), child: SingleChildScrollView(child: Text(event.description!))));
                        },
                        child: Text(
                          event.description!,
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
                if (event.start.isAfter(DateTime.now()))
                  TextButton(
                    onPressed: () async {
                      final success = await showConfirm(context, context.l10n.cancelConsultation, context.l10n.cancelConsultationConfirm(event.patient.name));
                      if (success) {
                        final cancelled = await showLoadingDialog(context, (_) => Text(context.l10n.canceling), () async {
                          await ref.read(healerStoreProvider).cancelEvent(event.id);
                        });
                        if (cancelled) {
                          showAlert(context, context.l10n.cancelTitle, (_) => Text(context.l10n.consultationCanceled(event.healer.name)));
                        }
                      }
                    },
                    child: Text(context.l10n.cancelButton),
                  ),
                if (event.start.isAfter(DateTime.now()..subtract(const Duration(days: 1))))
                  TextButton(
                    onPressed: () {
                      launch(event.link);
                    },
                    child: Text(context.l10n.joinVisioButton),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
