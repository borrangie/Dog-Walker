import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/components/toast_factory.dart';
import 'package:dogwalker2/screens/components/user_info_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApplyDogWalkerPage extends StatefulWidget {
  @override
  ApplyDogWalkerPageState createState() => ApplyDogWalkerPageState();
}

class ApplyDogWalkerPageState extends State<ApplyDogWalkerPage> {
  DogOwner user = Store.instance.user;
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController dateTimeController = new TextEditingController();
  TextEditingController dniController = new TextEditingController();
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    nameController.text = user.name;
    surnameController.text = user.surname;
    phoneController.text = user.phone;
    dateTimeController.text = TextFactory.formatDate(dateTime);

    return buildAll(
        context,
        "Tengo perros",
        UserInfoFactory.generateDogWalkerApply(context, nameController, surnameController, dateTimeController, (DateTime date) {
          dateTimeController.text = TextFactory.formatDate(date);
          dateTime = date;
        }, phoneController, dniController)
    );
  }

  Widget buildAll(BuildContext context, String titleText, Widget userWidget) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBarFactory.generate(context, titleText),
        body: SingleChildScrollView(
            reverse: true,
            child: Padding(
                padding: EdgeInsets.only(
                    top: 25,
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextFactory.generateText("Completar registro", size: 26.0, weight: FontWeight.bold),
                    ),
                    userWidget,
                    SizedBox(
                      height: 50,
                    ),
                    ButtonFactory.generate("CONTINUAR", _continue)
                  ],
                )
            )
        ),
      ),
    );
  }

  void _continue() async {
    if (hasEmptyFields()) {
      ToastFactory.showError("Hay campos faltantes.");
    } else {
      if (await saveToDB()) {
        Store.instance.user = await FirebaseRepository.getCurrentUser();
        Navigator.pop(context);
      } else {
        ToastFactory.showError("Error completando registro.");
      }
    }
  }

  Future<bool> saveToDB() async {
    try {
      return await FirebaseRepository.setDogWalker({
        "phone": phoneController.text,
        "dni": dniController.text,
        "birthday": dateTime
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool hasEmptyFields() {
    String phone = phoneController.text = phoneController.text.trim();
    String dni = dniController.text = dniController.text.trim();

    return phone.isEmpty || dni.isEmpty || dateTime == null;
  }
}
