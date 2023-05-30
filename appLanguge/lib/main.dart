import 'package:applanguge/auth/register_screen.dart';
import 'package:applanguge/database/db_controller.dart';
import 'package:applanguge/database/notes_provider.dart';
import 'package:applanguge/prf/shared_pref_controller.dart';
import 'package:applanguge/screens/app/home_screen.dart';
import 'package:applanguge/screens/lunch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'auth/login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefController().initPreferansces();
  await DbController().initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotesProvider>(create: (context)=> NotesProvider()),
      ],
      builder: (context,widget){
        return  MaterialApp(
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar'), Locale('en')],
          locale: Locale('en'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  titleTextStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ))),
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen': (context) => const Lunch_Screen(),
            '/login_screen': (context) => const login(),
            '/register_screen': (context) => const RegisterScreen(),
            '/home_screen': (context) => const HomeScreen(),
          },
        );
      },
    );

  }
}
