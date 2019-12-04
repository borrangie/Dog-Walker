import 'package:dogwalker2/models/users/dog.dart';
import 'package:dogwalker2/screens/components/text_factory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class DogFactory {
  static Widget createDogCard(Dog dog, BuildContext context, {selectable: false, Function onTap}) {
    if (onTap == null) onTap = () {};
    return GestureDetector(
      onTap: onTap,
      child: Padding(
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
                          TextFactory.generateText(
                              dog.weight.toString() + 'kg',
                              size: 12.0,
                              color: Colors.grey
                          ),
                          SizedBox(width: 25.0),
                          Icon(FontAwesomeIcons.ruler, color: Color(0xFFF75A4C), size: 15.0),
                          SizedBox(width: 15.0),
                          TextFactory.generateText(
                              dog.height.toString() + 'cm',
                              size: 12.0,
                              color: Colors.grey
                          ),
                          SizedBox(width: 25.0),
                          Icon(FontAwesomeIcons.gift,
                              color: Color(0xFFF75A4C), size: 15.0),
                          SizedBox(width: 5.0),
                          TextFactory.generateText(
                              (DateTime.now().year - dog.birthday.year).toString() + ' años',
                              size: 12.0,
                              color: Colors.grey
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
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10.0),
                        TextFactory.generateText(
                            dog.name,
                            size: 15.0,
                            color: Colors.black
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          width: 175.0,
                          child: TextFactory.generateText(
                              dog.info + "\n" + (dog.castrado ? "C" : "No c") + "astrado",
                              size: 12.0,
                              color: Colors.black54
                          ),
                        ),
                        TextFactory.generateText(
                            dog.breed,
                            size: 15.0,
                            color: Colors.redAccent
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
