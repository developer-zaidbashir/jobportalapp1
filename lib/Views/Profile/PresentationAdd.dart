import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:job_portal/Models/PresentaionAdd.dart';
import 'package:job_portal/Models/Presentation-Populate.dart';
import 'package:job_portal/Services/ApiServices.dart';

import 'Profile.dart';

class Presentation extends StatefulWidget {
  Presentation({Key key, this.uuid}) : super(key: key);
  String uuid;

  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Presentation> {
  bool get isEditing => widget.uuid != null;
  bool isLoading = false;
  bool isLoadingPresentation = false;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  ApiServices apiServices = ApiServices();
  TextEditingController title = TextEditingController();
  TextEditingController weblink = TextEditingController();
  TextEditingController desclink = TextEditingController();

  PresentationPopulate presentationPopulate;
  String errorMessage;

  @override
  void initState() {
    getPresentation();
    super.initState();
  }

  getPresentation() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      apiServices
          .populatePresentationParticularUpdate(widget.uuid)
          .then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "An Error Occurred";
        }
        presentationPopulate = response.data;
        title.text = presentationPopulate.candidatepresentationTitle;
        weblink.text = presentationPopulate.candidatepresentationWeblink;
        desclink.text = presentationPopulate.candidatepresentationDesc;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key:formKey,
          child: ListView(children: [
      Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Add Presentation",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "ProximaNova"),
              ),
              Text(
                "Add web-links for online presentation."
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
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text("Presentation Title:",
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

                      controller: title,

                      decoration: InputDecoration(
                        hintText: "Enter Presenntation Title",
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
                      child: Text("Presentation WebLink:",
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
                      controller: weblink,

                      decoration: InputDecoration(
                        hintText: "Enter Presentation WebLink",
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
                      child: Text("Description:",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProximaNova")),
                    ),
                    TextFormField(
                      maxLength: 1000,

                      controller: desclink,
                      maxLines: 4,

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
                    isLoadingPresentation = true;
                  });
                  final insert = PresentationAddModel(
                    requestType: "delete",
                    candidatepresentationUuid:
                   widget.uuid,
                  );

                  final result = await apiServices
                      .presentationAddService(insert);
                  setState(() {
                    getPresentation();
                    isLoadingPresentation = false;
                  });
                  if (result.data) {
                    print("-----------SUCCESS------------");
                  } else {
                    print("-----------ERROR------------");
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
                  if (isEditing) {
                    setState(() {
                      isLoading = true;
                    });
                    final insert = PresentationAddModel(
                        requestType: "update",
                        candidatepresentationUuid: widget.uuid,
                        candidatepresentationTitle: title.text,
                        candidatepresentationWeblink: weblink.text,
                        candidatepresentationDesc: desclink.text);
                    final result = await apiServices.presentationAddService(
                        insert);
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
                  }
                  else {

                    setState(() {
                      isLoading = true;
                    });

                    final insert = PresentationAddModel(
                        requestType: "add",
                        candidatepresentationTitle: title.text,
                        candidatepresentationWeblink: weblink.text,
                        candidatepresentationDesc: desclink.text);

                    final result = await apiServices.presentationAddService(
                        insert);
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
                text: isEditing ? "Update" : "Add",
                type: GFButtonType.solid,
              ),
            ],
          ),
      ),
      // SizedBox(
      //   width: 10,
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(right: 22),
      // child: GFButton(
      //     text: "Save",
      //     type: GFButtonType.solid,
      //     blockButton: false,
      //     onPressed: () async {
      //       Navigator.of(context).pop();
      //     }),
      // ),

      // const SizedBox(
      //   height: 40,
      // ),
    ]),
        ));
  }
}
