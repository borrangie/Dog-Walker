import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/authentication/apply_dog_walker.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/toast_factory.dart';
import 'package:dogwalker2/screens/components/user_info_factory.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController dniController = TextEditingController();
  DogOwner user;

  @override
  void initState() {
    super.initState();
    user = Store.instance.user;
    nameController.text = user.name;
    surnameController.text = user.surname;
    phoneController.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    Widget beAWalkerButton;
    Widget beAWalkerBox;
    Widget userWidget;

    if (user is DogOwner) {
      beAWalkerButton = ButtonFactory.generate("QUIERO SER PASEADOR", _applyDogWalker);
      beAWalkerBox = SizedBox(
        height: 15,
      );
      userWidget = UserInfoFactory.generateDogOwner(nameController, surnameController, phoneController);
    } else {
      beAWalkerButton = Container();
      beAWalkerBox = Container();
      userWidget = UserInfoFactory.generateDogWalker(context, nameController, surnameController, dateTimeController, () {}, phoneController, dniController);
    }

    return Scaffold(
      appBar: AppBarFactory.generateBack(
        context,
        "Mi perfil",
        color: Colors.red,
        textColor: Colors.white,
        buttonColor: Colors.white
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        children: <Widget>[
          _generateCard(),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: userWidget,
          ),
          SizedBox(
            height: 30,
          ),
          ButtonFactory.generateOutline("GUARDAR", _saveToDB),
          beAWalkerBox,
          beAWalkerButton,
        ],
      ),
    );
  }

  Container _generateCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70)),
      ),
      child: UserInfoFactory.generateAvatar(user, () {})
    );
  }

  void _saveToDB() async {
    String phone = phoneController.text = phoneController.text.trim();
    if (phone.isEmpty) {
      ToastFactory.showError("Necesita colocar un telefono valido");
    } else {
      if (!await FirebaseRepository.setPhoneNumber(phone)) {
        ToastFactory.showError("Error guardando. Intente mas tarde");
      } else {
        ToastFactory.showInfo("Guardado.");
      }
    }
  }

  void _applyDogWalker() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ApplyDogWalkerPage();
        }
      )
    );
  }
}
