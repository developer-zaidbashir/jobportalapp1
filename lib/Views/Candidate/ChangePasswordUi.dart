import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:job_portal/Models/ChangePassword.dart';
import 'package:job_portal/Services/ApiServices.dart';

class ChangePasswordUi extends StatefulWidget {
  const ChangePasswordUi({Key key}) : super(key: key);

  @override
  _ChangePasswordUiState createState() => _ChangePasswordUiState();
}

class _ChangePasswordUiState extends State<ChangePasswordUi> {


  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return  isLoading ? Center(child: CircularProgressIndicator()):SafeArea(
      child:Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 10,right:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                     SizedBox(
                       width: 20,
                     ),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                    ),
                         Text(
                           "Add web-links for online presentation.",
                           style: TextStyle(
                             fontSize: 12,
                             fontFamily: "ProximaNova",
                             color: Colors.grey,
                           ),
                         ),
                       ],
                     ),
                  ],
                ),

                SizedBox(
                  height:20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text('Old Password',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                        TextFormField(
                          // maxLength: 8,
                          // inputFormatters: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.allow(RegExp("[0-9+.]"))
                          // ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return " Enter Old Password";
                            } else {
                              return null;
                            }
                          },
                          controller: oldPassword,
                          decoration: InputDecoration(
                            hintText: "Enter Old Password",
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Text('New Password',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                        TextFormField(
                          // maxLength: 8,
                          // inputFormatters: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.allow(RegExp("[0-9+.]"))
                          // ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return " Enter New Password";
                            } else {
                              return null;
                            }
                          },
                          controller: newPassword,
                          decoration: InputDecoration(
                            hintText: "Enter New Password",
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 14.5,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        const Text('Confirm Password',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                        TextFormField(
                          // maxLength: 8,
                          // inputFormatters: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.allow(RegExp("[0-9+.]"))
                          // ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return " Enter Confirm Password";
                            } else {
                              return null;
                            }
                          },
                          controller: confirmPassword,
                          decoration: InputDecoration(
                            hintText: "Enter Confirm Password",
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GFButton(
                      onPressed: () async {
                        if (formKey.currentState.validate()) {

                          setState(() {
                            isLoading = true;
                          });
                          final insert = ChangePassword(
                            requestType: "update",
                            oldPass: oldPassword.text,
                            newPass: newPassword.text,
                            confirmNewPass: confirmPassword.text,
                          );
                          final result = await apiServices.changePassword(insert);
                          final   message = await secureStorage.read(key: "msg");
                          setState(() {
                            isLoading = false;
                          });

                          if (result.data) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Row(children:  [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 7),
                                  Text(message),
                                ]),
                                backgroundColor: Colors.green,
                                duration: const Duration(milliseconds: 1500),
                              ),
                            ).closed.then((reason) async{
                              await secureStorage.delete(key: "msg");
                            Navigator.pop(context);
                            });

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: const [
                                  Icon(Icons.error),
                                  SizedBox(width: 7),
                                  Text("An Error Occured"),
                                ],
                              ),
                              backgroundColor: Colors.red,
                              duration: const Duration(milliseconds: 2500),
                            ));
                          }
                        }
                      },
                      text: "Change Password",
                      type: GFButtonType.solid,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
