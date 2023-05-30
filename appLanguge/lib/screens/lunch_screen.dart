import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../prf/shared_pref_controller.dart';

// ignore: camel_case_types
class Lunch_Screen extends StatefulWidget {
  const Lunch_Screen({Key? key}) : super(key: key);

  @override
  State<Lunch_Screen> createState() => _Lunch_screenState();
}

// ignore: camel_case_types
class _Lunch_screenState extends State<Lunch_Screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      bool loggedIn =SharedPrefController().getValueFor<bool>(key:PrefKeys.loggedIn.name)?? false;
      String rout =loggedIn ? '/home_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, rout);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.pink.shade100],
          end: AlignmentDirectional.topStart,
          begin: AlignmentDirectional.bottomEnd,
        )),
        child: Text(
          'Note App',
          style: GoogleFonts.nunito(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
