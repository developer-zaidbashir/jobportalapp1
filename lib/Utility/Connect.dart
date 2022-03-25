// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Connect {
  Uint8List binaryImageData;
  static bool hasInternet = false;
  static String userName = "";
  static String email = "";

  static String userNameRegister = "";
  static String emailRegister = "";
  static String phoneRegister = "";
  static bool isRegistrationSide = false;

  static Map<String, dynamic> registerDetails = {};
  static String AppRun() {
    String state = "0";
    return state;
  }

  static String AppURL() {
    String baseURL;
    if (AppRun() == "0") {
      baseURL = "http://192.168.0.20:9030/jobportal-app/api/";
    } else if (AppRun() == "1") {
      baseURL = "http://xxx.xxx.xxx.xxx:9030/jobportal-app/api/";
    }
    return baseURL;
  }

  static bool checkOtpLength(int otp) {
    int length = 0;
    int receivedOtp = otp;
    while (receivedOtp > 0) {
      receivedOtp = (receivedOtp / 10).floor();
      length++;
    }
    if (length == 6) {
      return true;
    } else {
      return false;
    }
  }

  static void checkInternetStatus() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    final color = hasInternet ? Colors.green : Colors.red;
    final text =
        hasInternet ? "Connected with Internet" : "Disconnected from Internet";
    showSimpleNotification(
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      background: color,
    );
  }

  static Future<void> storeData(SharedPreferences prefs) async {
    userName = prefs.getString("keyUsername");
    email = prefs.getString("keyEmail");
  }

  void getRegisterDetails({Map<String, dynamic> data}) {
    registerDetails = data;
  }

  static bool validateMyPan(String value) {
    Pattern pattern = "[A-Z]{5}[0-9]{4}[A-Z]{1}";
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  static bool validateMyPassport(String value) {
    Pattern pattern = '^[A-PR-WYa-pr-wy][1-9]\\d\\s?\\d{4}[1-9]\$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  void getRegisterDetailsAuth({Map<String, dynamic> data}) {
    userNameRegister = data['candidateName'];
    emailRegister = data['candidateEmail'];
    phoneRegister = data['candidatePhone'];
  }

  //Check For Auth Side
  //===================
  void checkAuthSide(bool value) {
    isRegistrationSide = value;
  }

  //Snackbar with Color , text, icon and error/successResult
  //========================================================
  static showSnack({
    Color color,
    String text,
    IconData iconData,
  }) {
    SnackBar(
      content: Row(children: [
        Icon(
          iconData,
          color: Colors.white,
        ),
        const SizedBox(width: 7),
        Text(text),
      ]),
      backgroundColor: color,
      duration: const Duration(milliseconds: 1500),
    );
  }

  //Method to Convert String data to Uint8List for Image Display
  //============================================================

  Uint8List convertStringToUint8List({String str}) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);
    binaryImageData = unit8List;
    return unit8List;
  }

  Uint8List get getData => binaryImageData;

}
