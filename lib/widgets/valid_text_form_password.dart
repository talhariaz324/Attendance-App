import 'package:flutter/material.dart';

class ValidePasswordTextFormField extends StatefulWidget {
  const ValidePasswordTextFormField(
      {Key? key, required TextEditingController password})
      : _password = password,
        super(key: key);
  final TextEditingController _password;
  @override
  _ValidePasswordTextFormFieldState createState() =>
      _ValidePasswordTextFormFieldState();
}

class _ValidePasswordTextFormFieldState
    extends State<ValidePasswordTextFormField> {
  void onListener() => setState(() {});
  bool _showPassword = true;

  @override
  void initState() {
    _showPassword = true;
    widget._password.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._password.removeListener(onListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          top: size.height * 0.015,
          left: size.width * 0.035,
          right: size.width * 0.035),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColor,
        controller: widget._password,
        obscureText: _showPassword,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        autofillHints: const <String>[AutofillHints.password],
        validator: (String? value) {
          if (value!.length < 6) {
            return 'Password should be greater then 6 digits';
          }
          return null;
        },
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: size.width * 0.00125),
          ),
          contentPadding: EdgeInsets.all(size.width * 0.035),
          labelStyle: TextStyle(color: Theme.of(context).primaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(size.width * 0.1),
          ),
          labelText: 'Password',
          hintText: 'Password',
          prefix: Container(width: size.width * 0.015),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width * 0.1),
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: size.width * 0.01),
          ),
          suffixIcon: (widget._password.text.isEmpty)
              ? Container(width: 0)
              : IconButton(
                  splashRadius: size.width * 0.09,
                  icon: (_showPassword == true)
                      ? Icon(
                          Icons.visibility,
                          color: Theme.of(context).primaryColor,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        ),
                  onPressed: () {
                    setState(
                      () {
                        _showPassword = !_showPassword;
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
