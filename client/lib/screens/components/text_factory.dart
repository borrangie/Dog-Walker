import 'package:flutter/material.dart';

abstract class TextFactory {
  static Widget generateTextField(controller, text, {enabled: true}) {
    return _generateTextField(controller, text, TextInputType.text, enabled);
  }

  static Widget generateTextFieldPassword(controller, text, {enabled: true}) {
    return _generateTextField(controller, text, TextInputType.text, enabled, obscureText: true);
  }

  static Widget generateTextFieldEmail(controller, text, {enabled: true}) {
    return _generateTextField(controller, text, TextInputType.emailAddress, enabled);
  }

  static Widget generateTextFieldNumeric(controller, text, {enabled: true}) {
    return _generateTextField(controller, text, TextInputType.number, enabled);
  }

  static Widget generateTextFieldPhone(controller, text, {enabled: true}) {
    return _generateTextField(controller, text, TextInputType.phone, enabled);
  }

  static Widget generateTextFieldDatetime(controller, text, {enabled: true}) {
    return _generateTextField(controller, text, TextInputType.datetime, enabled);
  }

  static Text generateText(text, {double size: 16.0, FontWeight weight, Color color: Colors.black}) {
    return Text(
      text,
      style: _generateTextStyle(size: size, weight: weight, color: color),
    );
  }

  static Widget _generateTextField(controller, text, TextInputType textInputType, enabled, {obscureText: false}) {
    Widget widget;
    if (enabled) {
      widget = _generateTextFieldContainer(controller, text, textInputType, enabled, obscureText);
    } else {
      widget = FocusScope(
        node: new FocusScopeNode(),
        child: _generateTextFieldContainer(controller, text, textInputType, enabled, obscureText)
      );
    }

    return widget;
  }

  static TextField _generateTextFieldContainer(controller, text, TextInputType textInputType, enabled, obscureText) {
    return TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: textInputType,
        decoration: _generateDecoration(text)
    );
  }

  static InputDecoration _generateDecoration(text) {
    return InputDecoration(
        labelText: text,
        labelStyle: _generateTextFieldStyle(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        )
    );
  }

  static TextStyle _generateTextStyle({double size, FontWeight weight, Color color: Colors.black}) {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle _generateTextFieldStyle() {
    return TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );
  }
}
