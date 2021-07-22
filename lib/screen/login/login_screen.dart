import 'package:flutter/material.dart';
import 'package:hsse/config/config.dart';
import 'package:hsse/screen/components/custom_button.dart';
import 'package:hsse/screen/components/flushbar.dart';
import 'package:hsse/screen/components/ui_helper.dart';
import 'package:hsse/singleton/shared_pref.dart';
import 'package:hsse/utils/enum_state.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.dart';
import '../../router/routes.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Upper(constraint.maxHeight * 0.5, constraint.maxWidth),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: LoginForm())
              ],
            ),
          );
        }));
  }
}

class Upper extends StatelessWidget {
  const Upper(this.height, this.width);
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade100,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          if (screenIsPortrait(context))
            SizedBox(
              height: 125,
              // child: Lottie.asset('assets/lottie/150-android-fingerprint.json'),
              child: Image.asset("assets/icon/icon.png"),
            ),
          verticalSpaceTiny,
          const Text(
            "LOGIN",
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          verticalSpaceLarge
        ],
      )),
    );
  }
}

// FORM -------------------------------------------------------------
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final AuthProvider authViewModel = context.read<AuthProvider>();

    if (_key.currentState?.validate() ?? false) {
      final String username = usernameController.text;
      final String password = passwordController.text;

      Future<void>.delayed(Duration.zero, () {
        authViewModel.login(username, password).then((bool value) {
          if (value) {
            Future<void>.delayed(const Duration(milliseconds: 500), () {
              // jika akun HSSE
              if (SharedPrefs().getRoles().contains("HSSE")) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteGenerator.homeHsse,
                    ModalRoute.withName(RouteGenerator.homeHsse));
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RouteGenerator.homeHsse,
                    ModalRoute.withName(RouteGenerator.homeSec));
              }
            });
          }
        }).onError((Object? error, _) {
          if (error != null) {
            showToastError(context: context, message: error.toString());
          }
        });
      });
    } else {
      debugPrint("Error :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder enabledOutlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: TColor.secondaryBackground));

    const OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.grey));

    const OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.red));

    return Form(
        key: _key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    enabledBorder: enabledOutlineInputBorder,
                    focusedBorder: focusedOutlineInputBorder,
                    errorBorder: errorOutlineInputBorder,
                    focusedErrorBorder: errorOutlineInputBorder,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    labelText: "Username"),
                validator: (String? text) {
                  if (text == null || text.isEmpty) {
                    return 'username tidak boleh kosong';
                  }
                  return null;
                },
                controller: usernameController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(
                    enabledBorder: enabledOutlineInputBorder,
                    focusedBorder: focusedOutlineInputBorder,
                    errorBorder: errorOutlineInputBorder,
                    focusedErrorBorder: errorOutlineInputBorder,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Password"),
                obscureText: true,
                validator: (String? text) {
                  if (text == null || text.length < 7) {
                    return 'Password setidaknya 7 karakter';
                  }
                  return null;
                },
                controller: passwordController,
              ),
            ),
            verticalSpaceSmall,
            Consumer<AuthProvider>(
              builder: (_, AuthProvider data, __) {
                return (data.state == ViewState.busy)
                    ? const CircularProgressIndicator()
                    : LoginButton(title: "login", onPress: _login);
              },
            )
          ],
        ));
  }
}
