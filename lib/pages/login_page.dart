import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:google_fonts/google_fonts.dart';
import 'package:viettinbank_money/dto/login_resp.dart';
import 'package:viettinbank_money/dto/user_login.dart';

import 'menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController,
      passwordController,
      ipController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    ipController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Viet',
                    style: GoogleFonts.portLligatSans(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffe46b10),
                    ),
                    children: [
                      TextSpan(
                        text: 'tin',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      TextSpan(
                        text: 'Bank',
                        style:
                            TextStyle(color: Color(0xff10e44c), fontSize: 30),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username", usernameController),
        _entryField("Password", passwordController, isPassword: true),
        _entryField("IP", ipController),
      ],
    );
  }

  Widget _submitButton(BuildContext context) {
    return GestureDetector(
      onTap: () => login(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  void login() async {
    var options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);
    var req =
        Get.put(UserLogin(usernameController.text, passwordController.text));

    String ip = Get.put(ipController.text);
    debugPrint('req: ' + req.toJson().toString());
    try {
      Response response =
          await dio.post('http://$ip:8081/loginMobi', data: req.toJson());
      if (response.statusCode == 200) {
        // Get.put(LoginResp.fromJson(response.data));
        Get.to(MenuPage());
      } else {
        Get.snackbar("Hi", response.statusMessage.toString());
      }
    } catch (e) {
      debugPrint('------- error api : ' + e.toString());

      Get.defaultDialog(
          textConfirm: "Confirm",
          textCancel: "Cancel",
          middleText: e.toString());
    }
  }
}
