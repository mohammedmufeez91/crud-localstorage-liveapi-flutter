

import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/src/sqflite/notes_screen/local_home_screen.dart';
import 'package:flutter_crud_api_sample_app/src/ui/formadd/form_add_screen.dart';
import 'package:flutter_crud_api_sample_app/src/ui/home/home_screen.dart';

class DrawerManager{
static final DrawerManager _singleton = DrawerManager._internal();
factory DrawerManager() => _singleton;
DrawerManager._internal();
static DrawerManager get shared => _singleton;

    setDrawer(BuildContext context,String name,String email){
          return new Drawer(
            child: new Container(
              color: Colors.white,
              child: ListView(
                  padding: new EdgeInsets.all(0.0),
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                          accountName: new Text(name,
                            style: new TextStyle(
                              fontSize: 20,
                              color: Colors.black
                            )
                          ),
                          accountEmail: new Text(email,
                            style: new TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )
                          ),
                          currentAccountPicture: new GestureDetector(
                            onTap: (){
                              },
                              child: new CircleAvatar(
                             // backgroundImage: new AssetImage('Assets/profile.png'),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white
                          ),
                      ),
                    new ListTile(
                      title: new Text('Live data',
                      style: new TextStyle(
                        fontSize: 20,
                        color: Colors.red
                      )
                      ),
                      //leading: _setContainer('Assets/saloon.png'),
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomeScreen())
                        ,ModalRoute.withName('/HomeScreen'));
                      },
                    ),
                    new ListTile(
                      title: new Text('Local data',
                          style: new TextStyle(
                              fontSize: 20,
                              color: Colors.red
                          )
                      ),
                      //leading: _setContainer('Assets/tourist.png'),
                      onTap: (){
                        Navigator.of(context).
                        pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LocalHomeScreen())
                            ,ModalRoute.withName('/LocalHomeScreen'));
                      },
                    ),


                    Divider(color:Colors.grey,),
                  /*  ExpansionTile(
                      title: new Text('Select Theme',
                      style: new TextStyle(
                        fontSize: 20,
                        color: Colors.red
                         )
                      ),
                      initiallyExpanded: false,
                      backgroundColor: Theme.of(context).accentColor.withOpacity(0.025),
                            children: <Widget>[
                              new ListTile(
                                title: const Text('Dark',style:  TextStyle(
                                  color: Colors.teal,
                                ),),
                                onTap: () {
                                  SharedManager.shared.themeType = 'dark';
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
                                },      
                                leading: _setContainer('Assets/dark.png'),        
                              ),
                              new ListTile(
                                title: const Text('Light',style:  TextStyle(
                                  color: Colors.teal,
                                ),
                                ),
                                onTap: () {
                                  SharedManager.shared.themeType = 'light';
                                  Navigator.pop(context);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
                                },              
                                leading: _setContainer('Assets/light.png'),
                              ),
                        ],
                    ),
                    new ListTile(
                      title: new Text('Share',
                      style: new TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      )
                      ),
                      leading: new Icon(Icons.share,color: Colors.grey[800],),
                      onTap: () async{
                      },
                    ),
                    new ListTile(
                      title: new Text('Rate us',
                      style: new TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      )
                      ),
                      leading: new Icon(Icons.star,color: Colors.grey[800],),
                      onTap: () async{
                      },
                    ),*/
                  ],
                ),
               )
              );
  }

//This is for the latitude
    var latitude = "";
    var longitude = "";
    var radius = "20000";
    var title = "Enter Your Location";
    var currentTitle = "";
    var isFromDrawer = true;

    double currentlati = 0;
    double currentlong = 0;
}


_setContainer(String imageString){
 return new Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageString)
            )
          ),
        );
}

class Language {
  final String code;
  final String name;
  const Language(this.name, this.code);
  int get hashCode => code.hashCode;
  bool operator==(Object other) => other is Language && other.code == code;
}


