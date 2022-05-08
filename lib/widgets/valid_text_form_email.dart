import 'package:flutter/material.dart';

class ValideEmailTextFormField extends StatefulWidget {
  const ValideEmailTextFormField({
    Key? key,
    required TextEditingController email,
  })  : _email = email,
        super(key: key);
  final TextEditingController _email;
  @override
  _ValideEmailTextFormFieldState createState() =>
      _ValideEmailTextFormFieldState();
}

class _ValideEmailTextFormFieldState extends State<ValideEmailTextFormField> {
  void onListener() => setState(() {});
  @override
  void initState() {
    widget._email.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._email.removeListener(onListener);
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
        controller: widget._email,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        autofillHints: const <String>[AutofillHints.email],
        validator: (String? value) {
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!)) {
            return 'Email is Invalide';
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
          suffixIconColor: Theme.of(context).primaryColor,
          focusColor: Theme.of(context).primaryColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(size.width * 0.1),
          ),
          labelText: 'Email',
          hintText: 'Email',
          prefix: Container(width: size.width * 0.015),
          suffixIcon: IconButton(
            splashRadius: size.width * 0.09,
            icon: (widget._email.text.isEmpty)
                ? const SizedBox(width: 0)
                : Icon(
                    Icons.clear,
                    color: Theme.of(context).primaryColor,
                  ),
            onPressed: () => widget._email.clear(),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(size.width * 0.1),
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: size.width * 0.01),
          ),
        ),
      ),
    );
  }
}
