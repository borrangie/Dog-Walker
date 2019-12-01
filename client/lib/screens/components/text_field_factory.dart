import 'package:flutter/material.dart';

abstract class TextFieldFactory {
  static TextField generate(controller, text) {
    return _generateTextFieldKeyboardType(controller, text, TextInputType.text);
  }

  static TextField generatePassword(controller, text) {
    return TextField(
      obscureText: true,
      controller: controller,
      decoration: _generateDecoration(text)
    );
  }

  static TextField generateEmail(controller, text) {
    return _generateTextFieldKeyboardType(controller, text, TextInputType.emailAddress);
  }

  static TextField generateNumeric(controller, text) {
    return _generateTextFieldKeyboardType(controller, text, TextInputType.number);
  }

  static TextField generatePhone(controller, text) {
    return _generateTextFieldKeyboardType(controller, text, TextInputType.phone);
  }

  static TextField generateDatetime(controller, text) {
    return _generateTextFieldKeyboardType(controller, text, TextInputType.datetime);
  }

  static InputDecoration _generateDecoration(text) {
    return InputDecoration(
        labelText: text,
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        )
    );
  }

  static TextField _generateTextFieldKeyboardType(controller, text, TextInputType textInputType) {
    return TextField(
        controller: controller,
        keyboardType: textInputType,
        decoration: _generateDecoration(text)
    );
  }
}
