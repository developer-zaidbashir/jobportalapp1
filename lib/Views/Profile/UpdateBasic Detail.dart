


import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/BasicDetailsPost.dart';
import 'package:job_portal/Models/BasicInfoPopulate.dart';

import 'package:job_portal/Models/CurerntLocation.dart';
import 'package:job_portal/Models/GetTitle.dart';
import 'package:job_portal/Models/JobRole.dart';
import 'package:job_portal/Models/RegisterError.dart';

import 'package:job_portal/Models/custumradiomodel.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'Profile.dart';

class UpdateBasicDetails extends StatefulWidget {
  UpdateBasicDetails({
    Key key,
    this.fName,
    this.mName,
    this.lName,
    this.email,
    this.exp,
    this.jobrole,
    this.phone,
    this.gender,
  }) : super(key: key);
  String fName;
  String mName;
  String lName;
  String phone;
  String email;
  String gender;
  String exp;
  String jobrole;
  FToast fToast;
  // OnChangeCallback onChanged;

  @override
  _UpdateBasicDetailsState createState() => _UpdateBasicDetailsState();
}

// typedef OnChangeCallback =  Function(dynamic value);
class _UpdateBasicDetailsState extends State<UpdateBasicDetails> {
  //Get SharedPreference Bucket
  //===========================
  bool isVisible = false;
  SharedPreferences pref;

  //Shared Preference Variables
  //===========================

  String sharedPrefUuid = "";
  int sharedPrefCandidateId = 0;
  String sharedPrefCandidateName = "";
  String sharedPrefCandidateEmail = "";
  String sharedPrefCandidateMobile = "";

  //Shared Preference Keys
  //======================

  String keyUuid = "keyUuid";
  String keyCandiadateId = "keyCandiadateId";
  String keyCandidateName = "keyCandidateName";
  String keyCandidateEmail = "keyCandidateEmail";
  String keyCandiadteMobile = "keyCandiadteMobile";

  //GetTtile Instance
  //=================
  GetTitle selectedUser;
  List<String> jobroleList = [];

  //Global Form Key
  //===============
  var formKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  //Controllers for TextField
  //=========================
  TextEditingController fnameController = TextEditingController();
  TextEditingController mnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController jobCategorySearchCon = TextEditingController();
  TextEditingController number2Controller = TextEditingController();
  TextEditingController email2Controller = TextEditingController();

  //RadioButtons
  //============

  int groupValue2 = 0;



  final List<CustumRadioButtons> genderItems = [
    CustumRadioButtons(value: 1, text: "Male"),
    CustumRadioButtons(value: 2, text: "Female"),
    CustumRadioButtons(value: 3, text: "Others"),
  ];

  String genderRadioadioValue = "";

  final List<CustumRadioButtons> experienceItems = [
    CustumRadioButtons(value: 1, text: "Yes"),
    CustumRadioButtons(value: 2, text: "No"),
  ];
  int experienceRadioId = 0;
  String experienceRadioValue = "";

  //ID's for Fields
  //===============
  int groupValue = 0;

  String titleID = "";
  String genderID = "";
  String jobRoleID = "";
  String cityID = "";
  int totalExp = 0;
  Map<String, dynamic> response;

  //Normal Fiels Variables
  //======================
  String myjobrole = "";
  String query;
  String myLocation = "";
  bool _isLoading = false;
  int experienceGroupValue = 0;
  String dropdownValue;
  String mySelection;
  String mySelectionYear;
  String mySelectionMonth;
  bool isLoadingJobCategory = false;
  bool isLoadingCurrentLocation = false;
  bool isLoading = false;

  //Service Object
  //==============
  ApiServices apiServices = ApiServices();

  //ApiResponse Generic Objects
  //===========================

  RegisterError registerError = RegisterError(
      candidateEmail1: "Enter Email!",
      candidateLastName: "Enter Last Name!",
      candidateCurrentCityId: "Select Current Location!",
      candidateMobile1: "Enter Mobile!",
      candidatePreferredJobRoleList: "Select Preferred Job Roles!",
      candidateFirstName: "Enter First Name!",
      candidateGenderId: "Select Gender!");

  ApiResponse<List<GetTitle>> _apiResponse;
  ApiResponse<List<JobCategory>> _apiResponseJobCategory;
  ApiResponse<List<CurrentLocation>> _apiResponseCurrentLocation;
  ApiResponse<List<BasicDetialModel>> _apiResponseBasicDetail;

