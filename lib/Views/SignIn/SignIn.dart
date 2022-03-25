// ignore_for_file: avoid_print, prefer_const_constructors, duplicate_ignore

import 'dart:async';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/Login.dart';
import 'package:job_portal/Models/ShowDataLogin.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Utility/apiurls.dart';
import 'package:job_portal/Views/Candidate/BottomNavbar.dart';
import 'package:job_portal/Views/SignIn/Step1-Otp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  ApiServices apiServices = ApiServices();
  ApiResponse<ShowDataLogin> apiResponse;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Get SharedPreference Bucket
  //===========================

  SharedPreferences prefLogin;

  //Shared Preference Variables
  //===========================

  String sharedPrefJwt = "";


  bool check = false;
  //Shared Preference Keys
  //======================

  String keyJwt = "keyJwt";
  String keyEmail = "keyEmail";
  String keyUsername = "keyUsername";

  var obscureText = false;
  bool ignore = false;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getResponseFromServer(url: ApiUrls.kresponseFromServer, context: context);
    // Connect.checkInternetStatus();
    initSharedPreference();
  }

  //Toggle Functionality
  //====================
  void _toggle(){
    setState(() {
      obscureText = !obscureText;
    });
  }

  initSharedPreference() async {
    prefLogin = await SharedPreferences.getInstance();
  }

  fetchAuth({String username, String password}) async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await apiServices.login(
        obj: Login(candidateEmail1: username, candidatePassword: password));
    setState(() {
      isLoading = false;
    });
  }

  TextEditingController usernameCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Login to your\naccount ",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 20.5,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      // onChanged: (dynamic value){
                                      //   if(value.isNumeric){
                                      //    check = true;
                                      //    print(check);
                                      //   }else{
                                      //     check = false;
                                      //     print(check);
                                      //   }
                                      // },
                                      controller: usernameCont,
                                      // validator: (value) {
                                      //   if (EmailValidator.validate(value)) {
                                      //     return null;
                                      //   } else {
                                      //     return "Enter Email";
                                      //   }
                                      // },
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(0.0),
                                        labelText: 'Email or Phone',
                                        labelStyle: TextStyle(
                                          color: Colors.blueGrey,
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5,
                                          fontSize: 15.5,
                                        ),
                                        floatingLabelStyle: TextStyle(
                                          color: Color(0xff3e61ed),
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.bold,
                                          // letterSpacing: 1.5,
                                          fontSize: 17.5,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff3e61ed),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: passwordCont,
                                      obscureText: obscureText,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Enter Password";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration:  InputDecoration(
                                        suffixIcon: IconButton(onPressed: (){
                                          _toggle();
                                        }, icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),),
                                        contentPadding: EdgeInsets.all(0.0),
                                        labelText: 'Password',
                                        labelStyle: TextStyle(
                                          color: Colors.blueGrey,
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5,
                                          fontSize: 15.5,
                                        ),
                                        floatingLabelStyle: TextStyle(
                                          color: Color(0xff3e61ed),
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.bold,
                                          // letterSpacing: 1.5,
                                          fontSize: 17.5,
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xff2972ff),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: IgnorePointer(
                      ignoring: ignore,
                      child: GFButton(
                        color: ignore?Colors.grey: Color(0xff3e61ed),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            setState(() {
                              ignore= true;
                            });
                            // await fetchAuth(
                            //     username: usernameCont.text,
                            //     password: passwordCont.text);
                            final insert = Login(
                              candidateEmail1: usernameCont.text,
                              candidateMobile1: usernameCont.text ,
                              candidatePassword:passwordCont.text ,

                            );
                          apiResponse = await apiServices.login(obj: insert);
                            setState(() {
                              ignore= false;
                            });
                            print("Response Data : ${apiResponse.data.toString()}");
                            if (apiResponse.responseCode == 200) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Navbar(),
                                  ),
                                  (route) => false);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Row(children: const [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 7),
                                  Expanded(
                                    child: Text(
                                        "Invalid User, Enter Your Correct Credentials..."),
                                  ),
                                ]),
                                backgroundColor: Colors.red,
                                duration: const Duration(milliseconds: 2500),
                              ));
                            }
                          }
                        },
                        text:ignore ? "Logging In":"Login",
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1.5,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const OTP()));
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Color(0xff2972ff),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<dynamic> getResponseFromServer(
      {String url, BuildContext context}) async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 4), onTimeout: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // ignore: prefer_const_literals_to_create_immutables
          content: Row(children: const [
             Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
             SizedBox(width: 7),
            Expanded(
              child: Text("Server Session Timeout..."),
            ),
          ]),
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 2500),
        ));
        // Connect.showSnack(color: Colors.red,iconData: Icons.error_outline,text: "Server Session Timeout...");
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        // ignore: prefer_const_literals_to_create_immutables
        content: Row(children: [
          const Icon(
            Icons.done,
            color: Colors.white,
          ),
          const SizedBox(width: 7),
          // ignore: prefer_const_constructors
          Expanded(
            child: Text("Connected With Server..."),
          ),
        ]),
        backgroundColor: Colors.green,
        duration: const Duration(milliseconds: 2500),
      ));
      return response;
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        // ignore: prefer_const_literals_to_create_immutables
        content: Row(children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 7),
          // ignore: prefer_const_constructors
          Expanded(
            child: Text("Connection with Server Failed..."),
          ),
        ]),
        backgroundColor: Colors.red,
        duration: const Duration(milliseconds: 2500),
      ));
    }
  }

  void storeLoginDataToSharedPref() async {
    await prefLogin.setString(keyJwt, apiResponse.data.token);
    await prefLogin.setString(keyEmail, apiResponse.data.candidateEmail);
    await prefLogin.setString(keyUsername, apiResponse.data.candidateName);
  }
}
