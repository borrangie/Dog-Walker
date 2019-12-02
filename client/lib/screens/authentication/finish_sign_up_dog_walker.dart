import 'package:dogwalker2/screens/authentication/finish_sign_up_dog_owner.dart';
import 'package:dogwalker2/screens/components/user_info_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FinishSignUpDogWalkerPage extends StatefulWidget {
  @override
  _FinishSignUpDogWalkerPageState createState() => _FinishSignUpDogWalkerPageState();
}

class _FinishSignUpDogWalkerPageState extends FinishSignUpDogOwnerPageState {
  TextEditingController dateTimeController = new TextEditingController();
  TextEditingController dniController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildAll(
        context,
        "Quiero pasear perros",
        UserInfoFactory.generateDogWalkerSetUp(context, nameController, surnameController, dateTimeController, (date) {}, phoneController, dniController)
    );
  }

  @override
  Future<bool> saveToDB() async {
    return super.saveToDB();
  }

  @override
  bool hasEmptyFields() {
    if (!super.hasEmptyFields()) {
      return dniController.text.isEmpty;
    }
    return true;
  }
}
