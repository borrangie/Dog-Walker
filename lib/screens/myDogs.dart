import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogwalker2/resources/firebase_repository.dart';
import 'package:dogwalker2/screens/addDog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'homeScreen2.dart';

class DogsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyDogsPage(),
    );
  }
}

class MyDogsPage extends StatefulWidget {
  @override
  _MyDogsPageState createState() => _MyDogsPageState();
}

class _MyDogsPageState extends State<MyDogsPage> {
  FirebaseRepository _firebaseRepository = new FirebaseRepository();
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _firebaseRepository.getCurrentUser();
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
                return HomeScreen2();
              }));
              //Navigator.pop(context);
            },
          )),
      body: Column(
        children: <Widget>[
          Container(
            height: 105,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70)),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    FontAwesomeIcons.dog,
                    color: Colors.white,
                    size: 80,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text('Perros',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40.0,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance.collection('d').where('i', isEqualTo: user.uid).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: Text('Cargando...', style: TextStyle(color: Colors.red, fontSize: 20),),
                  );
                  
                }else{
                  return ListView.builder(
                    itemExtent: 190,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index)=>
                      _listItem(snapshot.data.documents[index], context),
                  );
                }
              }
            ),
          ),
          
          
         
        ],
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddDog();
                    }));
      },
      child: Icon(FontAwesomeIcons.plus),
      backgroundColor: Colors.red,
    ),
    );
  }
}

Widget _listItem(DocumentSnapshot doc, BuildContext context) {
  Timestamp d = doc['e']; 
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(d.seconds * 1000);
  int years = DateTime.now().year - date.year;
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
                      Icon(FontAwesomeIcons.weightHanging, color: Color(0xFFF75A4C), size: 15.0),
                      SizedBox(width: 10.0),
                      Text(
                        doc['p'].toString(),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey),
                      ),
                      SizedBox(width: 25.0),
                      Icon(FontAwesomeIcons.ruler, color: Color(0xFFF75A4C), size: 15.0),
                      SizedBox(width: 15.0),
                      Text(
                        doc['a'].toString() + 'cm',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 12.0,
                            color: Colors.grey),
                      ),
                      SizedBox(width: 25.0),
                      Icon(FontAwesomeIcons.gift,
                          color: Color(0xFFF75A4C), size: 15.0),
                      SizedBox(width: 5.0),
                      Text(
                        years.toString()+' años',
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
            border: Border.all(color: Color(0xFFF9EFEB), width: 8),
            // boxShadow: [
            //         BoxShadow(
            //             color: Colors.grey.withOpacity(0.3),
            //             spreadRadius: 3.0,
            //             blurRadius: 3.0)]
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
                      // image: AssetImage(imgPath),
                      image: AssetImage('assets/images/dog.jpg'),
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
                      doc['n'],
                      style: TextStyle(
                          color: Color(0xFF563734),
                          fontFamily: 'Montserrat',
                          fontSize: 15.0),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: 175.0,
                      child: Text(
                        doc['ca'],
                        style: TextStyle(
                            color: Color(0xFFB2A9A9),
                            fontFamily: 'Montserrat',
                            fontSize: 11.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      doc['r'],
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