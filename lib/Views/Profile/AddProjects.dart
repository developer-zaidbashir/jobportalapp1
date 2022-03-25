import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/CurerntLocation.dart';
import 'package:job_portal/Models/GetCompany.dart';
import 'package:job_portal/Models/ProjectPopulate.dart';
import 'package:job_portal/Services/ApiServices.dart';

import 'Profile.dart';

class Projects extends StatefulWidget {
  String uuid;

  Projects({Key key, this.uuid}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  bool get isEditing => widget.uuid != null;
  var formKey = GlobalKey<FormState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool isVisible = false;
  int groupValue = 0;
  int groupValue1 = 0;
  int groupValue2 = 0;
  int groupValue3 = 0;
  DateTime lastDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2;
  DateTime selectedDate3;
  String mySelectionYear;

  String query;
  String mycompany = "";
  String cityID = "";

  String currentCompanyID = "";

  TextEditingController currentCompanySearchCo = TextEditingController();
  TextEditingController jobCategorySearchCon = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController roledescController = TextEditingController();
  TextEditingController teamController = TextEditingController();

  bool isLoadingCompany = false;
  bool isLoadingCurrentCopmpany = false;
  bool isLoadingCurrentLocation = false;
  bool isLoadingProjects = false;

  bool isLoading = false;
  ApiServices apiServices = ApiServices();

  ApiResponse<List<Company>> apiResponseCurrentCompany;
  ApiResponse<List<CurrentLocation>> _apiResponseCurrentLocation;

  List<String> parseData() {
    List<Company> category = apiResponseCurrentCompany.data;
    List<String> dataItems = [];
    for (int i = 0; i < category.length; i++) {
      dataItems.add(category[i].organizationName);
    }
    return dataItems;
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

  @override
  void initState() {
    getProjects();
    // fetchCompany(query: "");
    fetchCurrentLocation(query: "");
    super.initState();
  }

  String errorMessage;
  ProjectPopulate populate;
  getProjects() {
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      apiServices.populateProjectUp(widget.uuid).then((response) {
        setState(() {
          isLoading = false;
        });
        if (response.error) {
          errorMessage = response.errorMessage ?? "An Error Occurred";
        }
        populate = response.data;
        titleController.text = populate.candidateprojectTitle;
        groupValue = int.parse(populate.candidateprojectType);
        currentCompanySearchCo.text = populate.candidateprojectClient;
        groupValue1 = int.parse(populate.candidateprojectStatus);
        urlController.text = populate.candidateprojectWeblink;
        descController.text = populate.candidateprojectDesc;
        groupValue2 = int.parse(populate.candidateprojectSite);
        groupValue3 = int.parse(populate.candidateprojectEmploymenttypeId);
        teamController.text = populate.candidateprojectTeamsize;
        roledescController.text = populate.candidateprojectRoledescription;
        skillController.text = populate.candidateprojectSkillsused;
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
              children: const [
                Text(
                  "Add Projects",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ProximaNova"),
                ),
                Text(
                  "Add details and links for academic and professional projects that you have worked on. ",
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
                padding:
                    EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Text("Project Type:   ",
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
                              "Academic",
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
                              "Professsional",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Project Title:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      TextFormField(
                        maxLength: 100,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z- ]"))
                        ],
                        controller: titleController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Enter Project Title";
                          } else {
                            return null;
                          }
                        },

                        decoration: InputDecoration(
                          hintText: "Enter Project Title",
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
                          top: 15,
                        ),
                        child: Text(" Project Client: ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                              controller: this.currentCompanySearchCo,
                              decoration:
                                  InputDecoration(hintText: 'Select Project Client')),
                          debounceDuration: Duration(milliseconds: 500),
                          suggestionsCallback: ApiServices.getCompany,
                          itemBuilder: (context, Company suggestions) {
                            final skill = suggestions;
                            return ListTile(
                              title: Text(skill.organizationName),
                            );
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Select Project Client";
                            }
                          },
                          noItemsFoundBuilder: (context) => Text(""),
                          onSuggestionSelected: (Company suggesstion) {
                            // final skill = suggesstion;
                            currentCompanySearchCo.text =
                                suggesstion.organizationName;
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Project Status",
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
                        child: Row(
                          children: [
                            GFRadio(
                              size: 20,
                              activeBorderColor: const Color(0xff3e61ed),
                              value: 1,
                              groupValue: groupValue1,
                              onChanged: (value) {
                                setState(() {
                                  groupValue1 = value;
                                });
                              },
                              inactiveIcon: null,
                              radioColor: const Color(0xff3e61ed),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const Text(
                              "Finished",
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
                              groupValue: groupValue1,
                              onChanged: (value) {
                                setState(() {
                                  groupValue1 = value;
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
                              "Ongoing",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      groupValue1 == 1
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DateTimeFormField(
                                      decoration: const InputDecoration(
                                        border: const UnderlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'Start Date',
                                        // hintStyle: heading6.copyWith(color: textGrey),
                                        // errorStyle: TextStyle(color: Colors.redAccent),
                                        suffixIcon: Icon(Icons.event_note),
                                      ),
                                      // initialValue: date,

                                      lastDate: lastDate,
                                      validator: (e) {
                                        if (e == null) {
                                          return "Select Start Date";
                                        } else {
                                          return null;
                                        }
                                      },
                                      mode: DateTimeFieldPickerMode.date,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,

                                      onDateSelected: (date) {
                                        setState(() {
                                          selectedDate = date;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: DateTimeFormField(
                                      decoration: const InputDecoration(
                                        border: const UnderlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        hintText: 'End Date',
                                        // hintStyle: heading6.copyWith(color: textGrey),
                                        // errorStyle: TextStyle(color: Colors.redAccent),
                                        suffixIcon: Icon(Icons.event_note),
                                      ),
                                      // initialValue: date,
                                      firstDate: selectedDate,
                                      lastDate:DateTime.now(),
                                      mode: DateTimeFieldPickerMode.date,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      validator: (e) {
                                        if (e == null) {
                                          return "Select End Date";
                                        } else {
                                          return null;
                                        }
                                      },

                                      onDateSelected: (date) {
                                        setState(() {
                                          selectedDate2 = date;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      groupValue1 == 2
                          ? Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: DateTimeFormField(
                                decoration: const InputDecoration(
                                  border: const UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  hintText: 'Start Date',
                                  // hintStyle: heading6.copyWith(color: textGrey),
                                  // errorStyle: TextStyle(color: Colors.redAccent),
                                  suffixIcon: Icon(Icons.event_note),
                                ),
                                // initialValue: date,
                                mode: DateTimeFieldPickerMode.date,
                                lastDate: lastDate,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (e) {
                                  if (e == null) {
                                    return "Select Start Date";
                                  } else {
                                    return null;
                                  }
                                },

                                onDateSelected: (date) {
                                  setState(() {
                                    selectedDate3 = date;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text("Project URL:",
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

                        },
                        controller: urlController,
                        decoration: InputDecoration(
                          hintText: "Enter Project URl",
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
                        child: Text("Description:",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "ProximaNova")),
                      ),
                      TextFormField(

                        maxLength: 1000,
                        maxLines: 6,
                        controller: descController,
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
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("Add more options",
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
                      Visibility(
                        visible: isVisible,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "Location:",
                                textAlign: TextAlign.left,
                                style: TextStyle(

                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "ProximaNova"),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            DropdownSearch<CurrentLocation>(
                              dropdownSearchDecoration: InputDecoration(
                                  border: UnderlineInputBorder()),


                              mode: Mode.DIALOG,
                              items: isLoadingCurrentLocation
                                  ? [CurrentLocation()]
                                  : _apiResponseCurrentLocation.data,
                              itemAsString: (CurrentLocation obj) {
                                return obj.cityName;
                              },
                              onFind: (val) async {
                                setState(() {
                                  query = val;
                                });
                                return _apiResponseCurrentLocation.data;
                              },
                              hint: "Select Location",
                              onChanged: (value) {
                                jobCategorySearchCon.text =
                                    value.cityName.toString();
                                cityID = value.cityId;
                                print(value.cityId);
                              },
                              showSearchBox: true,
                              popupItemBuilder: (context,
                                  CurrentLocation item, bool isSelected) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(item.cityName),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text("Project Site:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ProximaNova")),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  GFRadio(
                                    size: 20,
                                    activeBorderColor:
                                        const Color(0xff3e61ed),
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
                                    "Offsite",
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
                                    activeBorderColor:
                                        const Color(0xff3e61ed),
                                    radioColor: const Color(0xff3e61ed),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Text(
                                    "Onsite",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            groupValue == 2
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: Text("Nature Of Employment:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "ProximaNova")),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 10,
                            ),
                            groupValue == 2
                                ? Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        GFRadio(
                                          size: 20,
                                          activeBorderColor:
                                              const Color(0xff3e61ed),
                                          value: 1,
                                          groupValue: groupValue3,
                                          onChanged: (value) {
                                            setState(() {
                                              groupValue3 = value;
                                            });
                                          },
                                          inactiveIcon: null,
                                          radioColor: const Color(0xff3e61ed),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        const Text(
                                          "Full-Time",
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
                                          groupValue: groupValue3,
                                          onChanged: (value) {
                                            setState(() {
                                              groupValue3 = value;
                                            });
                                          },
                                          inactiveIcon: null,
                                          activeBorderColor:
                                              const Color(0xff3e61ed),
                                          radioColor: const Color(0xff3e61ed),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        const Text(
                                          "Part-Time",
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
                                          groupValue: groupValue3,
                                          onChanged: (value) {
                                            setState(() {
                                              groupValue3 = value;
                                            });
                                          },
                                          inactiveIcon: null,
                                          activeBorderColor:
                                              const Color(0xff3e61ed),
                                          radioColor: const Color(0xff3e61ed),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        const Text(
                                          "Contractual",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                            const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                              ),
                              child: Text("Team Size:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ProximaNova")),
                            ),
                            TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"))
                              ],


                              maxLength: 4,
                              keyboardType: TextInputType.number,
                              controller: teamController,
                              decoration: InputDecoration(
                                hintText: "Enter Team Size",
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
                              padding: EdgeInsets.only(top: 15),
                              child: Text("Role Description:",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "ProximaNova")),
                            ),
                            TextFormField(

                              maxLines: 5,
                              maxLength: 1000,
                              controller: roledescController,
                              decoration: InputDecoration(
                                hintText: "Enter Role Description",
                                hintStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.5,
                                ),
                              ),
                            ),
                            groupValue == 2
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                      top: 15,
                                    ),
                                    child: Text("Skill Used:",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "ProximaNova")),
                                  )
                                : Container(),
                            groupValue == 2
                                ? TextFormField(

                                    controller: skillController,
                                    decoration: InputDecoration(
                                      hintText: "Enter Skill",
                                      hintStyle: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: "ProximaNova",
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 14.5,
                                      ),
                                    ),
                                  )
                                : Container(),
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
              isEditing ?
              GFButton(
                onPressed: () async {
                  setState(() {
                    isLoadingProjects = true;
                  });
                  final insert = ProjectPopulate(
                      requestType: "delete",
                      candidateprojectUuid: widget.uuid);

                  final result = await apiServices.projectAdd(insert);
                  setState(() {
                    isLoadingProjects = false;
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
              Padding(
                padding: const EdgeInsets.only(right: 22),
                child: GFButton(
                    text: isEditing ? "Update" : "Add",
                    type: GFButtonType.solid,
                    blockButton: false,
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        if (isEditing) {
                          setState(() {
                            isLoading = true;
                          });

                          final insert = ProjectPopulate(
                            requestType: "update",
                            candidateprojectUuid: widget.uuid,
                            candidateprojectType: groupValue.toString(),
                            candidateprojectTitle: titleController.text,
                            candidateprojectClient:
                                currentCompanySearchCo.text,
                            candidateprojectStatus: groupValue1.toString(),
                            candidateprojectStartdate:
                                selectedDate.toString().split(" ")[0],
                            candidateprojectEnddate:
                                selectedDate2.toString().split(" ")[0],
                            candidateprojectWeblink: urlController.text,
                            candidateprojectDesc: descController.text,
                            candidateprojectLocationId: cityID,
                            candidateprojectSite: groupValue2.toString(),
                            candidateprojectEmploymenttypeId:
                                groupValue3.toString(),
                            candidateprojectTeamsize: teamController.text,
                            candidateprojectRoledescription:
                                roledescController.text,
                            candidateprojectSkillsused: skillController.text,
                          );

                          final result = await apiServices.projectAdd(insert);
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
                      else {
                        setState(() {
                          isLoading = true;
                        });
                        final insert = ProjectPopulate(
                          requestType: "add",
                          candidateprojectType: groupValue.toString(),
                          candidateprojectTitle: titleController.text,
                          candidateprojectClient:
                          currentCompanySearchCo.text,
                          candidateprojectStatus: groupValue1.toString(),
                          candidateprojectStartdate:
                          selectedDate.toString().split(" ")[0],
                          candidateprojectEnddate:
                          selectedDate2.toString().split(" ")[0],
                          candidateprojectWeblink: urlController.text,
                          candidateprojectDesc: descController.text,
                          // candidateprojectLocationId: cityID,
                          candidateprojectSite: groupValue2.toString(),
                          candidateprojectEmploymenttypeId:
                          groupValue3.toString(),
                          candidateprojectTeamsize: teamController.text,
                          candidateprojectRoledescription:
                          roledescController.text,
                          candidateprojectSkillsused: skillController.text,
                        );
                        final result = await apiServices.projectAdd(insert);
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

                    }
                    // }
                    ),
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
