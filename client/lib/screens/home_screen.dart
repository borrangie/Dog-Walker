

import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/models/walk.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/button_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/my_dogs.dart';
import 'package:dogwalker2/screens/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'authentication/login_screen.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  DogOwner user = Store.instance.user;
  TextEditingController dateTimeController = new TextEditingController();

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
              FirebaseRepository.logout();
              Store.instance.user = null;
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
        appBar: AppBarFactory.generateDrawer(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            TextFactory.generateText("Buscar un paseo", size: 20.0),
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
          buttonColor: Colors.black,
          onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    ButtonFactory.generateIcon(Icons.today, () {}),
                    TextFactory.generateText("Selecciona una fecha", color: Colors.grey)
                  ],
                ),
                Row(
                  children: <Widget>[
                    ButtonFactory.generateIcon(Icons.watch_later, () {}),
                    TextFactory.generateText("Selecciona una hora", color: Colors.grey)
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                  future: FirebaseRepository.getWalks(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFactory.generateText("No se encontraron resultados", size: 18.0),
                          SizedBox(
                            height: 10,
                          ),
                          TextFactory.generateText("Reduce los filtros o prueba en otro momento", size: 16.0)],
                      );
                    } else {
                      print(snapshot.data);
                      return _buildListWalks(context, snapshot.data);
                    }
                  },
                )
              ],
            ),
          ],
        ),
        drawer: drawer
    );
  }
}

Widget _buildListWalks(BuildContext context, List<Walk> walks) {
  List<Widget> widgets = [];
  for (var walk in walks) {
    widgets.add(_buildListWalk(context, walk));
  }

  return Column(
    children: widgets,
  );
}

Widget _buildListWalk(BuildContext context, Walk walk) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle, size: 50, color: Colors.red,),
          title: Row(
            children: <Widget>[
              TextFactory.generateText(
                  "\$" + walk.cost.toString() + "/h",
                  size: 20.0
              ),
              TextFactory.generateText(
                  " - "
                      + walk.dayOfWeek
                      + " - "
                      + DateFormat("HH:mm").format(walk.day)
                      + " - "
                      + DateFormat("HH:mm").format(walk.day.add(Duration(hours: walk.hours))),
                  size: 18.0
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFactory.generateText(
                walk.dogWalker.name + " " + walk.dogWalker.surname + "",
                color: Colors.grey
              ),
              TextFactory.generateText(
                (walk.maxDogs - walk.dogsQuantity).toString()
                    + " cupos disponibles",
                color: Colors.grey
              ),
            ],
          )
        ),
      ],
    ),
  );
}
