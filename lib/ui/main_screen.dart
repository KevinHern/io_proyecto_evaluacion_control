// Basic Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_app/ui/components/navigation_drawer.dart';

// Screens
import 'package:flutter_web_app/ui/switch_screen.dart';

// Models
import 'models/subscreen_managerUI.dart';
import 'package:flutter_web_app/ui/models/screen_managerUI.dart';
import 'package:flutter_web_app/ui/models/learning_curve_series.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScreenManagerUI>(
          create: (context) => ScreenManagerUI(),
        ),
        ChangeNotifierProvider<SubScreenManagerUI>(
          create: (context) => SubScreenManagerUI(),
        ),
        ChangeNotifierProvider<LearningCurveSeriesUI>(
          create: (context) => LearningCurveSeriesUI(),
        ),
      ],
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Proyecto',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      drawer: NavDrawer(
        scaffoldKey: _scaffoldKey,
      ),
      body: Center(
        child: SwitchScreen(),
      ),
    );
  }
}