  @override
  void initState() {
    getBasics();

    super.initState();
    initSharedPreference();
    fetchTitles();
    fetchJobCategory(query: "");
    fetchCurrentLocation(query: "");
  }


  initSharedPreference() async {
    pref = await SharedPreferences.getInstance();
  }

  fetchTitles() async {
    setState(() {
      isLoading = true;
    });
    _apiResponse = await apiServices.getTitle();
    setState(() {
      isLoading = false;
    });
  }

  fetchJobCategory({String query}) async {
    setState(() {
      isLoadingJobCategory = true;
    });
    _apiResponseJobCategory = await apiServices.getJobCategory(query: query);
    setState(() {
      isLoadingJobCategory = false;
    });
  }

  fetchCurrentLocation({String query}) async {
    setState(() {
      isLoadingCurrentLocation = true;
    });
    _apiResponseCurrentLocation =
    await apiServices.getCurrentLocation(query: query);
    setState(() {
      isLoadingCurrentLocation = false;
    });
  }

  List<String> parseData() {
    List<JobCategory> category = _apiResponseJobCategory.data;
    List<String> dataItems = [];
    for (int i = 0; i < category.length; i++) {
      dataItems.add(category[i].jobroleName);
    }
    return dataItems;
  }

  List<String> parseLocation() {
    List<CurrentLocation> location = _apiResponseCurrentLocation.data;
    List<String> dataItems = [];
    for (int i = 0; i < location.length; i++) {
      dataItems.add(location[i].cityName);
    }
    return dataItems;
  }

