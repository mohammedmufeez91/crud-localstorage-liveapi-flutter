import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_api_sample_app/src/DrawerManager.dart';
import 'package:flutter_crud_api_sample_app/src/bloc/bloc.dart';
import 'package:flutter_crud_api_sample_app/src/sqflite/notes_screen/local_home_screen.dart';
import 'package:flutter_crud_api_sample_app/src/ui/formadd/form_add_screen.dart';
import 'package:flutter_crud_api_sample_app/src/ui/home/home_screen.dart';


GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatelessWidget {
  // @override
  // _AppState createState() => _AppState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CRUD",
      home: _AppState(),
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
    );*/

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CRUD",
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (context) => NetworkBloc()..add(ListenConnection()),
          child: _AppState(),
        ),
      ),
    );
  }
}

class _AppState extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      key: _scaffoldState,
       drawer: Drawer(
         // Add a ListView to the drawer. This ensures the user can scroll
         // through the options in the drawer if there isn't enough vertical
         // space to fit everything.
         child: ListView(
           // Important: Remove any padding from the ListView.
           padding: EdgeInsets.zero,
           children: <Widget>[
             DrawerHeader(
               child: Text(''),
               decoration: BoxDecoration(
                 color: Colors.orange,
               ),
             ),
             ListTile(
               title: Text('Live data'),
               onTap: () async {

                 Navigator.pop(context);
                 var result = await Navigator.push(
                   _scaffoldState.currentContext,
                   MaterialPageRoute(builder: (BuildContext context) {
                     return HomeScreen();
                   }),
                 );
               },
             ),
             ListTile(
               title: Text('Local data'),
               onTap: () async{
                 Navigator.pop(context);
                 var result = await Navigator.push(
                   _scaffoldState.currentContext,
                   MaterialPageRoute(builder: (BuildContext context) {
                     return LocalHomeScreen();
                   }),
                 );
                 // Update the state of the app
                 // ...
                 // Then close the drawer
                 Navigator.pop(context);
               },
             ),
           ],
         ),
       ),

      appBar: AppBar(
        title: Text(
          "Flutter CRUD API",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () async {
              var result = await Navigator.push(
                _scaffoldState.currentContext,
                MaterialPageRoute(builder: (BuildContext context) {
                  return FormAddScreen();
                }),
              );
              // if (result != null) {
              //   setstate(() {});
              // }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: HomeScreen(),
    );
  }

  void gotoHomeScreen(context) async {
    ///SHare String , int , bool, double
    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FormAddScreen(profile: null);
    }));
  }

}
