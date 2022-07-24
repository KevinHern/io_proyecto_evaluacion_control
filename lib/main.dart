// Basic Imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Screens
import 'ui/main_screen.dart';

void main() {
  runApp(const MyApp());
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class MyApp extends StatelessWidget {
  static const double cardElevation = 6.0, borderRadius = 12.0;
  static const Color primaryColor = Color(0xFF3f51b5),
      primaryColorLight = Color(0xFF757de8),
      primaryColorDark = Color(0xFF002984),
      scaffoldColor = Color(0xFFf2e9d0);

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto ',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: createMaterialColor(primaryColor),
        primaryColor: primaryColor,
        primaryColorLight: primaryColorLight,
        primaryColorDark: primaryColorDark,
        scaffoldBackgroundColor: scaffoldColor,

        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.95),
          ),
          subtitle1: GoogleFonts.lora(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.90),
          ),
          subtitle2: GoogleFonts.lora(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.85),
          ),
          bodyText1: GoogleFonts.hindMadurai(
            fontSize: 18,
            color: Colors.white.withOpacity(0.85),
          ),
          bodyText2: GoogleFonts.hindMadurai(
            fontSize: 18,
            color: Colors.black.withOpacity(0.90),
          ),
        ),

        appBarTheme: const AppBarTheme(color: primaryColor),

        cardTheme: CardTheme(
          elevation: cardElevation,
          shadowColor: const Color(0xFF696969),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          errorStyle: GoogleFonts.hindMadurai(
              textStyle: const TextStyle(
            color: Color(0xFFde0b0b),
          )),
          labelStyle: GoogleFonts.hindMadurai(
              textStyle: const TextStyle(
            color: primaryColor,
          )),
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor, width: 0.0),
            borderRadius: BorderRadius.circular(borderRadius + 4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColorDark, width: 2.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFde0b0b), width: 0.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFa30000), width: 2.0),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AppProviders(),
      },
    );
  }
}
