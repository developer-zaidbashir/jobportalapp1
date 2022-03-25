import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:job_portal/Models/Presentation-Populate.dart';
import 'package:job_portal/Models/Researchpaper.dart';
import 'package:job_portal/Services/ApiServices.dart';

import 'Profile.dart';

class Research extends StatefulWidget {
  Research({Key key, this.uuid}) : super(key: key);
  String uuid;

  @override
  _ResearchState createState() => _ResearchState();
}

class _ResearchState extends State<Research> {
  bool get isEditing => widget.uuid != null;
  bool isLoading = false;
  bool isLoadingResearch = false;
  var formKey = GlobalKey<FormState>();

  ApiServices apiServices = ApiServices();
  TextEditingController titleresearch = TextEditingController();
  TextEditingController weburl = TextEditingController();

  TextEditingController description = TextEditingController();
  DateTime selectedDate;
  DateTime lastDate = DateTime.now();
  ResearchpaperAdd researchpaper;
  String errorMessage;

  @override
  void initState() {
    getResearchpaper();
    // getPresentation();
    super.initState();
  }

  getResearchpaper() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      apiServices.populateResearchpaperUpdate(widget.uuid).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "An Error Occurred";
        }


        researchpaper = response.data;
        titleresearch .text = researchpaper.candidatepaperTitle;
        weburl.text = researchpaper.candidatepaperWeblink;

        description.text = researchpaper.candidatepaperDesc;

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Research Publication",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "ProximaNova"),
            ),
            Text(
              "Add details and links for your publications."
              ,
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
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text("Title:",
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
                    controller: titleresearch,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Title";
                      } else {
                        return null;
                      }
                    },
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: "Add Title",
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
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text("Web URL:",
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
                      if (value.isEmpty) {
                        return "Enter Web URL";
                      } else {
                        return null;
                      }
                    },
                    controller: weburl,

                    decoration: InputDecoration(
                      hintText: "Enter Web URL",
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
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text("Published On:",
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
                      hintText: 'Select Published Date',
                      // hintStyle: heading6.copyWith(color: textGrey),
                      // errorStyle: TextStyle(color: Colors.redAccent),
                      suffixIcon: Icon(Icons.event_note),
                    ),
                    // initialValue: date,
                    lastDate:lastDate,
                    mode: DateTimeFieldPickerMode.date,
                    validator: (e) {
                      if (e == null) {
                        return "Select Published Date";
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text("Description:",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ProximaNova")),
                  ),
                  TextFormField(
                    maxLength: 1000,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter Description";
                      } else {
                        return null;
                      }
                    },
                    controller: description,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.characters,
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
        ),
      ),
      SizedBox(height: 20),

      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isEditing ?
            GFButton(
              onPressed: () async{
                setState(() {
                  isLoadingResearch = true;
                });
                final insert = ResearchpaperAdd(
                  requestType: "delete",
                  candidatepaperUuid: widget.uuid,
                );

                final result =
                await apiServices.researchpaperAdd(insert);
                setState(() {
                  isLoadingResearch = false;
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
              text: "Delete",
              type: GFButtonType.solid,
            ): GFButton(
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
                if(formKey.currentState.validate()) {
                  if (isEditing) {
                    setState(() {
                      isLoading = true;
                    });
                    final insert = ResearchpaperAdd(
                      requestType: "update",
                      candidatepaperUuid: widget.uuid,
                      candidatepaperTitle: titleresearch.text,
                      candidatepaperWeblink: weburl.text,
                      candidatepaperDesc: description.text,
                      candidatepaperPublisheddate: selectedDate.toString()
                          .split(" ")[0],
                    );
                    final result = await apiServices.researchpaperAdd(insert);
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
                  else
                  {

                    final insert = ResearchpaperAdd(
                      requestType: "add",
                      candidatepaperTitle: titleresearch.text,
                      candidatepaperWeblink: weburl.text,
                      candidatepaperDesc: description.text,
                      candidatepaperPublisheddate: selectedDate.toString()
                          .split(" ")[0],
                    );

                    final result = await apiServices.researchpaperAdd(insert);
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
              text:  isEditing ? "Update" :  "Add",
              type: GFButtonType.solid,
            ),
          ],
        ),
      ),

    ]));
  }
}
