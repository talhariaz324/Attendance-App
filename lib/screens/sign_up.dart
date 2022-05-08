import 'package:attendance_uni_app/Firebase%20Auth/auth.dart';
import 'package:attendance_uni_app/configs/images_paths.dart';
import 'package:attendance_uni_app/utilities/routes.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_email.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_class.dart';
import 'package:attendance_uni_app/widgets/valid_text_form_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const String routeName = '/SignupScreen';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: size.height * 0.01, right: size.height * 0.01),
        child: Form(
          key: _globalKey,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              SizedBox(
                height: size.height * 0.37,
                // width: size.width * 0.3,
                // height: 100,
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(
                  signUpImg,
                ),
              ),
              ValideNameTextFormField(name: _name),
              SizedBox(height: size.height * 0.02),
              ValideEmailTextFormField(email: _email),
              SizedBox(height: size.height * 0.02),
              ValidePasswordTextFormField(password: _password),
              SizedBox(height: size.height * 0.03),
              // const SizedBox(height: 20),
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
                            .signUp(_email.text, _password.text, context);
                        if (result != null) {
                          Navigator.of(context)
                              .pushNamed(MyRoutes.loginScreenRoute);
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
              SizedBox(height: size.height * 0.09),
              const GoToLoginScreenLine(),
            ],
          ),
        ),
      ),
    );
  }
}

// class SignupButton extends StatelessWidget {
//   const SignupButton({
//     required TextEditingController name,
//     required TextEditingController email,
//     required TextEditingController password,
//     required GlobalKey<FormState> globalKey,
//     Key? key,
//   })  : _name = name,
//         _email = email,
//         _password = password,
//         _globalKey = globalKey,
//         super(key: key);
//   final TextEditingController _name;
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
//           print(_name.text);
//           print(_email.text);
//           print(_password.text);
//           // Navigator.of(context).pushNamed(QuestionIntroScreen.routeName);
//         }
//       },
//       child: Container(
//         height: 44,
//         width: size.width / 2,
//         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             border: Border.all(
//               color: Theme.of(context).colorScheme.secondary,
//             )),
//         child: const Text(
//           'Sign Up',
//           style: TextStyle(
//             fontWeight: FontWeight.w300,
//             fontSize: 20,
//             letterSpacing: 1,
//           ),
//         ),
//       ),
//     );
//   }
// }

class GoToLoginScreenLine extends StatelessWidget {
  const GoToLoginScreenLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          '''You already have an account?''',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Login',
              style: TextStyle(color: Theme.of(context).primaryColor),
            )),
      ],
    );
  }
}
