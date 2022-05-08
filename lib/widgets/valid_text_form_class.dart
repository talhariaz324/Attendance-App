import 'package:flutter/material.dart';

class ValideNameTextFormField extends StatefulWidget {
  const ValideNameTextFormField({
    Key? key,
    required TextEditingController name,
  })  : _name = name,
        super(key: key);
  final TextEditingController _name;
  @override
  _ValideNameTextFormFieldState createState() =>
      _ValideNameTextFormFieldState();
}

class _ValideNameTextFormFieldState extends State<ValideNameTextFormField> {
  void onListener() => setState(() {});
  @override
  void initState() {
    widget._name.addListener(onListener);
    super.initState();
  }

  @override
  void dispose() {
    widget._name.removeListener(onListener);
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
        controller: widget._name,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        autofillHints: const <String>[AutofillHints.name],
        validator: (String? value) {
          if (value!.length < 3) return 'Enter Correct Name';
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
          labelText: 'Name',
          hintText: 'Name',
          prefix: Container(width: size.width * 0.015),
          suffixIcon: IconButton(
            icon: (widget._name.text.isEmpty)
                ? const SizedBox(width: 0)
                : Icon(
                    Icons.clear,
                    color: Theme.of(context).primaryColor,
                  ),
            onPressed: () => widget._name.clear(),
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
