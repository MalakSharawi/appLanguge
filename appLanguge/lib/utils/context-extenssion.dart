import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextExtension on BuildContext{
  AppLocalizations get localizations => AppLocalizations.of(this)!;
  void shwoMassege({required String message , bool error =false }){
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message),
      backgroundColor: error ? Colors.red: Colors.green,
        duration: Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,

      )
    );
  }
}