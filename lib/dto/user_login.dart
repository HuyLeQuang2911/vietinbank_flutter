import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserLogin extends GetxController{
  String username;
  String password;
  UserLogin(this.username, this.password);

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };

}