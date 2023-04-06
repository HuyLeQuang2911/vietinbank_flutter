import 'package:barcode_scan/barcode_scan.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart' hide Response ;
import 'package:viettinbank_money/dto/login_resp.dart';
import 'package:viettinbank_money/dto/user_login.dart';
import 'package:viettinbank_money/dto/user_qr.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult;
  final UserLogin login = Get.find();
  final String ip = Get.find();
  // final loginResp = Get.find();
  bool backCamera = true;

  Future<String> authAtm(String qrMsg) async {
    var options = BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);
    var req = UserQR(login.username , login.password , qrMsg);

    debugPrint('----------------req: ' + req.toJson().toString() + '  ip :' + ip);
    try {
      Response response = await dio.post('http://$ip/auth-service/mobi/authQrMobi', data: req.toJson());
      if (response.statusCode == 200) {
        Get.snackbar("OK", response.statusMessage.toString());
      } else {
        Get.snackbar("Hi", response.statusMessage.toString());
      }
      return Future.value("ok");
    } catch (e) {
      debugPrint('------- error api : ' + e.toString());
      if (e is DioError) {
        //handle DioError here by error type or by error code
        Get.defaultDialog(
            textConfirm: "Confirm",
            textCancel: "Cancel",
            middleText: e.response.statusCode.toString());
      } else {
        Get.defaultDialog(
            textConfirm: "Confirm",
            textCancel: "Cancel",
            middleText: e.toString());
        return Future.value(e.toString());
      }
    }
    return Future.value("???");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Scan using:" + (backCamera ? "Front Cam" : "Back Cam")),
          actions: <Widget>[
            IconButton(
              icon: backCamera
                  ? Icon(Ionicons.ios_camera_reverse)
                  : Icon(Icons.camera),
              onPressed: () {
                setState(() {
                  backCamera = !backCamera;
                  camera = backCamera ? 1 : -1;
                });
              },
            ),
            IconButton(
              icon: Icon(MaterialCommunityIcons.qrcode_scan),
              onPressed: () async {
                ScanResult codeSanner = await BarcodeScanner.scan(
                  options: ScanOptions(
                    useCamera: camera,
                  ),
                ); //barcode scnner
                setState(() {
                  // qrCodeResult = codeSanner.rawContent;
                  String qrMsg = codeSanner.rawContent;
                  if (qrMsg.isNotEmpty) {
                    authAtm(qrMsg).then((value) => qrCodeResult = value) ;
                  }

                });
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Fullname : ' + login.username ,style: TextStyle(fontSize: 20.0)),
              Text('IP :' + ip , style: TextStyle(fontSize: 20.0)),
              SizedBox(height: 20,),
              Text(
                (qrCodeResult == null)||(qrCodeResult == "")
                    ? "Please Scan to show some result"
                    : "Result:" + qrCodeResult,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
              ),
            ],
          )
        ));
  }
}

int camera = 1;