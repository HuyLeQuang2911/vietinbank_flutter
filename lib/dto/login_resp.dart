import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginResp extends GetxController {
  late int id;
  late String user;
  late String name;
  late String password;
  late String status;

  LoginResp(this.id, this.user, this.name, this.password, this.status);

  LoginResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    name = json['name'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['name'] = this.name;
    data['password'] = this.password;
    data['status'] = this.status;
    return data;
  }
}