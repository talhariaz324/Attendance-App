import 'package:attendance_uni_app/Firebase%20Auth/auth.dart';
import 'package:attendance_uni_app/configs/images_paths.dart';
import 'package:attendance_uni_app/utilities/routes.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_email.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.01),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              // SizedBox(height: size.height * 0.1),
              SizedBox(
                height: size.height * 0.5,
                // width: size.width * 0.5,
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(
                  loginImg,
                ),
              ),
              ValideEmailTextFormField(email: _email),
              SizedBox(height: size.height * 0.02),
              ValidePasswordTextFormField(password: _password),
              SizedBox(height: size.height * 0.02),
              IconButton(
                  onPressed: () async {
                    if (_globalKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      if (_email.text == '' || _password.text == '') {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'You are not authorized person!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        User? result = await UserAuth()
                            .logIn(_email.text, _password.text, context);
                        if (result != null) {
                          Navigator.of(context)
                              .pushNamed(MyRoutes.homeScreenRoute);
                        }
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  icon: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : Icon(
                          Icons.arrow_forward,
                          size: size.height * 0.09,
                          color: Theme.of(context).primaryColor,
                        )),
              SizedBox(height: size.height * 0.1),
              const GoToSignupScreenLine(),
            ],
          ),
        ),
      ),
    );
  }
}

// class LoginButton extends StatelessWidget {
//   const LoginButton({
//     required TextEditingController email,
//     required TextEditingController password,
//     required GlobalKey<FormState> globalKey,
//     Key? key,
//   })  : _email = email,
//         _password = password,
//         _globalKey = globalKey,
//         super(key: key);
//   final TextEditingController _email;
//   final TextEditingController _password;
//   final GlobalKey<FormState> _globalKey;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return InkWell(
//       borderRadius: BorderRadius.circular(30),
//       onTap: () {
//         if (_globalKey.currentState!.validate()) {
//           print(_email.text);
//           print(_password.text);
//         }
//       },
//       child: Container(
//         height: size.height * 0.06,
//         width: size.width * 0.08,
//         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             border: Border.all(
//               color: Theme.of(context).colorScheme.secondary,
//             )),
//         child: Text(
//           'Login',
//           style: TextStyle(
//             fontWeight: FontWeight.w300,
//             fontSize: size.height * 0.03,
//             letterSpacing: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }

class GoToSignupScreenLine extends StatelessWidget {
  const GoToSignupScreenLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          '''Don't you have an acoount?''',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        TextButton(
            onPressed: null,
            //  () {
            //   Navigator.of(context).pushNamed(MyRoutes.signUpScreenRoute);
            // },
            child: Text(
              'Sign Up',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ))
      ],
    );
  }
}
