import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class CustomDropdownTextField extends StatefulWidget {

  final List<String> items;
  final String label;
  final String value;
  final TextEditingController controller;
  final Key key;
  final Function onTap;
  final bool readOnly;
  final suffixIcon;
  final regexPattern;
  final regexHint;
  final Function onChanged;

  CustomDropdownTextField({this.label = "", this.controller, this.key, this.onTap, this.readOnly = false, this.suffixIcon, this.regexPattern, this.regexHint, this.items, this.value, this.onChanged});

  @override
  _CustomDropdownTextFieldState createState() => _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  String _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: new InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(fontSize: 14, color: Constants.neutralColor, fontWeight: FontWeight.w600),
            suffixIconConstraints: BoxConstraints(maxWidth: 20, minWidth: 20, maxHeight: 16, minHeight: 16),
            fillColor: Constants.textFieldFillColor,
            filled: true,
            contentPadding: EdgeInsets.only(left: 20, right: 0),
            border: new OutlineInputBorder(
              borderSide: const BorderSide(color: Constants.textFieldBorderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Constants.errorAlertColor, width: 1.0),
              borderRadius: BorderRadius.circular(4.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Constants.textFieldBorderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.0),
            ),
            errorStyle: TextStyle(color: Constants.errorAlertColor),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Constants.textFieldBorderColor, width: 1.5),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          child: Transform.translate(
            offset: Offset(-10,0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _value,
                onChanged: (String newValue) {
                  setState(() {
                    widget.onChanged(newValue);
                     _value = newValue;
                  });
                },
                items: widget.items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 110,
                        child: Text(value)),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
