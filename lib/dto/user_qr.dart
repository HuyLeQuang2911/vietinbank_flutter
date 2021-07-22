class UserQR {
  String username;
  String password;
  String sessionCode;
  UserQR(this.username, this.password, this.sessionCode);

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'sessionCode' : sessionCode
  };

}