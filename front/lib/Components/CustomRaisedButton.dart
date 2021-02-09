import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatefulWidget {
  final String title;
  final Function onPressed;
  final bool isDisabled;

  CustomRaisedButton({this.title, @required this.onPressed, this.isDisabled = false});

  _CustomRaisedButtonState createState() => _CustomRaisedButtonState(
      text: this.title, onpressedFunction: onPressed, isDisabled: isDisabled);

}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  bool isDisabled = false;
  final String text;
  final Function onpressedFunction;

  _CustomRaisedButtonState(
      {this.text, this.isDisabled, @required this.onpressedFunction});

  Function _buttonPressed() {
    if (isDisabled) {
      return null;
    }
    return onpressedFunction;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _buttonPressed(),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
