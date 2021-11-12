class User {

  // properties
  int? _id;
  String _username;
  String _password;

  // constructor
  User(this._id, this._username, this._password);

  // property getters
  String get username => _username;
  String get password => _password;

  factory User.fromJson(Map<String, dynamic> obj) {
    return User(
      obj['id'],
      obj['username'],
      obj['password']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id ?? '',
      'username': _username,
      'password': _password,
    };
  }

  @override
  String toString(){
    return 'User{_id: $_id, _username: $_username, _password: $_password}';
  }
}