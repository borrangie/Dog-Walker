

import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/my_dogs.dart';
import 'package:dogwalker2/screens/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'authentication/login_screen.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DogOwner user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = Store.instance.user;
    user = await FirebaseRepository.getCurrentUser();
    setState(() {});
  }

  Widget _textName(){
    if(user?.name == null){
      return Text('Usuario');
    }else{
      return Text("${user?.name} ${user?.surname}");
    }
  }

  @override
  Widget build(BuildContext context) {
    UserAccountsDrawerHeader userAccountsDrawerHeader = UserAccountsDrawerHeader(
      accountName: _textName(),
      accountEmail: Text("${user?.email}"),
      currentAccountPicture: CircleAvatar(
//                backgroundImage: NetworkImage("${user?.photoUrl}"),
        backgroundImage: NetworkImage(""),
      ),
      decoration: BoxDecoration(
        color: Colors.red,
      ),
    );
    Drawer drawer = Drawer(
      child: ListView(
        children: <Widget>[
          userAccountsDrawerHeader,
          InkWell(
            onTap: () {
            },
            child: ListTile(
              title: Text('Inicio'),
              leading: Icon(
                FontAwesomeIcons.home,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return UserInfoPage();
                  }));
            },
            child: ListTile(
              title: Text('Mi Perfil'),
              leading: Icon(
                Icons.person,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return DogsPage();
                  }));
            },
            child: ListTile(
              title: Text('Mis Perros'),
              leading: Icon(
                FontAwesomeIcons.dog,
                color: Colors.red,
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('Configuración'),
              leading: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: Text('About Us'),
              leading: Icon(
                Icons.help,
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              logout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return LogInPage();
                  }));
            },
            child: ListTile(
              title: Text('Log Out'),
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBarFactory.generateBack(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ButtonFactory.generateIcon
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      image: DecorationImage(
                          image: AssetImage('assets/images/dwlogo.png'),
                          fit: BoxFit.cover)
                  )
              ),
            ],
          ),
          buttonType: AppBarFactory.buttonTypeDrawer,
          buttonColor: Colors.black,
          onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFactory.generateText("Busca un Paseo", size: 30.0, color: Colors.red, weight: FontWeight.bold),
                  TextFactory.generateText("Busca paseadores en tu zona", size: 18.0, weight: FontWeight.bold),
                ],
              ),
            ),
          ],
        ),
        drawer: drawer
    );
  }
}

Widget _buildListItem(String imgPath, String name, String price, String rate) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 6,
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: 175,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 64, 0, 0.5),
                      Color.fromRGBO(255, 0, 43, 0.5)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
            ),
            Hero(
              tag: imgPath,
              child: Container(
                height: 175,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
              ),
            ),
            Positioned(
              top: 160,
              right: 20,
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(name,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14)),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: 175,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              rate,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.grey,
                                  fontSize: 12.0),
                            ),
                            SizedBox(width: 3.0),
                            Icon(Icons.star, color: Colors.green, size: 14.0),
                            Icon(Icons.star, color: Colors.green, size: 14.0),
                            Icon(Icons.star, color: Colors.green, size: 14.0),
                            Icon(Icons.star, color: Colors.green, size: 14.0),
                            Icon(Icons.star, color: Colors.green, size: 14.0),
                          ],
                        ),
                        Text(price,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16.0)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget _listItem(String imgPath, String foodName, String desc, String price,
    int likes, int calCount, String serving, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 15.0, top: 15.0),
    child: Stack(
      children: <Widget>[
        Container(
          height: 170.0,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          left: 15.0,
          top: 30.0,
          child: Container(
            height: 125.0,
            width: MediaQuery.of(context).size.width - 15.0,
            decoration: BoxDecoration(
                color: Color(0xFFF9EFEB),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3.0,
                      blurRadius: 3.0)
                ]),
            // child: Text('Helloworld'),
          ),
        ),
        Positioned(
            left: 95.0,
            top: 64.0,
            child: Container(
              height: 105.0,
              width: MediaQuery.of(context).size.width - 15.0,
              decoration: BoxDecoration(
                  color: Color(0xFFF9EFEB),
                  borderRadius: BorderRadius.circular(5.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3.0,
                        blurRadius: 3.0)
                  ]),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Color(0xFFF75A4C), size: 15.0),
                      SizedBox(width: 5.0),
                      Text(
                        likes.toString(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey),
                      ),
                      SizedBox(width: 25.0),
                      Icon(Icons.people, color: Color(0xFFF75A4C), size: 15.0),
                      SizedBox(width: 5.0),
                      Text(
                        calCount.toString() + 'cal',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey),
                      ),
                      SizedBox(width: 25.0),
                      Icon(Icons.play_circle_outline,
                          color: Color(0xFFF75A4C), size: 15.0),
                      SizedBox(width: 5.0),
                      Text(
                        serving,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            )),
        Container(
          height: 125.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),

                // Image.asset(imgPath, fit: BoxFit.cover,),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      foodName,
                      style: TextStyle(
                          color: Color(0xFF563734),
                          fontFamily: 'Montserrat',
                          fontSize: 15.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: 175.0,
                      child: Text(
                        desc,
                        style: TextStyle(
                            color: Color(0xFFB2A9A9),
                            fontFamily: 'Montserrat',
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      price.toString(),
                      style: TextStyle(
                          color: Color(0xFFF76053),
                          fontFamily: 'Montserrat',
                          fontSize: 15.0),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

logout() {
  FirebaseRepository.logout();
}