  RichText getRequiredLabel({String fieldName}) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "ProximaNova"),
          text: fieldName,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
          ]),
    );
  }

  BasicInfoPopulate basicDetail;
  String errorMessage;
  getBasics() {

    setState(() {
      isLoading = true;
    });
    apiServices.PopulateBasicInfo().then((response) {
      setState(() {
        isLoading = false;
      });
      if (response.error) {
        errorMessage = response.errorMessage ?? "An Error Occurred";
      }
      basicDetail = response.data;
      fnameController.text = basicDetail.candidateFirstName;
      mnameController.text = basicDetail.candidateMiddleName;
      lnameController.text = basicDetail.candidateLastName;
      emailController.text = basicDetail.candidateEmail1;
      numberController.text = basicDetail.candidateMobile1;
     groupValue = basicDetail.candidateExperienceId;
     groupValue2 = int.parse(basicDetail.candidateGenderId);
    });


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
                  "Basic Information",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ProximaNova"),
                ),
                Text(
                  "Add basic details for the recruiter to know you.",
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
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 0, left: 13),
                            child: DropdownButtonFormField<GetTitle>(
                              hint: Text(
                                "Title:",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ProximaNova"),
                              ),
                              value: selectedUser,
                              onChanged: (GetTitle newValue) {
                                setState(() {
                                  selectedUser = newValue;
                                });
                              },
                              validator: (value) {
                                if(value == null){
                                  return "Enter Title";
                                }
                                else {
                                  return null;
                                }
                              },
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              items: _apiResponse.data.map((GetTitle user) {
                                return DropdownMenuItem<GetTitle>(
                                  value: user,
                                  child: Text(
                                    user.titleDesc,
                                    style: TextStyle(color: Colors.black),

                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp("[a-zA-Z]"))
                            ],
                            controller: fnameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8.0),
                              labelText: 'First Name:',
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "ProximaNova"),
                              floatingLabelStyle: TextStyle(
                                color: Color(0xff2972ff),
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
                            keyboardType: TextInputType.name,

                            validator: (value) {
                              if(value.length > 20){
                                return "Not more than 20 characters";
                              }
                              if (value.isEmpty) {
                                return registerError.candidateFirstName;
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            child: TextFormField(


                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]"))
                                ],
                                controller: mnameController,

                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  labelText: 'Middle Name:',
                                  labelStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ProximaNova"),
                                  floatingLabelStyle: TextStyle(
                                    color: Color(0xff2972ff),
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
                                keyboardType: TextInputType.name,
                                validator:(value) {
                                  if(value.length > 20){
                                    return "Not more than 20 characters";
                                  }
                                }


                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(


                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-zA-Z]"))
                              ],
                              controller: lnameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8.0),
                                labelText: 'Last Name:',
                                labelStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ProximaNova"),
                                floatingLabelStyle: TextStyle(
                                  color: Color(0xff2972ff),
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
                              keyboardType: TextInputType.name,

                              validator: (value) {
                                if(value.length > 20){
                                  return "Not more than 20 characters";
                                }
                                if (value.isEmpty) {
                                  return registerError.candidateLastName;
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: "Primary number can't be updated",
                        child: TextFormField(
                          enabled: false,
                          controller: numberController,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent)),
                            contentPadding: EdgeInsets.all(8.0),
                            labelText: 'Contact No:',
                            labelStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova"),
                            floatingLabelStyle: TextStyle(
                              color: Color(0xff2972ff),
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
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return " Enter Mobile";
                          //   }
                          //   if (!EmailValidator.validate(value)) {
                          //     return " enter Correct email";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Tooltip(
                        message: "Primary email can't be updated",
                        child: TextFormField(
                          enabled: false,
                          controller: emailController,
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.transparent)),
                            contentPadding: EdgeInsets.all(8.0),
                            labelText: 'E-mail:',
                            labelStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova"),
                            floatingLabelStyle: TextStyle(
                              color: Color(0xff2972ff),
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
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value.isEmpty) {
                              return " Enter Email";
                            }
                            if (!EmailValidator.validate(value)) {
                              return "Enter correct email";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("Additional",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff3e61ed),
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ProximaNova")),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xff3e61ed),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Visibility(
                        visible: isVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                              ),
                              child: Text("Number 2:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ProximaNova")),
                            ),
                            TextFormField(
                              controller: number2Controller,
                              decoration: InputDecoration(
                                hintText: "Enter Number",
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
                              child: Text("Email 2:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ProximaNova")),
                            ),
                            TextFormField(
                              controller: email2Controller,
                              decoration: InputDecoration(
                                hintText: "Enter Email",
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
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Gender:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ProximaNova"),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child:
                      Row(
                        children: [
                          GFRadio(
                            size: 20,
                            activeBorderColor: const Color(0xff3e61ed),
                            value: 1,
                            groupValue: groupValue2,
                            onChanged: (value) {
                              setState(() {
                                groupValue2 = value;
                              });
                            },
                            inactiveIcon: null,
                            radioColor: const Color(0xff3e61ed),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "Male",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GFRadio(
                            size: 20,
                            value: 2,
                            groupValue: groupValue2,
                            onChanged: (value) {
                              setState(() {
                                groupValue2 = value;
                              });
                            },
                            inactiveIcon: null,
                            activeBorderColor: const Color(0xff3e61ed),
                            radioColor: const Color(0xff3e61ed),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "Female",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GFRadio(
                            size: 20,
                            value: 3,
                            groupValue: groupValue2,
                            onChanged: (value) {
                              setState(() {
                                groupValue2 = value;
                              });
                            },
                            inactiveIcon: null,
                            activeBorderColor: const Color(0xff3e61ed),
                            radioColor: const Color(0xff3e61ed),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "Others",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Experience:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ProximaNova"),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child:
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
                            "Yes",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GFRadio(
                            size: 20,
                            value: 2,
                            groupValue: groupValue,
                            onChanged: (value) {
                              setState(() {
                                groupValue = value;
                              });
                            },
                            inactiveIcon: null,
                            activeBorderColor: const Color(0xff3e61ed),
                            radioColor: const Color(0xff3e61ed),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          const Text(
                            "No",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    groupValue == 1
                        ? const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Experience Tenure:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ProximaNova"),
                      ),
                    )
                        : Container(),
                    const SizedBox(
                      height: 3,
                    ),
                    groupValue == 1
                        ?
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: DropdownButtonFormField<String>(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                hint: Text("Years"),
                                value: mySelectionYear,
                                onChanged: (newValue) {
                                  setState(() {
                                    mySelectionYear = newValue;
                                  });
                                },
                                validator: (value) =>
                                value == null ? 'Select year' : null,
                                items: [
                                  "0",
                                  "1",
                                  "2",
                                  "3",
                                  "4",
                                  "5",
                                  "6",
                                  "7",
                                  "8",
                                  "9",
                                  "10",
                                  "11",
                                  "12"
                                ]
                                    .map(
                                      (value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            "ProximaNova"),
                                      )),
                                )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: DropdownButtonFormField<String>(
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                hint: Text("Months"),
                                value: mySelectionMonth,
                                onChanged: (newValue) {
                                  setState(() {
                                    mySelectionMonth = newValue;
                                  });
                                },
                                validator: (value) =>
                                value == null ? 'Select month' : null,
                                items: [
                                  "0",
                                  "1",
                                  "2",
                                  "3",
                                  "4",
                                  "5",
                                  "6",
                                  "7",
                                  "8",
                                  "9",
                                  "10",
                                  "11",
                                  "12"
                                ]
                                    .map(
                                      (value) => DropdownMenuItem(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight:
                                            FontWeight.bold,
                                            fontFamily:
                                            "ProximaNova"),
                                      )),
                                )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Preferred Job Role:",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ProximaNova"),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: JobRole(context),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                padding: const EdgeInsets.only(right: 20),
                child: GFButton(
                    text: "Save",
                    type: GFButtonType.solid,
                    blockButton: false,
                    onPressed: () async {
                      if (_fbKey.currentState.saveAndValidate()) {
                        final insert = BasicDetialModel(
                          candidateTitleId: selectedUser.titleId,
                          // candidateMobile1: widget.phone,
                          candidateFirstName: fnameController.text,
                          candidateMiddleName: mnameController.text,
                          candidateLastName: lnameController.text,
                          // candidateEmail1: emailController.text,
                          // candidateName: fnameController.text +
                          //     " " +
                          //     mnameController.text +
                          //     " " +
                          //     lnameController.text,
                          candidateExperienceId:groupValue,
                          candidateGenderId: groupValue2,
                          candidateTotalworkexp: experienceRadioId == 2
                              ? totalExp
                              : totalWorkExp(),
                          candidatePreferredJobRoleList: jobroleList,
                        );

                        final result =
                        await apiServices.basicinfoUpdate(insert);
                        print("#######################");
                        // response = result.data as Map<String, dynamic>;
                        // storeDataToSharedPref();
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
                                  builder: (context) => ProfilePage(
                                  ),
                                ),
                                    (route) => false);
                          });
                        }  else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(children: const [
                              Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                              SizedBox(width: 7),
                              Text(
                                  "An Error Occured..."),
                            ]),
                            backgroundColor: Colors.red,
                            duration: const Duration(milliseconds: 2500),
                          ));
                        }
                        Navigator.of(context).pop();
                      }
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

  int totalWorkExp() {
    totalExp = (int.parse(mySelectionYear) * 12) + int.parse(mySelectionMonth);
    return totalExp;
  }

  void storeDataToSharedPref() {
    pref.setString(keyUuid, response['axelaCandidateUuId']);
    pref.setInt(keyCandiadateId, response['axelaCandidateId']);
    pref.setString(keyCandidateName, response['axelaCandidateName']);
    pref.setString(keyCandidateEmail, response['axelaCandidateEmail1']);
    pref.setString(keyCandiadteMobile, response['axelaCandidateMobile']);
  }

  Widget JobRole(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownSearch<JobCategory>.multiSelection(
          // autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value.isEmpty) {
              return "Select Preferred Job Role:";
            }
            return null;
          },
          mode: Mode.DIALOG,
          items: isLoading ? [JobCategory()] : _apiResponseJobCategory.data,
          itemAsString: (JobCategory obj) {
            return obj.jobroleName;
          },
          onChanged: (val) {
            setState(() {
              jobroleList = val.map((e) {
                return e.jobroleId;
              }).toList();
              print(jobroleList);
            });
          },

          hint: "Select Preferred Job Role",
          showSearchBox: true,
          popupItemBuilder: (context, JobCategory item, bool isSelected) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(item.jobroleName),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
// FormBuilderRadioGroup<CustumRadioButtons>(
// autovalidateMode: AutovalidateMode.onUserInteraction,
// options: genderItems
//     .map((lang) => FormBuilderFieldOption(
// value: lang,
// child: Text(lang.text),
// ))
// .toList(growable: false),
// onChanged: (val) {
// setState(() {
// genderRadioId = val.value;
// genderRadioadioValue = val.text;
// });
// print(genderRadioId);
// print(genderRadioadioValue);
// },
// validator: (val) {
// if (val == null) {
// return registerError.candidateGenderId;
// } else {
// return null;
// }
// },
// initialValue: null,
// name: "Gender",
// ),