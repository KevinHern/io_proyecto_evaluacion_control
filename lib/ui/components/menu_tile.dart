import 'package:flutter/material.dart';
import 'package:flutter_web_app/ui/models/screen_managerUI.dart';
import 'package:flutter_web_app/ui/models/subscreen_managerUI.dart';
import 'package:provider/provider.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final ScreenType screenType;
  const MenuTile(
      {required this.title,
      required this.icon,
      required this.screenType,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenManagerUI>(
      builder: (_, screenManagerUI, __) {
        return ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColorDark,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          tileColor: screenManagerUI.screenType == screenType
              ? Theme.of(context).primaryColorLight
              : null,
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
              screenManagerUI.screenType = screenType;
              if (screenType == ScreenType.LEARNING_CURVE) {
                Provider.of<SubScreenManagerUI>(context, listen: false)
                    .screenType = SubScreenType.LC_INITIAL_CONDITIONS;
              } else {}
            }
          },
        );
      },
    );
  }
}
