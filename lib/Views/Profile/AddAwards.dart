import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getwidget/getwidget.dart';
import 'package:job_portal/Models/Awards.dart';

import 'package:job_portal/Services/ApiServices.dart';

import 'Profile.dart';

class AddAwards extends StatefulWidget {
  AddAwards({Key key, this.uuid}) : super(key: key);
  String uuid;

  @override
  _AddAwardsState createState() => _AddAwardsState();
}

class _AddAwardsState extends State<AddAwards> {
  bool get isEditing => widget.uuid != null;

// Global formKey
  var formKey = GlobalKey<FormState>();

  DateTime selectedDate;
  DateTime lastDate = DateTime.now();
  DateTime initialDate;
  bool isLoading = false;
  bool isLoadingAwards = false;

  TextEditingController title = TextEditingController();
  TextEditingController url = TextEditingController();
  TextEditingController discription = TextEditingController();

  ApiServices apiServices = ApiServices();
  String errorMessage;
  Awards awards;

  @override
  void initState() {
    getAwards();
    super.initState();
  }

  getAwards() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      apiServices.populateAwardsUpdate(widget.uuid).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "An Error Occurred";
        }
        awards = response.data;
        title.text = awards.candidateawardTitle;
        url.text = awards.candidateawardWeblink;
        discription.text = awards.candidateawardDesc;
        // initialDate = awards.candidateawardDate as DateTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Awards",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ProximaNova"),
                ),
                const Text(
                  "Showcase the awards earned by you.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "ProximaNova",
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
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
                        const Text(
                          'Awards Title',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        TextFormField(
                          maxLength: 100,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z- ]"))
                          ],
                          controller: title,

                          decoration: const InputDecoration(
                            hintText: "Enter Awards Title",
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Award WebLink',
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
                          decoration: const InputDecoration(
                            hintText: "Award WebLink",
                            hintStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 14.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Award Date',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        DateTimeFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            hintText: 'Award Date',
                            // hintStyle: heading6.copyWith(color: textGrey),
                            // errorStyle: TextStyle(color: Colors.redAccent),
                            suffixIcon: Icon(Icons.event_note),
                          ),
                          initialValue: initialDate,
                          lastDate: lastDate,
                          mode: DateTimeFieldPickerMode.date,


                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova"),
                        ),
                        TextFormField(
                            maxLength: 1000,

                          controller: discription,
                          decoration: const InputDecoration(
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
                        onPressed: () async {
                          setState(() {
                            isLoadingAwards = true;
                          });
                          final insert = Awards(
                            requestType: "delete",
                            candidateawardUuid: widget.uuid,
                          );

                          final result = await apiServices.awardsAdd(insert);
                          setState(() {
                            isLoadingAwards = false;
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
                              getAwards();
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
                      const SizedBox(
                        width: 10,
                      ),
                      GFButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            if (isEditing) {
                              setState(() {
                                isLoading = true;
                              });
                              final insert = Awards(
                                requestType: "update",
                                candidateawardUuid: widget.uuid,
                                candidateawardTitle: title.text,
                                candidateawardDate:
                                    selectedDate.toString(),
                                candidateawardDesc: discription.text,
                                candidateawardWeblink: url.text,
                              );

                              final result =
                                  await apiServices.awardsAdd(insert);
                              setState(() {
                                isLoading = false;
                              });
                              if (result.data) {
                                ScaffoldMessenger.of(context)
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
                              }
                              else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
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
                                  duration: const Duration(milliseconds: 2500),
                                ));
                              }

                              Navigator.pop(context);
                            }

                            else {
                              setState(() {
                                isLoading = true;
                              });
                              final insert = Awards(
                                requestType: "add",
                                candidateawardTitle: title.text,
                                candidateawardDate:
                                selectedDate.toString().split(" ")[1],
                                candidateawardDesc: discription.text,
                                candidateawardWeblink: url.text,
                              );

                              final result =
                              await apiServices.awardsAdd(insert);
                              setState(() {
                                isLoading = false;
                              });
                              if (result.data) {
                                ScaffoldMessenger.of(context)
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
                          } else{}



                        },
                        text: isEditing ? "Update" : "Add",
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
