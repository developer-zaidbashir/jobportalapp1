import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getwidget/getwidget.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:job_portal/Models/Patent-Populate.dart';
import 'package:job_portal/Models/PatentAdd.dart';
import 'package:job_portal/Services/ApiServices.dart';

import 'Profile.dart';

class AddPatents extends StatefulWidget {
  AddPatents({Key key, this.uuid}) : super(key: key);
  String uuid;

  @override
  _AddPatentsState createState() => _AddPatentsState();
}

class _AddPatentsState extends State<AddPatents> {
  bool get isEditing => widget.uuid != null;

// Global formKey
  var formKey = GlobalKey<FormState>();
DateTime lastDate = DateTime.now();
  DateTime selectedDate;
  DateTime initialDate;
  int val = 0;
  bool isLoading = false;
  bool isLoadingPatents = false;

  TextEditingController title = TextEditingController();
  TextEditingController office = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController discription = TextEditingController();

  ApiServices apiServices = ApiServices();
  String errorMessage;
  PatentPopulate patentPopulate;

  @override
  void initState() {
    getPatent();
    super.initState();
  }

  getPatent() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      apiServices.populatePatentUpdate(widget.uuid).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "An Error Occurred";
        }
        patentPopulate = response.data;
        title.text = patentPopulate.candidatepatentTitle;
        office.text = patentPopulate.candidatepatentOffice;
        url.text = patentPopulate.candidatepatentWeblink;
        val = int.parse(patentPopulate.candidatepatentStatus);
        number.text = patentPopulate.candidatepatentApplicationnumber;
        discription.text = patentPopulate.candidatepatentDesc;
        initialDate = DateTime.parse(patentPopulate.candidatepatentIssuedate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key:formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Patent",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ProximaNova"),
                ),
                Text(
                  "Add details and links of patents filled by you."
                  ,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "ProximaNova",
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 15,
                      right: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patent Title',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        TextFormField(
                          maxLength: 100,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z- ]"))
                          ],
                          controller: title,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Patent Title";
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Patent Title",
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
                          height: 10,
                        ),
                        Text(
                          'Patent Office',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        TextFormField(
                          maxLength: 30,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z- ]"))
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Patent Office";
                            } else {
                              return null;
                            }
                          },
                          controller: office,
                          decoration: InputDecoration(
                            hintText: "Enter Patent Office",
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
                          height: 10,
                        ),
                        Text(
                          'Patent WebLink',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        TextFormField(
                          validator: (value) {
                            if(value.length > 300){
                              return "Not more than 300 characters";
                            }
                          else {
                              return null;
                            }
                          },
                          controller: url,
                          decoration: InputDecoration(
                            hintText: " Enter Patent Weblink",
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
                          height: 10,
                        ),
                        Text(
                          'Patent Status',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        ListTile(
                          title: Text(
                            "Pending",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova"),
                          ),
                          leading: Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Issued",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova"),
                          ),
                          leading: Radio(
                            value: 2,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                        Text(
                          'Application Number',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        TextFormField(
                          maxLength: 30,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Application Number";
                            } else {
                              return null;
                            }
                          },
                          controller: number,
                          decoration: InputDecoration(
                            hintText: "Enter Application Number",
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Issue Date',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        DateTimeFormField(
                          decoration: const InputDecoration(
                            border: const UnderlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: 'Select Issue Date',
                            // hintStyle: heading6.copyWith(color: textGrey),
                            // errorStyle: TextStyle(color: Colors.redAccent),
                            suffixIcon: Icon(Icons.event_note),
                          ),
                          lastDate:lastDate,
                          initialValue: initialDate,
                          mode: DateTimeFieldPickerMode.date,

                          validator: (e) {
                            if (e == null) {
                              return "Select Issue Date";
                            } else {
                              return null;
                            }
                          },

                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        TextFormField(
                          maxLength: 1000,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter Description";
                            } else {
                              return null;
                              return null;
                            }
                          },
                          controller: discription,
                          decoration: InputDecoration(
                            hintText: "Enter Description",
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isEditing ?
                      GFButton(
                        onPressed: () async{
                          setState(() {
                            isLoadingPatents = true;
                          });
                          final insert = AddPatent(
                            requestType: "delete",
                            candidatepatentUuid:widget.uuid,
                          );

                          final result =
                              await apiServices.patentsDelete(insert);
                          setState(() {
                            isLoadingPatents = false;
                          });
                          if (result.data) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(children: const [
                                Icon(
                                  Icons.done_outlined,
                                ),
                                SizedBox(width: 7),
                                Text("Successfully Deleted"),
                              ]),
                              backgroundColor: Colors.green,
                              duration: const Duration(milliseconds: 2500),
                            ));
                            setState(() {
                              getPatent();
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






                          Navigator.of(context).pop();
                        },
                        text: "Delete",
                        type: GFButtonType.solid,
                      ):GFButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: "Cancel",
                        type: GFButtonType.solid,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GFButton(
                        onPressed: () async {
                          if(formKey.currentState.validate()){
                       if(isEditing) {
                         setState(() {
                           isLoading = true;
                         });
                         final insert = AddPatent(
                           requestType: "update",
                           candidatepatentUuid: widget.uuid,
                           candidatepatentTitle: title.text,
                           candidatepatentOffice: office.text,
                           candidatepatentWeblink: url.text,
                           candidatepatentStatus: val.toString(),
                           candidatepatentApplicationnumber: number.text,
                           candidatepatentIssuedate: selectedDate,
                           candidatepatentDesc: discription.text,
                         );

                         final result = await apiServices.patentsAdd(insert);
                         setState(() {
                           isLoading = false;
                         });
                         if (result.data) {
                           ScaffoldMessenger
                               .of(context)
                               .showSnackBar(
                             SnackBar(
                               content: Row(children: const [
                                 Icon(
                                   Icons.update,
                                   color: Colors.white,
                                 ),
                                 SizedBox(width: 7),
                                 Text("Successfully Updated..."),
                               ]),
                               backgroundColor: Colors.green,
                               duration:
                               const Duration(milliseconds: 1500),
                             ),
                           )
                               .closed
                               .then((reason) {
                             Navigator.pushAndRemoveUntil(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => ProfilePage(),
                                 ),
                                     (route) => false);
                           });
                         } else {
                           ScaffoldMessenger.of(context)
                               .showSnackBar(SnackBar(
                             content: Row(children: const [
                               Icon(
                                 Icons.error_outline,
                                 color: Colors.white,
                               ),
                               SizedBox(width: 7),
                               Text("An Error Occured..."),
                             ]),
                             backgroundColor: Colors.red,
                             duration: const Duration(milliseconds: 2500),
                           ));
                         }
                         Navigator.pop(context);
                       }
                       else{

                         setState(() {
                           isLoading = true;
                         });
                         final insert = AddPatent(
                           requestType: "add",
                           candidatepatentTitle: title.text,
                           candidatepatentOffice: office.text,
                           candidatepatentWeblink: url.text,
                           candidatepatentStatus: val.toString(),
                           candidatepatentApplicationnumber: number.text,
                           candidatepatentIssuedate: selectedDate,
                           candidatepatentDesc: discription.text,
                         );

                         final result = await apiServices.patentsAdd(insert);
                         setState(() {
                           isLoading = false;
                         });
                         if (result.data) {
                           ScaffoldMessenger
                               .of(context)
                               .showSnackBar(
                             SnackBar(
                               content: Row(children: const [
                                 Icon(
                                   Icons.add,
                                   color: Colors.white,
                                 ),
                                 SizedBox(width: 7),
                                 Text("Successfully Added..."),
                               ]),
                               backgroundColor: Colors.green,
                               duration:
                               const Duration(milliseconds: 1500),
                             ),
                           )
                               .closed
                               .then((reason) {
                             Navigator.pushAndRemoveUntil(
                                 context,
                                 MaterialPageRoute(
                                   builder: (context) => ProfilePage(),
                                 ),
                                     (route) => false);
                           });
                         } else {
                           ScaffoldMessenger.of(context)
                               .showSnackBar(SnackBar(
                             content: Row(children: const [
                               Icon(
                                 Icons.error_outline,
                                 color: Colors.white,
                               ),
                               SizedBox(width: 7),
                               Text("An Error Occurred.."),
                             ]),
                             backgroundColor: Colors.red,
                             duration: const Duration(milliseconds: 2500),
                           ));
                         }
                         Navigator.pop(context);
                       }
                       }
                       else{}

                        },
                        text: isEditing?"Update":"Add",
                        type: GFButtonType.solid,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
