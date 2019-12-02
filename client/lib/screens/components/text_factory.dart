import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

abstract class TextFactory {
  static TextField generateTextField(controller, text, {enabled: true, Icon icon}) {
    return _generateTextField(controller, text, TextInputType.text, enabled, icon);
  }

  static TextField generateTextFieldPassword(controller, text, {enabled: true, Icon icon}) {
    return _generateTextField(controller, text, TextInputType.text, enabled, icon, obscureText: true);
  }

  static TextField generateTextFieldEmail(controller, text, {enabled: true, Icon icon}) {
    return _generateTextField(controller, text, TextInputType.emailAddress, enabled, icon);
  }

  static TextField generateTextFieldNumeric(controller, text, {enabled: true, Icon icon}) {
    return _generateTextField(controller, text, TextInputType.number, enabled, icon);
  }

  static TextField generateTextFieldPhone(controller, text, {enabled: true, Icon icon}) {
    return _generateTextField(controller, text, TextInputType.phone, enabled, icon);
  }

  static Widget generateTextFieldDatetime(context, controller, text, {enabled: true, Icon icon, onDateSet}) {
    var onTap;
    if (enabled) {
      onTap = () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(1800, 1, 1),
          maxTime: DateTime.now(),
          currentTime: DateTime.now(),
          onConfirm: onDateSet,
          locale: LocaleType.es
        );
      };
    }

    return Container(
      child: RawMaterialButton(
        onPressed: onTap,
        child: _generateTextField(controller, text, TextInputType.datetime, false, icon, color: Colors.black),
      ),
    );
  }

  static Text generateText(text, {double size: 16.0, FontWeight weight, Color color: Colors.black}) {
    return Text(
      text,
      style: _generateTextStyle(size: size, weight: weight, color: color),
    );
  }

  static TextField _generateTextField(controller, text, TextInputType textInputType, enabled, icon, {obscureText: false, color}) {
    return TextField(
      enableInteractiveSelection: enabled,
      enabled: enabled,
      obscureText: obscureText,
      controller: controller,
      keyboardType: textInputType,
      style: _generateTextStyle(
        color: color != null ? color : (enabled ? Colors.black : Colors.black54)
      ),
      decoration: _generateDecoration(text, icon)
    );
  }

  static InputDecoration _generateDecoration(text, icon) {
    return InputDecoration(
      labelText: text,
      labelStyle: _generateTextFieldStyle(),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      icon: icon
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
    return _generateTextStyle(
      weight: FontWeight.bold,
      color: Colors.grey
    );
  }
}
