import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_owner.dart';
import 'package:dogwalker2/screens/components/user_info_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FinishSignUpDogWalkerPage extends StatefulWidget {
  @override
  _FinishSignUpDogWalkerPageState createState() => _FinishSignUpDogWalkerPageState();
}

class _FinishSignUpDogWalkerPageState extends FinishSignUpDogOwnerPageState {
  TextEditingController dniController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildAll(
        context,
        "Tengo perros",
        UserInfoFactory.generateDogWalkerSetUp(nameController, surnameController, dateTimeController, phoneController, dniController)
    );
  }
}
