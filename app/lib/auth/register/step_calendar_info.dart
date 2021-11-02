part of 'register_screen.dart';

class _StepCalendarInfo extends HookConsumerWidget {
  final VoidCallback onContinue;

  const _StepCalendarInfo({Key? key, required this.onContinue}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoProvider);
    final controllerConsultation = useTextEditingController(text: userInfo.consultationDuration?.toString() ?? '');
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Merci de remplir vos heures de consultations:',
              style: context.textTheme.headline5,
            ),
            const SizedBox(height: kNormalPadding),
            TextFormField(
              controller: controllerConsultation,
              validator: isRequired,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: InputDecoration(label: Text('Durée d\'une consultation*:'), hintText: 'A spécifier en minute'),
            ),
            const SizedBox(height: kSmallPadding),
            Text('M. = Matin, AM. = Après midi', style: context.textTheme.caption),
            _CalendarDaySetting(
              label: 'Lundi',
              settings: userInfo.calendarSettings.monday,
              onChange: (value) {
                userInfo.calendarSettings = userInfo.calendarSettings.copyWith(monday: value);
              },
            ),
            _CalendarDaySetting(
              label: 'Mardi',
              settings: userInfo.calendarSettings.tuesday,
              onChange: (value) {
                userInfo.calendarSettings = userInfo.calendarSettings.copyWith(tuesday: value);
              },
            ),
            _CalendarDaySetting(
              label: 'Mercredi',
              settings: userInfo.calendarSettings.wednesday,
              onChange: (value) {
                userInfo.calendarSettings = userInfo.calendarSettings.copyWith(wednesday: value);
              },
            ),
            _CalendarDaySetting(
              label: 'Jeudi',
              settings: userInfo.calendarSettings.thursday,
              onChange: (value) {
                userInfo.calendarSettings = userInfo.calendarSettings.copyWith(thursday: value);
              },
            ),
            _CalendarDaySetting(
              label: 'Vendredi',
              settings: userInfo.calendarSettings.friday,
              onChange: (value) {
                userInfo.calendarSettings = userInfo.calendarSettings.copyWith(friday: value);
              },
            ),
            _CalendarDaySetting(
              label: 'Samedi',
              settings: userInfo.calendarSettings.saturday,
              onChange: (value) {
                userInfo.calendarSettings = userInfo.calendarSettings.copyWith(sunday: value);
              },
            ),
            _CalendarDaySetting(
              label: 'Dimanche',
              settings: userInfo.calendarSettings.sunday,
              onChange: (value) {},
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).maybePop();
                    },
                    child: Text('Retour'),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(kNormalPadding),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        userInfo.consultationDuration = int.tryParse(controllerConsultation.text);

                        showDayError(String day) {
                          showAlert(context, 'Erreur', (context) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: kNormalPadding),
                            child: Text('Les horaires pour $day sont incorrect, merci de corriger.'),
                          ));
                        }

                        if (!userInfo.calendarSettings.monday.isValid()) {
                          showDayError('Lundi');
                          return;
                        } else if (!userInfo.calendarSettings.tuesday.isValid()) {
                          showDayError('Mardi');
                          return;
                        } else if (!userInfo.calendarSettings.wednesday.isValid()) {
                          showDayError('Mercredi');
                          return;
                        } else if (!userInfo.calendarSettings.thursday.isValid()) {
                          showDayError('Jeudi');
                          return;
                        } else if (!userInfo.calendarSettings.friday.isValid()) {
                          showDayError('Vendredi');
                          return;
                        } else if (!userInfo.calendarSettings.saturday.isValid()) {
                          showDayError('Samedi');
                          return;
                        } else if (!userInfo.calendarSettings.sunday.isValid()) {
                          showDayError('Dimanche');
                          return;
                        }
                        onContinue();
                      }
                    },
                    child: Text('Continuer'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarDaySetting extends HookConsumerWidget {
  final String label;
  final CalendarTimeOfDaySettings settings;
  final Function(CalendarTimeOfDaySettings settings) onChange;

  const _CalendarDaySetting({Key? key, required this.settings, required this.onChange, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amStartHour = useState<TimeOfDay?>(settings.start);
    final amEndHour = useState<TimeOfDay?>(settings.end);
    final pmStartHour = useState<TimeOfDay?>(settings.start2);
    final pmEndHour = useState<TimeOfDay?>(settings.end2);

    checkTime() {
      if (amStartHour.value == null) {
        amEndHour.value = null;
      } else {
        if (amStartHour.value!.isAfter(amEndHour.value)) {
          amEndHour.value = null;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('L\'heure de début ne peut être après l\'heure de fin'),
          ));
        } else if (amStartHour.value!.isAfter(pmStartHour.value)) {
          pmStartHour.value = null;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('L\'heure de début ne peut être après l\'heure de fin'),
          ));
        } else if (amStartHour.value!.isAfter(pmEndHour.value)) {
          pmEndHour.value = null;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('L\'heure de début ne peut être après l\'heure de fin'),
          ));
        }
      }

      if (pmStartHour.value == null) {
        pmEndHour.value = null;
      } else {
        if (pmStartHour.value!.isAfter(pmEndHour.value)) {
          amEndHour.value = null;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('L\'heure de début ne peut être après l\'heure de fin'),
          ));
        } else if (pmStartHour.value!.isBefore(amStartHour.value)) {
          amStartHour.value = null;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('L\'heure de début ne peut être après l\'heure de fin'),
          ));
        } else if (pmStartHour.value!.isBefore(amEndHour.value)) {
          pmStartHour.value = null;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('L\'heure de début ne peut être après l\'heure de fin'),
          ));
        }
      }

      onChange(CalendarTimeOfDaySettings(start: amStartHour.value, end: amEndHour.value, start2: pmStartHour.value, end2: pmEndHour.value));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSmallPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: context.textTheme.subtitle2?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: context.primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _TimePickerField(
                  label: 'M. début:',
                  value: amStartHour.value,
                  onHourChange: (time) {
                    amStartHour.value = time;
                    checkTime();
                  },
                ),
              ),
              const SizedBox(width: kNormalPadding),
              Expanded(
                  child: _TimePickerField(
                onHourChange: (time) {
                  amEndHour.value = time;
                  checkTime();
                },
                value: amEndHour.value,
                disabled: amStartHour.value == null,
                label: 'M. fin:',
              )),
              const SizedBox(width: kNormalPadding),
              Expanded(
                child: _TimePickerField(
                  onHourChange: (time) {
                    pmStartHour.value = time;
                    checkTime();
                  },
                  value: pmStartHour.value,
                  label: 'AM. début:',
                ),
              ),
              const SizedBox(width: kNormalPadding),
              Expanded(
                child: _TimePickerField(
                  onHourChange: (time) {
                    pmEndHour.value = time;
                    checkTime();
                  },
                  value: pmEndHour.value,
                  disabled: pmStartHour.value == null,
                  label: 'AM. fin:',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimePickerField extends HookWidget {
  final String label;
  final bool disabled;
  final TimeOfDay? value;
  final Function(TimeOfDay?) onHourChange;

  const _TimePickerField({Key? key, this.value, required this.onHourChange, required this.label, this.disabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final focusNode = useFocusNode();
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final mediaQuery = MediaQuery.of(context);
    useEffect(() {
      if (value != null) {
        controller.text = localizations.formatTimeOfDay(
          value!,
          alwaysUse24HourFormat: mediaQuery.alwaysUse24HourFormat,
        );
      } else {
        controller.text = '';
      }
    }, [value]);
    showPopup() async {
      final result = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        cancelText: 'Effacer',
        helpText: MaterialLocalizations.of(context).timePickerDialHelpText + '\n$label',
      );
      onHourChange(result);
    }

    useEffect(() {
      var opened = false;
      focusNode.addListener(() async {
        if (focusNode.hasFocus && !opened) {
          opened = true;
          showPopup();
        } else if (!focusNode.hasFocus) {
          opened = false;
        }
      });
    }, const []);
    return InkWell(
      onTap: disabled ? null : showPopup,
      child: IgnorePointer(
        child: TextField(
          readOnly: true,
          focusNode: focusNode,
          enabled: !disabled,
          controller: controller,
          decoration: InputDecoration(label: Text(label)),
        ),
      ),
    );
  }
}
