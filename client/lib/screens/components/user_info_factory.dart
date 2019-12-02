import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:flutter/material.dart';

abstract class UserInfoFactory {
  static Container generateDogOwnerSetUp(nameController, surnameController, dateTimeController, phoneController) {
    return _generate(
        _generateDogOwnerWidgets(
            nameController,
            surnameController,
            dateTimeController,
            phoneController,
            enabled: true
        )
    );
  }

  static Container generateDogOwner(nameController, surnameController, dateTimeController, phoneController) {
    return _generate(
        _generateDogOwnerWidgets(
            nameController,
            surnameController,
            dateTimeController,
            phoneController
        )
    );
  }

  static Container generateDogWalkerSetUp(
      nameController,
      surnameController,
      dateTimeController,
      phoneController,
      dniController,
      {enabled: false}
      ) {
    return _generate(
        _generateDogWalkerWidgets(
            nameController,
            surnameController,
            dateTimeController,
            phoneController,
            dniController,
            enabled: true
        )
    );
  }

  static Container generateDogWalker(
      nameController,
      surnameController,
      dateTimeController,
      phoneController,
      dniController,
      {enabled: false}
      ) {
    return _generate(
        _generateDogWalkerWidgets(
            nameController,
            surnameController,
            dateTimeController,
            phoneController,
            dniController
        )
    );
  }

  static Container _generate(List<Widget> widgets) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: widgets,
      ),
    );
  }

  static List<Widget> _generateDogOwnerWidgets(nameController, surnameController, dateTimeController, phoneController, {enabled: false}) {
    return [
      TextFactory.generateTextField(nameController, "Nombre(s)", enabled: enabled),
      SizedBox(
        height: 10,
      ),
      TextFactory.generateTextField(surnameController, "Apellido(s)", enabled: enabled),
      SizedBox(
        height: 10,
      ),
      TextFactory.generateTextFieldDatetime(dateTimeController, "Fecha de nacimiento", enabled: enabled),
      SizedBox(
        height: 10,
      ),
      TextFactory.generateTextFieldPhone(phoneController, "Telefono", enabled: true)
    ];
  }

  static List<Widget> _generateDogWalkerWidgets(
      nameController,
      surnameController,
      dateTimeController,
      phoneController,
      dniController,
      {enabled: false}
      ) {
    List<Widget> widgets = _generateDogOwnerWidgets(nameController, surnameController, dateTimeController, phoneController, enabled: enabled);

    widgets.addAll([
      SizedBox(
        height: 10,
      ),
      TextFactory.generateTextFieldNumeric(dniController, "DNI", enabled: enabled),
    ]);

    return widgets;
  }
}
