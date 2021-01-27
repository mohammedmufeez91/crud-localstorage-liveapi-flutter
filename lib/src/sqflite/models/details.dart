
class Note {

  int _id;
  String _fulname;
  String _email;
  int _is_Synced;
  String _age;
  String _date;
  int _priority;

  Note(this._fulname, this._email,this._is_Synced,this._date, this._priority, [this._age]);

  Note.withId(this._id, this._fulname,this._email,this._is_Synced, this._date, this._priority, [this._age]);

  int get id => _id;

  String get fullname => _fulname;

  String get age => _age;

  String get email => _email;

  int get issynced => _is_Synced;


  int get priority => _priority;

  String get date => _date;



  set fullname(String newTitle) {
    if (newTitle.length <= 255) {
      this._fulname = newTitle;
    }
  }

  set email(String newTitle) {
    this._email = newTitle;

  }

  set issynced(int issynced) {
    this._is_Synced = issynced;
  }

  set age(String newDescription) {
    this._age = newDescription;
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['fullname'] = _fulname;
    map['age'] = _age;
    map['email'] = _email;
    map['issynced'] = _is_Synced;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._fulname = map['fullname'];
    this._age = map['age'];
    this._age = map['email'];
    this._is_Synced = map['issynced'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}

