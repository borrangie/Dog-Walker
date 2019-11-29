import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  TextEditingController nameController;
  TextEditingController mailController;
  TextEditingController phoneController;
  TextEditingController cityController;
  TextEditingController addressController;
  DogOwner user;
  DateTime date;

  @override
  void initState() {
    super.initState();
    initUser();
    initControllers();
  }

  initControllers() async {
    print(await FirebaseRepository.getCurrentUser());
    // TODO
//    data = await _firebaseRepository.getCurrentUser();
//    this.nameController = new TextEditingController(text: data['n']);
//    this.phoneController = new TextEditingController(text: data['t']);
//    this.cityController = new TextEditingController(text: data['l']);
//    this.addressController = new TextEditingController(text: data['d']);

    setState(() {});
  }

  initUser() async {
    user = await FirebaseRepository.getCurrentUser();
    this.mailController = new TextEditingController(text: user.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomeScreenPage();
              }));
              //Navigator.pop(context);
            },
          )),
      body: ListView(
        children: <Widget>[
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70)),
            ),
            child: GestureDetector(
              child: Center(
                child: CircleAvatar(
                  radius: 60.0,
//                  backgroundImage: NetworkImage("${user?.photoUrl}"), TODO
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 55, left: 20, right: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.red,
                      ),
                      labelText: 'Nombre Y Apellido',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: mailController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: Colors.red,
                      ),
                      labelText: 'MAIL',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: Colors.red,
                      ),
                      labelText: 'TELEFONO',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.city,
                        color: Colors.red,
                      ),
                      labelText: 'LOCALIDAD',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.home,
                        color: Colors.red,
                      ),
                      labelText: 'DIRECCION',
                      labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                ]),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            onPressed: () {
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(1900, 1, 1),
                  maxTime: DateTime.now(), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
                setState(() {
                  this.date = date;
                });
              }, currentTime: DateTime.now(), locale: LocaleType.es);
            },
            child: _getDateFormated(),
          ),
          SizedBox(
            height: 30,
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.red, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.red, width: 3),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  'Ser Paseador',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  _getDateFormated() {
    if (date != null) {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 5,
            ),
            Icon(
              FontAwesomeIcons.calendarAlt,
              color: Colors.red,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              date.day.toString() +
                  '/' +
                  date.month.toString() +
                  '/' +
                  date.year.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 5,
              ),
              Icon(
                FontAwesomeIcons.calendarAlt,
                color: Colors.red,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'CUMPLEAÑOS',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  // _getDateFormated() {
  //   if (date != null) {
  //     return Container(
  //       width: double.infinity,
  //       height: 50,
  //       decoration: BoxDecoration(
  //           color: Colors.red,
  //           borderRadius: BorderRadius.all(Radius.circular(15))),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Icon(
  //             FontAwesomeIcons.calendarAlt,
  //             color: Colors.white,
  //           ),
  //           SizedBox(
  //             width: 20,
  //           ),
  //           Container(
  //             width: 50,
  //             height: 35,
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.all(Radius.circular(10))),
  //             child: Center(
  //               child: Text(
  //                 date.day.toString(),
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 22,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Container(
  //             width: 50,
  //             height: 35,
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.all(Radius.circular(10))),
  //             child: Center(
  //               child: Text(
  //                 date.month.toString(),
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 22,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //           SizedBox(
  //             width: 10,
  //           ),
  //           Container(
  //             width: 87,
  //             height: 35,
  //             decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.all(Radius.circular(10))),
  //             child: Center(
  //               child: Text(
  //                 date.year.toString(),
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 22,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return Container(
  //       width: double.infinity,
  //       height: 50,
  //       decoration: BoxDecoration(
  //           color: Colors.red,
  //           borderRadius: BorderRadius.all(Radius.circular(15))),
  //       child: Center(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(
  //               FontAwesomeIcons.calendarAlt,
  //               color: Colors.white,
  //             ),
  //             SizedBox(
  //               width: 20,
  //             ),
  //             Text(
  //               'Fecha de Nacimiento',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 22,
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
}
