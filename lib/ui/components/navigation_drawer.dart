import 'package:flutter/material.dart';
import 'package:flutter_web_app/ui/components/menu_tile.dart';
import 'package:flutter_web_app/ui/models/screen_managerUI.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  static const double dividerPadding = 40.0, dividerOpacity = 0.60;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NavDrawer({required this.scaffoldKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/u_galileo.jpg'),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Bienvenido',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          const MenuTile(
            title: 'Learning Curve',
            icon: Icons.stacked_line_chart,
            screenType: ScreenType.LEARNING_CURVE,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: dividerPadding),
            child: Divider(
              color: Colors.grey.withOpacity(dividerOpacity),
            ),
          ),
          const MenuTile(
            title: 'Monte Carlo',
            icon: Icons.account_tree,
            screenType: ScreenType.MONTE_CARLO,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: dividerPadding),
            child: Divider(
              color: Colors.grey.withOpacity(dividerOpacity),
            ),
          ),
          const MenuTile(
            title: 'Información',
            icon: Icons.info,
            screenType: ScreenType.INFORMATION,
          ),
        ],
      ),
    );
  }
}
