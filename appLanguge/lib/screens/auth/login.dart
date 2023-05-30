import 'package:applanguge/controller/user_db_controller.dart';
import 'package:applanguge/models/prosses_respons.dart';
import 'package:applanguge/utils/context-extenssion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../prf/shared_pref_controller.dart';


class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}


class _loginState extends State<login> {
  bool _obscur = true;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;
  String? _EmailError;
  String? _passwordError;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              'Enter Email && Password',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: TextField(
                controller: _emailTextController,
                //expands: true,
                maxLines: 1,
                minLines: 1,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.green)),
                  contentPadding: EdgeInsets.zero,
                  constraints: BoxConstraints(
                    maxHeight: _EmailError == null ? 50 : 70,
                  ),
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.green.shade300, width: 2)),
                  errorText: _EmailError,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    width: 1,
                    color: Colors.red.shade300,
                  )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 20),
              child: TextField(
                controller: _passwordTextController,
                keyboardType: TextInputType.text,
                style: GoogleFonts.nunito(),
                obscureText: _obscur,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.green)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 1, color: Colors.green)),
                    //**********************************/****************************************************
                    errorText: _passwordError,
                    errorMaxLines: 1,
                    errorStyle: GoogleFonts.nunito(),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    contentPadding: EdgeInsets.zero,
                    hintText:'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() => _obscur = !_obscur);
                      },
                      icon: Icon(
                          _obscur ? Icons.visibility : Icons.visibility_off),
                    ),
                    hintStyle: GoogleFonts.nunito(),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.green))),
              ),
            ),
            ElevatedButton(
              onPressed: () => _performLogin(),
              child: Text(
                'Login',
                style: GoogleFonts.nunito(),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: Size(double.infinity, 50)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have an account',style: GoogleFonts.cairo(),),
                TextButton(onPressed: (){Navigator.pushNamed(context, '/register_screen');}, child: Text('Create now',style: GoogleFonts.cairo(fontWeight: FontWeight.bold),))
              ],
            )


          ],
        ),
      ),
    );
  }

  void _performLogin() {
    SystemChannels.textInput.invokeListMethod('TextInput.hide');

    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    _ErrorValue();
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error ,Enter required data !'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        dismissDirection: DismissDirection.horizontal,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        onVisible: () => print('Visble'),
      ),
    );
    return false;
  }

  // ignore: non_constant_identifier_names
  void _ErrorValue() {
    setState(() {
      _EmailError =
          _emailTextController.text.isEmpty ? 'Enter Email Addres' : null;
      _passwordError =
          _passwordTextController.text.isEmpty ? 'Enter password ' : null;
    });
  }

  void _login() async{
    ProcessResponse processResponse = await UserDbController().login(email: _emailTextController.text, password: _passwordTextController.text);
    if(processResponse.success){
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
    context.shwoMassege(message: processResponse.message,error: !processResponse.success);
  }
}
