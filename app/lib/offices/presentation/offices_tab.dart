
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_happy/common/presentation/dialogs.dart';
import 'package:heal_happy/common/presentation/loading.dart';
import 'package:heal_happy/common/presentation/pagination.dart';
import 'package:heal_happy/common/utils/constants.dart';
import 'package:heal_happy/common/utils/extensions.dart';
import 'package:heal_happy/common/utils/form_validators.dart';
import 'package:heal_happy/offices/presentation/office_defails.dart';
import 'package:heal_happy/offices/stores/offices_store.dart';
import 'package:heal_happy_sdk/heal_happy_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Offices extends HookConsumerWidget {
  const Offices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(officesStoreProvider);

    useEffect(() {
      store.loadOffices(0);
      return null;
    }, const []);

    late Widget child;
    Widget addButton = FloatingActionButton(
      onPressed: () {
        showAppDialog(context, (_) => Text(context.l10n.addOffice), (_) => const _OfficeForm(office: null));
      },
      child: const Icon(Icons.add),
    );
    if (store.isLoading || store.results == null) {
      child = const Loading();
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
    } else if (store.results!.offices.isEmpty) {
      child = Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: addButton,
        body: Center(
          child: Text(
            context.l10n.emptyOffices,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      child = Scaffold(
        floatingActionButton: addButton,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(kNormalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return _OfficeItem(office: store.results!.offices[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 1);
                  },
                  itemCount: store.results!.offices.length,
                ),
              ),
              Pagination(
                total: store.results!.totalPages,
                current: store.results!.currentPage,
                onPageSelected: (int selectedPage) {
                  store.loadOffices(selectedPage);
                },
              ),
            ],
          ),
        ),
      );
    }

    return child;
  }
}

class _OfficeItem extends StatelessWidget {
  final Office office;

  const _OfficeItem({Key? key, required this.office}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(office.name),
      subtitle: Text(office.address),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          showAppDialog(context, (_) => Text(office.name), (_) => _OfficeForm(office: office));
        },
      ),
      onTap: () {
        context.push(OfficeDetailsScreen.route.replaceAll(':id', office.id!), extra: office);
      },
    );
  }
}

class _OfficeForm extends HookConsumerWidget {
  final Office? office;

  const _OfficeForm({this.office});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final controllerName = useTextEditingController(text: office?.name);
    final controllerStreet = useTextEditingController(text: office?.street);
    final controllerStreet2 = useTextEditingController(text: office?.street2);
    final controllerCity = useTextEditingController(text: office?.city);
    final controllerZipCode = useTextEditingController(text: office?.zipCode);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: controllerName,
            validator: (value) => isRequired(value, context),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(label: Text(context.l10n.generalNameField)),
          ),
          TextFormField(
            controller: controllerStreet,
            validator: (value) => isRequired(value, context),
            keyboardType: TextInputType.streetAddress,
            autofillHints: const [AutofillHints.streetAddressLine1],
            decoration: InputDecoration(label: Text(context.l10n.streetField.mandatory)),
          ),
          TextFormField(
            controller: controllerStreet2,
            validator: (value) => isRequired(value, context),
            keyboardType: TextInputType.streetAddress,
            autofillHints: const [AutofillHints.streetAddressLine2],
            decoration: InputDecoration(label: Text(context.l10n.street2Field.mandatory)),
          ),
          TextFormField(
            controller: controllerZipCode,
            validator: (value) => isRequired(value, context),
            keyboardType: const TextInputType.numberWithOptions(),
            autofillHints: const [AutofillHints.postalCode],
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(label: Text(context.l10n.zipField)),
          ),
          TextFormField(
            controller: controllerCity,
            validator: (value) => isRequired(value, context),
            keyboardType: TextInputType.streetAddress,
            autofillHints: const [AutofillHints.addressCity],
            decoration: InputDecoration(label: Text(context.l10n.cityField)),
          ),
          const SizedBox(height: kNormalPadding),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final store = ref.read(officeFormStoreProvider);
                final storeOffices = ref.read(officesStoreProvider);
                final success = await showLoadingDialog(
                  context,
                  (_) => Text(context.l10n.sending),
                  () => store.save(OfficeInfo((b) {
                    b.id = office?.id;
                    b.name = controllerName.text;
                    b.street = controllerStreet.text;
                    b.street2 = controllerStreet2.text;
                    b.city = controllerCity.text;
                    b.zipCode = controllerZipCode.text;
                  })),
                );
                if (success) {
                  context.navigator.pop();
                  storeOffices.reload();
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(kNormalPadding),
              child: Text(context.l10n.saveButton),
            ),
          ),
        ],
      ),
    );
  }
}
