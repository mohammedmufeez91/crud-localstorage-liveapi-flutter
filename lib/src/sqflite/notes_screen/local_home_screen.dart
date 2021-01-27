import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud_api_sample_app/src/DrawerManager.dart';
import 'package:flutter_crud_api_sample_app/src/api/api_service.dart';
import 'package:flutter_crud_api_sample_app/src/bloc/bloc.dart';
import 'package:flutter_crud_api_sample_app/src/model/profile.dart';
import 'package:flutter_crud_api_sample_app/src/sqflite/models/details.dart';
import 'package:flutter_crud_api_sample_app/src/sqflite/notes_screen/notes_detail.dart';
import 'package:flutter_crud_api_sample_app/src/sqflite/utils/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class LocalHomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LocalHomeScreenState() ;
  }
}
GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class LocalHomeScreenState extends State<LocalHomeScreen>{

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count =0;
  ApiService _apiService = ApiService();
  DatabaseHelper helper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: Scaffold(
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
                      return LocalHomeScreen();
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          tooltip: "Click to add",
          child: Icon(Icons.add),
          onPressed: ()
          {
            navigateTOdetailPage(Note('','',0,'',0,''),"Add Note");
          },
        ),
        appBar: AppBar(
          title: Text(
            "Flutter CRUD API"+this.noteList.length.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          )),
        body: BlocProvider(
          create: (context) => NetworkBloc()..add(ListenConnection()),
          child: Container(
            child: BlocBuilder<NetworkBloc, NetworkState>(
              builder: (context, state) {
                if (state is ConnectionFailure)  return ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(

                        leading: CircleAvatar(
                          backgroundColor: getPriorityColor(this.noteList[position].priority),
                          child: getPriorityIcon(this.noteList[position].priority),
                        ),

                        title: Text(this.noteList[position].fullname, style: titleStyle,),

                        subtitle: Text(getstatus(position).toString()),

                        trailing: GestureDetector(
                          child: getIcon(position),
                          onTap: () {
                            _delete(context, noteList[position]);
                          },
                        ),

                        onTap: () {
                          debugPrint("ListTile Tapped");
                          navigateTOdetailPage(this.noteList[position],'Edit details');
                        },

                      ),
                    );
                  },
                );
                if (state is ConnectionSuccess)
                  {
                    return ListView.builder(
                      itemCount: count,
                      itemBuilder: (BuildContext context, int position) {
                        if(getstatus(position)==false)
                          {
                            syncdata(position);
                          }
                        return Card(
                          color: Colors.white,
                          elevation: 2.0,
                          child: ListTile(

                            leading: CircleAvatar(
                              backgroundColor: getPriorityColor(this.noteList[position].priority),
                              child: getPriorityIcon(this.noteList[position].priority),
                            ),

                            title: Text(this.noteList[position].fullname, style: titleStyle,),

                            subtitle: Text(getstatus(position).toString()),

                            trailing: GestureDetector(
                              child: getIcon(position),
                              onTap: () {
                                _delete(context, noteList[position]);
                              },
                            ),

                            onTap: () {
                              debugPrint("ListTile Tapped");
                              navigateTOdetailPage(this.noteList[position],'Edit details');
                            },

                          ),
                        );
                      },
                    );
                  }
                else
                  return Text("");
              },
            ),
          ),
        ),
      ),
    );

   // var statuscoming = status();

/*    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CRUD",
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (context) => NetworkBloc()..add(ListenConnection()),
          child: getdata(),
        ),
      ),
    );*/


    return Center(
      child: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is ConnectionFailure) return Text("No Internet Connection");
          if (state is ConnectionSuccess)
            return Text("You're Connected to Internet");
          else
            return Text("");
        },
      ),
    );

  }

  /*ListView getListview()
  {

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),

            title: Text(this.noteList[position].fullname, style: titleStyle,),

            subtitle: Text(getstatus(position).toString()),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateTOdetailPage(this.noteList[position],'Edit details');
            },

          ),
        );
      },
    );
  }*/

  Widget getdata()
  {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

   /* return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.noteList[position].priority),
              child: getPriorityIcon(this.noteList[position].priority),
            ),

            title: Text(this.noteList[position].fullname, style: titleStyle,),

            subtitle: Text(getstatus(position).toString()),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateTOdetailPage(this.noteList[position],'Edit details');
            },

          ),
        );
      },
    );*/

    return Container(
      child: BlocBuilder<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is ConnectionFailure){
            print("##fff-false");
            return Text("No Internet Connection");
          };
          if (state is ConnectionSuccess)
            {
              print("##fff-success");
              //syncdata();
              return Text("connected");
            }
          else
            return Text("no");
        },
      ),
    );
  }

  bool _isLoading = false;

  void syncdata(int position) async
  {
    print("##age--"+this.noteList[position].email.toString());
    Profile profile =
    Profile(name: this.noteList[position].fullname, email: this.noteList[position].age, age: int.parse("21"));

    _apiService.createProfile(profile).then((isSuccess) async {
      setState(() => _isLoading = false);

      if (isSuccess) {
        // Navigator.pop(_scaffoldState.currentState.context, true);
        print("##age-ssuccess-");
        this.noteList[position].date =
            DateFormat.yMMMd().format(DateTime.now());
        int result;
        this.noteList[position].issynced = 1;
        result = await helper.updateNote(this.noteList[position], 1);

        if(result!=0)
          {
            print("##age-listview-");
            updateListView();
          }

      } else {
        _scaffoldState.currentState.showSnackBar(SnackBar(
          content: Text("Submit data failed"),
        ));
      }
    });


  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

  bool getstatus(int pos)
  {
    return (this.noteList[pos].issynced==0) ? false:true;
  }

  Icon getIcon(int pos)
  {
    return (this.noteList[pos].issynced==0) ? Icon(Icons.sync, color: Colors.grey,):Icon(Icons.done, color: Colors.green,);
  }

  void navigateTOdetailPage(Note note,String title) async{
 bool result= await Navigator.push(context, MaterialPageRoute(builder: (context){
  return NotesDetail(note,title);
  }));

 if(result==true)
   {
     updateListView();
   }
}

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });

    print("##listsize"+this.noteList.length.toString());
  }

  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }


}