import 'package:dogwalker2/models/users/dog_owner.dart';
import 'package:dogwalker2/remote/firebase_repository.dart';
import 'package:dogwalker2/resources/store.dart';
import 'package:dogwalker2/screens/authentication/login_screen.dart';
import 'package:dogwalker2/screens/components/app_bar_factory.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:dogwalker2/screens/dogs/my_dogs.dart';
import 'package:dogwalker2/screens/home/search_screen.dart';
import 'package:dogwalker2/screens/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'hired_screen.dart';


class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController dateTimeController = new TextEditingController();
  DogOwner user = Store.instance.user;
  int _navBarIndex = 0;

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
                          fit: BoxFit.cover
                      )
                  )
              ),
            ],
          ),
          buttonColor: Colors.black,
          onPressed: () => _scaffoldKey.currentState.openDrawer()
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 7,
          currentIndex: _navBarIndex,
          onTap: (newIndex) {
            setState(() {
              _navBarIndex = newIndex;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text("Buscar"),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.today
              ),
              title: Text("Contratado")
            )
          ],
        ),
        body: _navBarIndex == 0 ?
        SearchScreenWidget() : HiredScreenWidget(),
        drawer: drawer
    );
  }
}
