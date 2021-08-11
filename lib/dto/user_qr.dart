class UserQR {
  String username;
  String password;
  String qrMsg;
  UserQR(this.username, this.password, this.qrMsg);

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'qrMsg' : qrMsg
  };

}