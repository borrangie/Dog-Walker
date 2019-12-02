import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/components/toast_factory.dart';
import 'package:dogwalker2/screens/components/user_info_factory.dart';
import 'package:dogwalker2/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FinishSignUpDogOwnerPage extends StatefulWidget {
  @override
  FinishSignUpDogOwnerPageState createState() => FinishSignUpDogOwnerPageState();
}

class FinishSignUpDogOwnerPageState extends State<FinishSignUpDogOwnerPage> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController dateTimeController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildAll(
        context,
        "Tengo perros",
        UserInfoFactory.generateDogOwnerSetUp(nameController, surnameController, dateTimeController, phoneController)
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeScreenPage();
          })
        );
      } else {
        ToastFactory.showError("Error completando registro.");
      }
    }
  }

  Future<bool> saveToDB() async {
    return true;

//      try {
//        await FirebaseRepository.signIn(mail, password);
//        _authenticateUser();
//      } catch (e) {
//        ToastFactory.showError("User does not exist");
//      }
  }

  bool hasEmptyFields() {
    String name = nameController.text;
    String surname = surnameController.text;
    String dateTime = dateTimeController.text;
    String phone = phoneController.text;

    return name.isEmpty || surname.isEmpty || dateTime.isEmpty || phone.isEmpty;
  }
}
