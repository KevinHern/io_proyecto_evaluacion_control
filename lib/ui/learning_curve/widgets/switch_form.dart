import 'package:flutter/material.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';
import 'package:provider/provider.dart';

class LCSwitchForm extends StatelessWidget {
  const LCSwitchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Consumer<SubScreenManagerUI>(
        builder: (_, subScreenManagerUI, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text(
                    'Condiciones Iniciales',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: SubScreenType.LC_INITIAL_CONDITIONS,
                  groupValue: subScreenManagerUI.screenType,
                  onChanged: (SubScreenType? value) {
                    if (value != null) {
                      subScreenManagerUI.screenType = value;
                    }
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text(
                    'N-Iteración',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: SubScreenType.LC_N_ITERATION,
                  groupValue: subScreenManagerUI.screenType,
                  onChanged: (SubScreenType? value) {
                    if (value != null) {
                      subScreenManagerUI.screenType = value;
                    }
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text(
                    '2 Muestras',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: SubScreenType.LC_TWO_SAMPLES,
                  groupValue: subScreenManagerUI.screenType,
                  onChanged: (SubScreenType? value) {
                    if (value != null) {
                      subScreenManagerUI.screenType = value;
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
