abstract class DBObject {
  String _id;

  DBObject(String id) {
    this._id = id;
  }

  String get id => _id;
}
