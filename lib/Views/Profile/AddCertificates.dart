import 'package:date_field/date_field.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/Certification-Add.dart';
import 'package:job_portal/Models/CertificationPopulate.dart';

import 'package:job_portal/Services/ApiServices.dart';

import 'Profile.dart';

class Certification extends StatefulWidget {
  String uuid;

  Certification({Key key, this.uuid}) : super(key: key);

  @override
  _CertificationState createState() => _CertificationState();
}

class _CertificationState extends State<Certification> {
  bool get isEditing => widget.uuid != null;
  var formKey = GlobalKey<FormState>();


  int groupValue = 0;
  DateTime lastDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2;

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController issueByController = TextEditingController();

  bool isLoading = false;
  bool isLoadingCertification = false;

  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    GetCertification();
    print(widget.uuid);
    super.initState();
  }

  String errorMessage;

  CertificationAdd populate;

  GetCertification() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      apiServices.populateCertificationUp(widget.uuid).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "An Error Occurred";
        }
        populate = response.data;
        nameController.text = populate.candidatecertificationName;
        idController.text = populate.candidatecertificationCertificationid;
        urlController.text = populate.candidatecertificationWeblink;
        issueByController.text = populate.candidatecertificationIssuedby;
        // selectedDate = populate.candidatecertificationIssuedate;
        groupValue = int.parse(populate.candidatecertificationExpiry);
        // selectedDate2 = populate.candidatecertificationExpirydate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Certification",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ProximaNova"),
                ),
                Text(
                  "Add details and links of your certifications.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "ProximaNova",
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Certification Name:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      TextFormField(
                        maxLength: 100,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                        ],
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter Certification Name";
                          } else {
                            return null;
                          }
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: "Enter Certification Name",
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Certification Id:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                        ],
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter Certification Id";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 30,
                        keyboardType: TextInputType.number,
                        controller: idController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          hintText: "Enter Certification ID",
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Certification URL:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
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
                        controller: urlController,

                        decoration: InputDecoration(
                          hintText: "Enter Certification URl",
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Issued By:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                        ],
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter Issued By";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 30,
                        controller: issueByController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          hintText: "Enter Issued By",
                          hintStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, right: 25),
                        child: Text("Issued Date",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DateTimeFormField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          hintText: ' Select Issued Date',
                          // hintStyle: heading6.copyWith(color: textGrey),
                          // errorStyle: TextStyle(color: Colors.redAccent),
                          suffixIcon: Icon(Icons.event_note),
                        ),
                        // initialValue: date,
                        mode: DateTimeFieldPickerMode.date,

                        lastDate: lastDate,
                        validator: (e) {
                          if (e == null) {
                            return "Select Issued Date";
                          } else {
                            return null;
                          }
                        },
                        // initialDate: date  ,
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Validity:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GFRadio(
                                  size: 20,
                                  activeBorderColor: const Color(0xff3e61ed),
                                  value: 1,
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value;
                                    });
                                  },
                                  inactiveIcon: null,
                                  radioColor: const Color(0xff3e61ed),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                const Text(
                                  "This Certification does not expire",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DateTimeFormField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: ' Select Expiry Date',
                                // hintStyle: heading6.copyWith(color: textGrey),
                                // errorStyle: TextStyle(color: Colors.redAccent),
                                suffixIcon: Icon(Icons.event_note),
                              ),
                              // initialValue: date,
                              lastDate: lastDate,
                              mode: DateTimeFieldPickerMode.date,



                              onDateSelected: (date) {
                                setState(() {
                                  selectedDate2 = date;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isEditing ?   GFButton(
                onPressed: () async {
                  setState(() {
                    isLoadingCertification = true;
                  });
                  final insert = CertificationPopulate(
                    requestType: "delete",
                    candidatecertificationUuid: widget.uuid,
                  );

                  final result = await apiServices.certificationAdd(insert);
                  setState(() {
                    isLoadingCertification = false;
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
                text: "Delete" ,
                type: GFButtonType.solid,
              ):
              GFButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    text: "Cancel",
    type: GFButtonType.solid,
    ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 22),
                child: GFButton(
                    text: isEditing ? "Update" : "Save",
                    type: GFButtonType.solid,
                    // blockButton: false,
                    onPressed: () async {
                      if(formKey.currentState.validate()){
                      if (isEditing) {
                        setState(() {
                          isLoading = true;
                        });
                        final insert = CertificationPopulate(
                          requestType: "update",
                          candidatecertificationUuid: widget.uuid,
                          candidatecertificationName: nameController.text,
                          candidatecertificationCertificationid:
                          idController.text,
                          candidatecertificationWeblink: urlController.text,
                          candidatecertificationIssuedby:
                          issueByController.text,
                          candidatecertificationIssuedate:
                          selectedDate.toString().split(" ")[0],
                          candidatecertificationExpiry: groupValue.toString(),
                          candidatecertificationExpirydate:
                          selectedDate2.toString().split(" ")[0],
                        );
                        final result =
                        await apiServices.certificationAdd(insert);

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
                              duration: const Duration(milliseconds: 1500),
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                      else {

                        setState(() {
                          isLoading = true;
                        });
                        final insert = CertificationPopulate(
                          requestType: "add",
                          candidatecertificationName: nameController.text,
                          candidatecertificationCertificationid:
                          idController.text,
                          candidatecertificationWeblink: urlController.text,
                          candidatecertificationIssuedby:
                          issueByController.text,
                          candidatecertificationIssuedate:
                          selectedDate.toString().split(" ")[0],
                          candidatecertificationExpiry: groupValue
                              .toString(),
                          candidatecertificationExpirydate:
                          selectedDate2.toString().split(" ")[0],
                        );
                        final result =
                        await apiServices.certificationAdd(insert);

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
                                Text("Successfully Added..."),
                              ]),
                              backgroundColor: Colors.green,
                              duration: const Duration(milliseconds: 1500),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(children: const [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 7),
                                  Text("An Error Occurred.."),
                                ]),
                                backgroundColor: Colors.red,
                                duration: const Duration(
                                    milliseconds: 2500),
                              ));
                        }

                        Navigator.pop(context);
                      }
                      }
                      else{}


                    }),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
