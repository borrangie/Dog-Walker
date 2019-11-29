import 'package:flutter/material.dart';

abstract class TextFieldFactory {
  static TextField generate(controller, text) {
    return TextField(
      controller: controller,
      decoration: _generateDecoration(text)
    );
  }

  static TextField generatePassword(controller, text) {
    return TextField(
        obscureText: true,
        controller: controller,
        decoration: _generateDecoration(text)
    );
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
}
