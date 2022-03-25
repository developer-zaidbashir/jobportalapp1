import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_portal/Controllers/menucontroller.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/Awards.dart';
import 'package:job_portal/Models/BasicInfoPopulate.dart';
import 'package:job_portal/Models/CareerPreferencePopulate.dart';

import 'package:job_portal/Models/CertificationPopulate.dart';
import 'package:job_portal/Models/ItSkillRetrive.dart';
import 'package:job_portal/Models/ItSkills.dart';
import 'package:job_portal/Models/Language-Populate.dart';
import 'package:job_portal/Models/Patent-Populate.dart';
import 'package:job_portal/Models/KeySkillDeleteProfile.dart';
import 'package:job_portal/Models/KeySkillProfilePopulate.dart';
import 'package:job_portal/Models/PersonalDetailsRetrive.dart';
import 'package:job_portal/Models/Presentation-Populate.dart';
import 'package:job_portal/Models/ProfileSummaryPopulate.dart';
import 'package:job_portal/Models/QualificationPopulate.dart';
import 'package:job_portal/Models/Researchpaper.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Theme/colors.dart';
import 'package:job_portal/Models/ProfessionalPopulate.dart';
import 'package:job_portal/Models/ProjectPopulate.dart';
import 'package:job_portal/Theme/images.dart';
import 'package:job_portal/Utility/Connect.dart';
import 'package:job_portal/Utility/apiurls.dart';
import 'package:job_portal/Views/Candidate/Sidebar.dart';
import 'package:job_portal/Views/Profile/PresentationAdd.dart';
import 'package:job_portal/Views/Profile/ProfileSummary.dart';
import 'package:job_portal/Views/Profile/UpdateBasic%20Detail.dart';
import 'package:job_portal/Views/Profile/UpdateCareerPreference.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../Candidate/Inbox.dart';
import 'AddAwards.dart';
import 'AddCertificates.dart';
import 'AddItskill.dart';
import 'AddKeySkill.dart';
import 'AddLanguages.dart';
import 'AddPatent.dart';
import 'AddProjects.dart';
import 'PersonalUpdate.dart';
import 'Professional-Add.dart';
import 'QualificationAdd.dart';
import 'ResearchPaperAdd.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.basic}) : super(key: key);
  String basic;
  String keyjwt;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final itemKey = GlobalKey();
  final skillKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ApiResponse<dynamic> apiResponseProfilePicture;
  ApiResponse<dynamic> apiResponseGetPicture;
  // bool  get key  => widget.ite47mKey != null;
  Future scrollToItem() async {
    final context = itemKey.currentContext;
    await Scrollable.ensureVisible(context);
  }

  Future scrollToItems() async {
    final context = skillKey.currentContext;
    await Scrollable.ensureVisible(context);
  }

  void getImageContent() async {
    // apiResponseGetPicture = await ApiServices().getImageOfUser();
  }

  int groupValue = 0;
  final bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  AnimationController loadingController;

  File _file;
  PlatformFile _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (file != null) {
      setState(() {
        _file = File(file.files.single.path);
      });
    }
    loadingController.forward();
  }

  // profile img
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  File _image;

  _imgFromCamera() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.camera);
      print(image);
      if (image == null) return;
      File imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
        print(_image);
      });
      print("Entering Into Services...");
      apiResponseProfilePicture = await apiServices.postProfilePicture(
          file: _image);
      apiResponseProfilePicture =
          await apiServices.postProfilePicture(file: _image);
      print(apiResponseProfilePicture.data);
      Map<String, dynamic> data =
          json.decode(apiResponseProfilePicture.data) as Map<String, dynamic>;
      if (apiResponseProfilePicture.responseCode == 200) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Row(children: [
              Icon(
                data['errormsg'] == null ? Icons.done : Icons.error_outline,
                color: Colors.white,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(data['errormsg'] == null
                    ? data['successmsg']
                    : data['errormsg']),
              ),
            ]),
            backgroundColor:
                data['errormsg'] == null ? Colors.green : Colors.red,
            duration: const Duration(milliseconds: 2500),
          ),
        );
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            // action: SnackBarAction(label: "JobPortalApp", onPressed: (){}),
            content: Row(children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(data['errormsg']),
              ),
            ]),
            backgroundColor: Colors.red,
            duration: const Duration(milliseconds: 2500),
          ),
        );
      }
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  _imgFromGallery() async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      print(image);
      if (image == null) return;
      File imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
        print(_image);
      });
      print("Entering Into Services...");
      apiResponseProfilePicture =
          await apiServices.postProfilePicture(file: _image);
      print(apiResponseProfilePicture.data);
      Map<String, dynamic> data =
          json.decode(apiResponseProfilePicture.data) as Map<String, dynamic>;
      if (apiResponseProfilePicture.responseCode == 200) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Row(children: [
              const Icon(
                Icons.done,
                color: Colors.white,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(data['successmsg']),
              ),
            ]),
            backgroundColor: Colors.green,
            duration: const Duration(milliseconds: 2500),
          ),
        );
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            // action: SnackBarAction(label: "JobPortalApp", onPressed: (){}),
            content: Row(children: [
              const Icon(
                Icons.error_outline,
                color: Colors.white,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(apiResponseProfilePicture.data),
              ),
            ]),
            backgroundColor: Colors.red,
            duration: const Duration(milliseconds: 2500),
          ),
        );
      }
    } on PlatformException catch (e) {
      print("Failed to pick image : $e");
    }
  }

  @override
  void initState() {
    getImageContent();
    getCertification();
    getItSkill();
    getPersonal();
    populateKeySkills();
    getProfessional();
    populateCareerPreferenceProfile();
    getQualification();
    getLanguage();
    getProject();
    getPatent();
    getAwards();
    getSummary();
    getPresentation();
    getResearch();
    getbasicss();
    getUserName();

    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });

    super.initState();
  }


  bool loadUser;

  dynamic username;
  getUserName()async{
    setState(() {
      loadUser= true;
    });
    username = await secureStorage.read(key: "candidateName");
    setState(() {
      loadUser= false;
    });
  }


  bool isLoading = false;
  bool isLoadingProfileSummary = false;
  bool isLoadingBasicProfile = false;
  bool isLoadingQualificationProfile = false;
  bool isLoadingProfessionalProfile = false;
  bool isLoadingItSkillsProfile = false;
  bool isLoadingPersonalProfile = false;
  bool isLoadingPopulateKeySkillsProfile = false;
  bool isLoadingPopulateCareerPreferenceProfile = false;
  bool isLoadingAwards = false;
  bool isLoadingProjects = false;
  bool isLoadingCertification = false;
  bool isLoadingPresentation = false;
  bool isLoadingPatents = false;
  bool isLoadingResearch = false;
  bool isLoadingLanguages = false;
  ApiResponse<List<ItSkillProfile>> _apiResponse;
  ApiResponse<BasicInfoPopulate> _apiResponseBasics;
  ApiResponse<List<QualificationPopulate>> _apiResponse2;
  ApiResponse<List<PersonalRetrive>> _apiResponse3;
  ApiResponse<List<LanguagePopulate>> _apiResponseLang;
  ApiResponse<List<PatentPopulate>> _apiResponsePatent;
  ApiResponse<List<Awards>> _apiResponseAwards;
  ApiResponse<List<PopulateKeySkillsProfileModel>> _apiResponseKeySkillPopulate;
  ApiResponse<List<ProjectPopulate>> apiResponseProjectPopulate;
  ApiResponse<List<CertificationPopulate>> apiResponseCertificationPopulate;
  ApiResponse<CareerPreferencePopulate> apiResponseCareerPreferencePopulate;
  ApiResponse<List<SummaryPopulate>> apiResponseSummary;
  ApiResponse<List<PresentationPopulate>> apiResponsePresentationPopulate;
  ApiResponse<List<ProfessionalPopulate>> _apiResponse5;
  ApiResponse<List<ResearchpaperAdd>> apiResponseResearchPopulate;

  ApiServices apiServices = ApiServices();

  QualificationPopulate qualify;
  String errorMessage;

  getResearch() async {
    setState(() {
      isLoadingResearch = true;
    });
    apiResponseResearchPopulate = await apiServices.researchPopulate();
    setState(() {
      isLoadingResearch = false;
    });
  }

  getPresentation() async {
    setState(() {
      isLoadingPresentation = true;
    });
    apiResponsePresentationPopulate = await apiServices.PopulatePresentation();
    setState(() {
      isLoadingPresentation = false;
    });
  }

  getSummary() async {
    setState(() {
      isLoadingProfileSummary = true;
    });
    apiResponseSummary = await apiServices.PopulateSummary();
    setState(() {
      isLoadingProfileSummary = false;
    });
  }

  getbasicss() async {
    setState(() {
      isLoadingBasicProfile = true;
    });
    _apiResponseBasics = await apiServices.PopulateBasicInfo();
    setState(() {
      isLoadingBasicProfile = false;
    });
  }

  populateCareerPreferenceProfile() async {
    setState(() {
      isLoadingPopulateCareerPreferenceProfile = true;
    });
    apiResponseCareerPreferencePopulate = await apiServices.getCareerPreferencePopulate();
    setState(() {
      isLoadingPopulateCareerPreferenceProfile = false;
    });
  }

  getCertification() async {
    setState(() {
      isLoadingCertification = true;
    });
    apiResponseCertificationPopulate =
        await apiServices.PopulateCertification();
    setState(() {
      isLoadingCertification = false;
    });
  }

  getProject() async {
    setState(() {
      isLoadingProjects = true;
    });
    apiResponseProjectPopulate = await apiServices.PopulateProject();
    setState(() {
      isLoadingProjects = false;
    });
  }

  populateKeySkills() async {
    setState(() {
      isLoadingPopulateKeySkillsProfile = true;
    });
    _apiResponseKeySkillPopulate = await apiServices.getKeySkillsProfile();
    setState(() {
      isLoadingPopulateKeySkillsProfile = false;
    });
  }

  getAwards() async {
    setState(() {
      isLoadingAwards = true;
    });
    _apiResponseAwards = await apiServices.populateAwards();
    setState(() {
      isLoadingAwards = false;
    });
  }

  getPatent() async {
    setState(() {
      isLoadingPatents = true;
    });
    _apiResponsePatent = await apiServices.PopulatePatent();
    setState(() {
      isLoadingPatents = false;
    });
  }

  getLanguage() async {
    setState(() {
      isLoadingLanguages = true;
    });
    _apiResponseLang = await apiServices.PopulateLanguage();
    setState(() {
      isLoadingLanguages = false;
    });
  }

  getPersonal() async {
    setState(() {
      isLoadingPersonalProfile = true;
    });
    _apiResponse3 = await apiServices.PopulatePersonal();
    setState(() {
      isLoadingPersonalProfile = false;
    });
  }

  getQualification() async {
    setState(() {
      isLoadingQualificationProfile = true;
    });
    _apiResponse2 = await apiServices.PopulateQualification();
    setState(() {
      isLoadingQualificationProfile = false;
    });
  }

  getItSkill() async {
    setState(() {
      isLoadingItSkillsProfile = true;
    });
    _apiResponse = await apiServices.PopulateItSkill();
    setState(() {
      isLoadingItSkillsProfile = false;
    });
  }

  getProfessional() async {
    setState(() {
      isLoadingProfessionalProfile = true;
    });
    _apiResponse5 = await apiServices.ProfessionalDetailsPopulate();
    setState(() {
      isLoadingProfessionalProfile = false;
    });
  }

  TextEditingController skillSearchCont = TextEditingController();
  String queries;
  ApiResponse<List<ITSkill>> _apiResponseITSkill;
  String itSkillId = "";

  fetchITSkill({String query}) async {
    setState(() {
      isLoading = true;
    });
    _apiResponseITSkill = await apiServices.getITSkill(query: query);
    setState(() {
      isLoading = false;
    });
  }

  List<Widget> GetHeadline() {
    List<Widget> childs = apiResponseSummary.data
        .map((e) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(e.candidateHeadline ?? "",
                      style: const TextStyle(
                        fontSize: 14.0,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ProximaNova",
                      )),
                )
              ],
            ))
        .toList();
    return childs;
  }

  List<Widget> GetSummary() {
    List<Widget> childs = apiResponseSummary.data
        .map((e) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "PROFILE SUMMARY",
                            style: TextStyle(
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 16.5,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SummaryAdd(
                                              textfield: e.candidateProfilesummary,
                                              headline: e.candidateHeadline,
                                            ))).then((value) => getSummary());
                              },
                              child: const Icon(Icons.edit, color: Color(0xff3e61ed)))
                        ],
                      ),
                      apiResponseSummary.data != 0 ?Text(
                        "Add a brief about your career,education,skills,interests and experiences for recruiters\nto get better understanding of your personality."
                        ,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "ProximaNova",
                          color: Colors.grey,
                        ),
                      ):Text("")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(top:20,right:25,left:25),
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              apiResponseSummary.data == null? Text(
                                "Add a brief about your career,education,skills,interest and experiences for recruiters to get better"
                                    "understanding of your career.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "ProximaNova",
                                  color: Colors.grey.shade600,
                                ),
                              ):
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(

                                      child: Text(e.candidateProfilesummary ?? "",
                                          overflow:TextOverflow.visible,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "ProximaNova",
                                          )),
                                    ),
                                    ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ))
        .toList();
    return childs;
  }

  List<Widget> getPersonalList() {
    List<Widget> childs = _apiResponse3.data
        .map(
          (e) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PERSONAL DETAILS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PersonalUpdate(
                                          Address: e.candidateAddress,
                                          City: e.cityName,
                                          PinCode: e.candidatePin,
                                          DOB: e.candidateDob,
                                          Marry: e.maritalstatusName,
                                          Nationality: e.countryName,
                                          Pan: e.candidatePancard,
                                          Pass: e.candidatePassportno,
                                          Ex: e.candidateExservicemen,
                                        ))).then((value) => getPersonal());
                          },
                          child: const Icon(Icons.edit, color: Color(0xff3e61ed)),
                        ),
                      ],
                    ),
                    Text(
                      "Add Personal details to complete and authenticate your profile for recruiters.",
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
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(e.candidateAddress ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'City:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(e.cityName ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pincode:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(e.candidatePin ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'D.O.B:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(e.candidateDob.toString().split(" ")[0] ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Marital Status:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(e.maritalstatusName ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Category:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: const Text('OM',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ex-Servicemen Experience:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                        e.candidateExservicemenExp ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PAN Number:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(e.candidatePancard ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nationality:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text('Indian',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 25, bottom: 25),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Passport Number:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(e.candidatePassportno ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Country:',
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(e.countryName ?? "",
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
        .toList();
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: context.read<MenuController>().scaffoldKeys,
        drawer: const SideMenu(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: context.read<MenuController>().controlMenu2,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-%EC%83%98%ED%94%8C-%EC%A7%80-%EB%B9%A8%EA%B0%84%EC%83%89-%EB%9D%BC%EC%9A%B4%EB%93%9C-%EC%8A%A4%ED%83%AC%ED%94%84.jpg"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                            color: KColors.lightGrey,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          "What are you looking for?",
                          style:
                              TextStyle(fontSize: 15, color: KColors.subtitle),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.chat,
                        color: Color(0xff3e61ed),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InboxList()));
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Stack(fit: StackFit.loose, children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-%EC%83%98%ED%94%8C-%EC%A7%80-%EB%B9%A8%EA%B0%84%EC%83%89-%EB%9D%BC%EC%9A%B4%EB%93%9C-%EC%8A%A4%ED%83%AC%ED%94%84.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 70.0, right: 80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              _showPicker(context);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              radius: 15.0,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )),
                ]),
              ),
              Text(
                username,
                style: const TextStyle(
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 16.5,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: GetHeadline(),
              ),
              GFButton(
                  color: const Color(0xff3e61ed),
                  onPressed: () {
                    selectFile();
                    ApiServices().postResume(text: "file", file: _file);
                  },
                  child: const Text(
                    "My Resume",
                    style: TextStyle(
                      fontFamily: "ProximaNova",
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 1.5,
                      fontSize: 13.5,
                    ),
                  )),
              const Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 10,
                endIndent: 10,
              ),
              Column(
                children: GetSummary(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "BASIC INFORMATION",
                          style: TextStyle(
                            fontFamily: "ProximaNova-Regular",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateBasicDetails()))
                                  .then((value) => getbasicss());
                            },
                            child: const Icon(Icons.edit, color: const Color(0xff3e61ed)))
                      ],
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
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 25),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Name:',
                                      style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                          _apiResponseBasics.data.candidateName ??
                                              "clustech",
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Contact No:',
                                      style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          _apiResponseBasics
                                                  .data.candidateMobile1 ??
                                              "1234",
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 25),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email:',
                                      style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          _apiResponseBasics
                                                  .data.candidateEmail1 ??
                                              "1234",
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gender:',
                                      style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          _apiResponseBasics
                                                  .data.candidateGenderName ??
                                              "1234",
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 25),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Experience Tenure:',
                                      style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          _apiResponseBasics
                                                  .data.candidateTotalWorkExp ??
                                              "1234",
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Preferred Job Role:',
                                      style: TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 12.5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          _apiResponseBasics
                                              .data.preferedJobRoleNames?? "ABC",
                                          style: const TextStyle(
                                              fontSize: 14.0,
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "QUALIFICATION DETAILS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QualificationAdd()))
                                .then((value) => getQualification());
                          },
                          child: const Text(
                            'Add',
                            style: const TextStyle(
                                color: const Color(0xff3e61ed),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    _apiResponse2.data.length != 0 ?Text(
                      "Add your Qualification for recruiters to check on you for potential jobs.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text("")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 20, left: 20, top: 10),
                    child: Column(
                      children: [
                                   _apiResponse2.data.length == 0 ? Column(
                            children:  [
                              Text(
                                "Add your qualification details for us to match you with a perfect job.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "ProximaNova",
                                  color: Colors.grey.shade600,
                                ),
                              ),

                        ]):  qualificationList(context),
                      ],
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PROFESSIONAL DETAILS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (context) => ProfessionAdd(),
                                  ),
                                )
                                .then((value) => getProfessional());
                          },
                          child: const Text(
                            'Add',
                            style: const TextStyle(
                                color: Color(0xff3e61ed),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    _apiResponse5.data.length != 0? Text(
                      "Add your professional details to help us find a better fitted job for you.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text("")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 20, left: 20, top: 10),
                    child: SizedBox(
                      width: double.infinity,

                      child: Column(

                        children: [

                          _apiResponse5.data.length == 0 ? Column(
                              children:  [
                                Text(
                                  "Add your professional details to help us find a better fitted job for you."
                                  ,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "ProximaNova",
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                              ]):  professionallist(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                key: skillKey,
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          " KEY SKILLS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (context) => AddSkillsPage(),
                                  ),
                                )
                                .then((value) => populateKeySkills());
                          },
                          child: const Text(
                            'Add',
                            style: const TextStyle(
                                color: Color(0xff3e61ed),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    _apiResponseKeySkillPopulate.data.length != 0 ?Text(
                      "Add skills for recruiters to find you easily in keywords search.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text("")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        _apiResponseKeySkillPopulate.data.length == 0 ? Column(
                            children:  [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Add skills for recruiters to find you easily in keywords search.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "ProximaNova",
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),

                            ]):
                        Wrap(
                          children: _apiResponseKeySkillPopulate.data.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, top: 8.0, left: 20, bottom: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                  border: Border.all(color: const Color(0xff3e61ed)),
                                ),
                                child: Wrap(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 11, left: 5, bottom: 5),
                                    child: Text(
                                      e.keyskillName,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          isLoadingPopulateKeySkillsProfile = true;
                                        });
                                        apiServices.keySkillDeleteProfile(
                                            obj: KeySkillDeleteProfile(
                                                requestType: "delete",
                                                candidatekeyskillUuid:
                                                    e.candidatekeyskillUuid));
                                        setState(() {
                                          populateKeySkills();
                                          isLoadingPopulateKeySkillsProfile = true;
                                        });
                                      }),
                                ]),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "IT SKILLS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ItSkillAdds()))
                                .then((value) => getItSkill());
                          },
                          child: const Text(
                            'Add',
                            style: TextStyle(
                                color: Color(0xff3e61ed),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    _apiResponse.data.length != 0 ?Text(
                      "Add skills and attributes for recruiters to find you easily in keyword search."
                      ,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text("")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                        width:double.infinity,
                        child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            child:
                            _apiResponse.data.length == 0 ? Column(
                                children: [
                                  Text(
                                    "Add skills and attributes for recruiters to find you easily in keyword search."
                                    ,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "ProximaNova",
                                      color: Colors.grey.shade600,
                                    ),
                                  ),

                                ]): ItSkillGrid(context),


                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "CAREER PREFERENCES",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateCareerPreference()))
                                .then((value) => populateCareerPreferenceProfile());
                          },
                          child: const Icon(Icons.edit, color: Color(0xff3e61ed)),
                        )
                      ],
                    ),
                    apiResponseCareerPreferencePopulate
                        .data != 0 ? Text(
                      "Share desirable traits in a job and we will recommend best fit jobs for you.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text("")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 25),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Preferred Industries:',
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                                apiResponseCareerPreferencePopulate
                                                    .data.industryName,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "ProximaNova",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Preferred Job Type:',
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                                apiResponseCareerPreferencePopulate
                                                    .data.jobtypeName,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "ProximaNova",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 25),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Preferred Employment Type:',
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                                apiResponseCareerPreferencePopulate
                                                    .data.employmenttypeName,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "ProximaNova",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Preferred Job Location:',
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                                apiResponseCareerPreferencePopulate
                                                    .data.cityName,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "ProximaNova",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 25),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Salary Expectation:',
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                                apiResponseCareerPreferencePopulate
                                                        .data
                                                        .candidateExpectedctc ??
                                                    "12000",
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "ProximaNova",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Preferred Shift:',
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 13.0,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                                apiResponseCareerPreferencePopulate
                                                            .data.shiftName ==
                                                        ""
                                                    ? "flexible"
                                                    : apiResponseCareerPreferencePopulate
                                                        .data.shiftName,
                                                style: const TextStyle(
                                                    fontSize: 14.0,
                                                    fontFamily: "ProximaNova",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
              Column(
                children: getPersonalList(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "AWARDS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                      ],
                    ),
                    _apiResponseAwards.data.length != 0 ? Text(
                      "Showcase the awards earned by you.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text(""),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      child:


                      _apiResponseAwards.data.length == 0 ? Column(
                          children:  [
                            Text(
                              "Showcase the awards earned by you."
                              ,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "ProximaNova",
                                color: Colors.grey.shade600,
                              ),
                            ),

                          ]): awardsList(context),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PROJECTS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                      ],
                    ),
                    apiResponseProjectPopulate.data.length != 0 ?Text(
                      "Add details and links for academic and professional projects that you have worked on. ",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text(""),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 20, left: 20, top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [

                          apiResponseProjectPopulate.data.length == 0 ? Column(
                              children:  [
                                Text(
                                  "Add details and links for academic and professional projects that you have worked on. "
                                  ,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "ProximaNova",
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                              ]): projectList(context),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "CERTIFICATION",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                      ],
                    ),
                    apiResponseCertificationPopulate.data.length != 0 ? Text(
                      "Add details and links of your certifications.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text(""),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 20, left: 20, top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [


                          apiResponseCertificationPopulate.data.length == 0 ? Column(
                              children:  [
                                Text(
                                  "Add details and links of your certifications.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "ProximaNova",
                                    color: Colors.grey.shade600,
                                  ),
                                ),

                              ]):    CertificationGrid(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PRESENTATIONS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                      ],
                    ),
                    apiResponsePresentationPopulate.data.length != 0 ?Text(
                      "Add web-links for online presentation."
                      ,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text(""),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 20, left: 20, top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [

                          apiResponsePresentationPopulate.data.length == 0 ? Column(
                              children:  [
                                Text(
                                  "Add web-links for online presentation."
                                  ,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "ProximaNova",
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ]):    presentationList(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "PATENTS",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                      ],
                    ),
                    _apiResponsePatent.data.length != 0 ? Text(
                      "Add details and links of patents filled by you."
                      ,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text(""),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [

                          _apiResponsePatent.data.length == 0 ? Column(
                              children:  [
                                Text(
                                  "Add details and links of patents filled by you."
                                  ,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "ProximaNova",
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ]):    patentGrid(context),

                        ],
                      ),
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "RESEARCH PUBLICATION",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                      ],
                    ),
                    apiResponseResearchPopulate.data.length != 0 ?Text(
                      "Add details and links for your publications."
                      ,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text(""),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, right: 20, left: 20, top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [

                          apiResponseResearchPopulate.data.length == 0 ? Column(
                              children: [
                                Text(
                                  "Add details and links for your publications."
                                  ,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "ProximaNova",
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ]): researchList(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "LANGUAGES",
                          style: TextStyle(
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 16.5,
                          ),
                        ),
                      ],
                    ),
                    _apiResponseLang.data.length != 0?Text(
                      "Add the languages you can speak and understand."
                      ,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProximaNova",
                        color: Colors.grey,
                      ),
                    ):Text("")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child:
                     SizedBox(
                       width: double.infinity,
                       child: Column(
                         children: [
                           _apiResponseLang.data.length == 0 ? Column(
                               children:  [
                                 Text(
                                   "Add the languages you can speak and understand."
                                   ,
                                   style: TextStyle(
                                     fontSize: 14,
                                     fontFamily: "ProximaNova",
                                     color: Colors.grey.shade600,
                                   ),
                                 ),
                               ]): LanguageGrid(context),
                         ],
                       ),
                     ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "UPLOAD RESUME",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 16.5,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {},
                        child:
                            const Icon(Icons.edit, color: Color(0xff3e61ed))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: selectFile,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 20.0),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: Colors.blue.shade400,
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.blue.shade50.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Iconsax.folder_open,
                                        color: Colors.blue,
                                        size: 40,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Select your file',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey.shade400),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                        _platformFile != null
                            ? Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Selected File',
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade200,
                                                offset: const Offset(0, 1),
                                                blurRadius: 3,
                                                spreadRadius: 2,
                                              )
                                            ]),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.file(
                                                  _file,
                                                  width: 70,
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _platformFile.name,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${(_platformFile.size / 1024).ceil()} KB',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors
                                                            .grey.shade500),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                      height: 5,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color:
                                                            Colors.blue.shade50,
                                                      ),
                                                      child:
                                                          LinearProgressIndicator(
                                                        value: loadingController
                                                            .value,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      minWidth: double.infinity,
                                      height: 45,
                                      onPressed: () async{
                                   await apiServices.postFile(
                                           text: "candidatePhoto",
                                           file: _image);
                                       // if(result.statusCode == 200){
                                       //   showDialog(context:context,builder: (_)=> AlertDialog(
                                       //     title: Column(
                                       //       children: [
                                       //         Text("${result.statusCode}"),
                                       //       ],
                                       //     ),
                                       //   ));
                                       // }else{
                                       //   showDialog(context:context,builder: (_)=> AlertDialog(
                                       //     title: Column(
                                       //       children: [
                                       //         Text("${result.statusCode}"),
                                       //       ],
                                       //     ),
                                       //   ));
                                       // }
                                      },
                                      color: Colors.black,
                                      child: const Text(
                                        'Upload',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 20, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ADD SECTION",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 16.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Column(children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddAwards()))
                                .then((value) => getAwards());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.control_point_outlined,
                                  color: const Color(0xff3e61ed)),
                              const SizedBox(width: 10),
                              const Text(
                                'Awards',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "ProximaNova",
                                  color: Color(0xff3e61ed),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Projects()))
                                      .then((value) => getProject());
                                },
                                child: const Icon(Icons.control_point_outlined,
                                    color: Color(0xff3e61ed))),
                            const SizedBox(width: 10),
                            const Text(
                              'Projects',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: "ProximaNova",
                                color: Color(0xff3e61ed),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Certification()))
                                      .then((value) => getCertification());
                                },
                                child: const Icon(Icons.control_point_outlined,
                                    color: Color(0xff3e61ed))),
                            const SizedBox(width: 10),
                            const Text(
                              'Certifications',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: "ProximaNova",
                                color: Color(0xff3e61ed),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Presentation()))
                                .then((value) => getPresentation());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.control_point_outlined,
                                  color: const Color(0xff3e61ed)),
                              const SizedBox(width: 10),
                              const Text(
                                'Presentations',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "ProximaNova",
                                  color: Color(0xff3e61ed),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPatents()))
                                .then((value) => getPatent());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.control_point_outlined,
                                  color: Color(0xff3e61ed)),
                              const SizedBox(width: 10),
                              const Text(
                                'Patents',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "ProximaNova",
                                  color: Color(0xff3e61ed),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Research()))
                                .then((value) => getResearch());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.control_point_outlined,
                                  color: const Color(0xff3e61ed)),
                              const SizedBox(width: 10),
                              const Text(
                                'Research Publication',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "ProximaNova",
                                  color: Color(0xff3e61ed),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LanguagesAdd()))
                                .then((value) => getLanguage());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.control_point_outlined,
                                  color: const Color(0xff3e61ed)),
                              const SizedBox(width: 10),
                              const Text(
                                'Languages',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "ProximaNova",
                                  color: Color(0xff3e61ed),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ],
            // edited
          ),
        ),
      ),
    );
  }

  Widget presentationList(BuildContext context) {
    return isLoadingPresentation
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(
              height: 5,
            ),
            itemCount: apiResponsePresentationPopulate.data.length,
            itemBuilder: (_, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xff3e61ed))),
                child: Column(children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              apiResponsePresentationPopulate
                                  .data[index].candidatepresentationTitle,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "ProximaNova",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Presentation(
                                          uuid: apiResponsePresentationPopulate
                                              .data[index].candidatepresentationUuid,
                                        ))).then((value) => getPresentation());
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Color(0xff3e61ed),
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponsePresentationPopulate
                                    .data[index].candidatepresentationWeblink,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ]),
              );
            },
          );
  }

  Widget professionallist(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _apiResponse5.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xff3e61ed))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _apiResponse5.data[index].Designation,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfessionAdd(
                                  uuid: _apiResponse5.data[index].candidateexpUuid,
                                ))).then((value) => getProfessional());
                      },

                      child:
                      const Icon(Icons.edit, color: KColors.primary)),



                ],
              ),
              Text(
                _apiResponse5.data[index].OrganizationName ?? "2 years",
                style: const TextStyle(
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 13.5,
                ),
              ),
              Text(
                _apiResponse5.data[index].Salary ?? "2 years",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 12.5,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: _apiResponse5.data[index].StartDate,
                    style: TextStyle(
                      fontFamily: "ProximaNova",
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      fontSize: 11.5,
                    ),
                    children: [
                      TextSpan(
                        text: _apiResponse5.data[index]
                                    .candidateexpIscurrentcompany ==
                                "1"
                            ? "Present"
                            : "to" + _apiResponse5.data[index].EndDate,
                        style: const TextStyle(
                          fontFamily: "ProximaNova",
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 14.5,
                        ),
                      ),
                    ]),
              ),
              Text(
                _apiResponse5.data[index].NoticePeriod ?? "",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget qualificationList(BuildContext context) {
    return isLoadingQualificationProfile
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(
              height: 5,
            ),
            itemCount: _apiResponse2.data.length,
            itemBuilder: (_, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xff3e61ed))),
                child: Column(children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _apiResponse2.data[index].QualificationName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "ProximaNova",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _apiResponse2.data[index].CourseName == ""
                                  ? _apiResponse2
                                          .data[index].getBoardName +
                                      "-" +
                                      _apiResponse2
                                          .data[index].SchoolmediumName
                                  : _apiResponse2
                                          .data[index].CourseName +
                                      "-" +
                                      _apiResponse2
                                          .data[index].StreamName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "ProximaNova",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QualificationAdd(
                                        uuid:
                                        _apiResponse2.data[index].candidatequalUuid,
                                      ))).then((value) => getQualification());
                            },


                            child: const Icon(Icons.edit,
                                color: Color(0xff3e61ed)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _apiResponse2.data[index].InstituteName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  color:Colors.grey.shade600,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _apiResponse2
                                    .data[index].CandidatequalCompletionYear,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ]),
              );
            },
          );
  }

  Widget ItSkillGrid(BuildContext context) {
    // double cardWidth = MediaQuery.of(context).size.width / 3.3;
    // double cardHeight = MediaQuery.of(context).size.height / 3.6;
    final orientation = MediaQuery.of(context).orientation;
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),

      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _apiResponse.data.length,

      // childAspectRatio: cardWidth/cardHeight ,
      crossAxisSpacing: 5,
      mainAxisSpacing: 6,
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xff3e61ed))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _apiResponse.data[index].candidateitskillName == ""
                          ? _apiResponse.data[index].itskillName
                          : _apiResponse.data[index].candidateitskillName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItSkillAdds(
                                  uuid: _apiResponse.data[index].candidateitskillUuid,
                                ))).then((value) => getItSkill());
                      },


                      child:
                      const Icon(Icons.edit, color: KColors.primary)),

                ],
              ),
              Text(
                _apiResponse.data[index].candidateitskillExperience ??
                    "2 years",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 13.5,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Last Used:",
                    style: const TextStyle(
                      fontFamily: "ProximaNova",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      fontSize: 12.5,
                    ),
                    children: [
                      TextSpan(
                        text: _apiResponse
                                .data[index].candidateitskillLastused
                                .toString() ??
                            "",
                        style: TextStyle(
                          fontFamily: "ProximaNova",
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                          fontSize: 12,
                        ),
                      ),
                    ]),
              ),
              RichText(
                text: TextSpan(
                  text: "Version:",
                  style: const TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 12.5,
                  ),
                  children: [
                    TextSpan(
                      text: _apiResponse.data[index].candidateitskillVersion
                              .toString() ??
                          "",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget LanguageGrid(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _apiResponseLang.data.length,

      // childAspectRatio: (1 / .36),
      crossAxisSpacing: 5,
      mainAxisSpacing: 6,
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xff3e61ed))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _apiResponseLang.data[index].Language == ""
                        ? _apiResponseLang.data[index].Languagename
                        : _apiResponseLang.data[index].Language,
                    style: const TextStyle(
                      fontFamily: "ProximaNova",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 15.0,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LanguagesAdd(
                                  uuid: _apiResponseLang.data[index].candidatelangUuid,
                                ))).then((value) => getLanguage());
                      },
                      child:
                      const Icon(Icons.edit, color: KColors.primary)
                  )


                ],
              ),
              Text(
                _apiResponseLang.data[index].ProficiencyName ?? "2 years",
                style: const TextStyle(
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 11.5,
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Ablity:",
                    style: const TextStyle(
                      fontFamily: "ProximaNova",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      fontSize: 12.5,
                    ),
                    children: [
                      TextSpan(
                        text: _apiResponseLang.data[index].Read == "1"
                            ? "Read"
                            : "",
                        style: TextStyle(
                          fontFamily: "ProximaNova",
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 11.5,
                        ),
                      ),
                      TextSpan(
                        text: _apiResponseLang.data[index].Write == "1"
                            ? " Write"
                            : "",
                        style: TextStyle(
                          fontFamily: "ProximaNova",
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 11.5,
                        ),
                      ),
                      TextSpan(
                        text: _apiResponseLang.data[index].Speak == "1"
                            ? " Speak"
                            : "",
                        style: TextStyle(
                          fontFamily: "ProximaNova",
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 11.5,
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget patentGrid(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _apiResponsePatent.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xff3e61ed))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _apiResponsePatent.data[index].candidatepatentTitle,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddPatents(
                                  uuid: _apiResponsePatent
                                      .data[index].candidatepatentUuid,
                                ))).then((value) => getPatent());
                      },
                      child:
                      const Icon(Icons.edit, color: KColors.primary))

                ],
              ),
              Text(
                _apiResponsePatent.data[index].candidatepatentIssuedate
                        .split(" ")[0] ??
                    "2 years",
                style: const TextStyle(
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 13,
                ),
              ),
              Text(
                _apiResponsePatent.data[index].candidatepatentOffice ??
                    "2 years",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color:Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 12.5,
                ),
              ),
              Text(
                _apiResponsePatent.data[index].candidatepatentDesc == ""
                    ? ""
                    : _apiResponsePatent.data[index].candidatepatentDesc,
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget projectList(BuildContext context) {
    return isLoadingProjects
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (_, __) => const SizedBox(
              height: 5,
            ),
            itemCount: apiResponseProjectPopulate.data.length,
            itemBuilder: (_, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xff3e61ed))),
                child: Column(children: [
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate
                                    .data[index].candidateprojectType,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              apiResponseProjectPopulate
                                  .data[index].candidateprojectTitle,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: "ProximaNova",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  apiResponseProjectPopulate
                                      .data[index].candidateprojectClient,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: "ProximaNova",
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontSize: 15.0,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Projects(
                                              uuid: apiResponseProjectPopulate
                                                  .data[index].candidateprojectUuid,
                                            ))).then((value) => getProject());
                                  },
                                    child: const Icon(Icons.edit, color: KColors.primary),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate
                                    .data[index].candidateprojectStatus,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                              apiResponseProjectPopulate.data[index]
                                          .candidateprojectStatus ==
                                      1
                                  ? Text(
                                      apiResponseProjectPopulate.data[index]
                                              .candidateprojectStartdate +
                                          "-" +
                                          apiResponseProjectPopulate
                                              .data[index]
                                              .candidateprojectEnddate,
                                      overflow: TextOverflow.ellipsis,
                                      style:  TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 13.5,
                                      ),
                                    )
                                  : Text(
                                      apiResponseProjectPopulate.data[index]
                                          .candidateprojectStartdate,
                                      overflow: TextOverflow.ellipsis,
                                      style:  TextStyle(
                                        fontFamily: "ProximaNova",
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.5,
                                        fontSize: 13.5,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                focusColor: Colors.blueGrey,
                                onTap: () => launch(apiResponseProjectPopulate
                                    .data[index].candidateprojectWeblink),
                                child: Text(
                                  apiResponseProjectPopulate
                                      .data[index].candidateprojectWeblink,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontFamily: "ProximaNova",
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate
                                    .data[index].candidateprojectDesc,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate
                                    .data[index].projectLocation,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate
                                    .data[index].candidateprojectSite,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate.data[index]
                                    .candidateprojectEmploymenttypeId,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate
                                    .data[index].candidateprojectTeamsize,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate.data[index]
                                    .candidateprojectRoledescription,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                apiResponseProjectPopulate
                                    .data[index].candidateprojectSkillsused,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "ProximaNova",
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ]),
              );
            },
          );
  }

  Widget CertificationGrid(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: apiResponseCertificationPopulate.data.length,
      crossAxisSpacing: 5,
      mainAxisSpacing: 6,
      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xff3e61ed))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      apiResponseCertificationPopulate
                              .data[index].candidatecertificationName ??
                          "",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Certification(
                                      uuid: apiResponseCertificationPopulate
                                          .data[index]
                                          .candidatecertificationUuid,
                                    ))).then((value) => getCertification());
                      },
                      child: const Icon(Icons.edit, color: KColors.primary))
                ],
              ),
              Text(
                apiResponseCertificationPopulate
                        .data[index].candidatecertificationCertificationid ??
                    "",
                style: const TextStyle(
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 13.5,
                ),
              ),
              InkWell(
                focusColor: Colors.blueGrey,
                onTap: () => launch(apiResponseCertificationPopulate
                    .data[index].candidatecertificationWeblink),
                child: Text(
                  apiResponseCertificationPopulate
                          .data[index].candidatecertificationWeblink ??
                      "",
                  style: TextStyle(
                    fontFamily: "ProximaNova",
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 12.5,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: "Issued By:",
                    style: const TextStyle(
                      fontFamily: "ProximaNova",
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      fontSize: 12.5,
                    ),
                    children: [
                      TextSpan(
                        text: apiResponseCertificationPopulate
                                .data[index].candidatecertificationIssuedby ??
                            "",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: "ProximaNova",
                          color:Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                          fontSize: 11.5,
                        ),
                      ),
                    ]),
              ),
              RichText(
                text: TextSpan(
                  text: "Issued Date:",
                  style: const TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 12.5,
                  ),
                  children: [
                    TextSpan(
                      text: apiResponseCertificationPopulate
                              .data[index].candidatecertificationIssuedate
                              .toString()
                              .split(" ")[0] ??
                          "",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "Validity:",
                  style: const TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 12.5,
                  ),
                  children: [
                    TextSpan(
                      text: apiResponseCertificationPopulate
                              .data[index].candidatecertificationExpirydate
                              .toString()
                              .split(" ")[0] ??
                          "",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget awardsList(BuildContext context) {
    // final orientation = MediaQuery.of(context).orientation;
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _apiResponseAwards.data.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xff3e61ed))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _apiResponseAwards.data[index].candidateawardTitle,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAwards(
                                uuid:
                                _apiResponseAwards.data[index].candidateawardUuid,
                              ))).then((value) => getAwards());
                    },
                          child: const Icon(Icons.edit, color: KColors.primary),

                  )

                ],
              ),
              InkWell(
                onTap: () => launch(
                  _apiResponseAwards.data[index].candidateawardWeblink ??
                      "2 years",
                ),
                child: Text(
                  _apiResponseAwards.data[index].candidateawardWeblink ??
                      "2 years",
                  style: const TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 13,
                  ),
                ),
              ),
              Text(
                _apiResponseAwards.data[index].candidateawardDate ??
                    "2 years",
                style: const TextStyle(
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 13,
                ),
              ),
              Text(
                _apiResponseAwards.data[index].candidateawardDesc ??
                    "2 years",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color:Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget researchList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(
        height: 5,
      ),
      itemCount: apiResponseResearchPopulate.data.length,
      itemBuilder: (_, index) {
        return Container(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xff3e61ed))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          apiResponseResearchPopulate
                              .data[index].candidatepaperTitle,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: "ProximaNova",
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Research(
                                  uuid: apiResponseResearchPopulate
                                      .data[index].candidatepaperUuid,
                                ))).then((value) => getResearch());
                      },

                      child:
                      const Icon(Icons.edit, color: KColors.primary)),



                ],
              ),
              InkWell(
                onTap: () => launch(apiResponseResearchPopulate
                        .data[index].candidatepaperWeblink ??
                    "2 years"),
                child: Text(
                  apiResponseResearchPopulate
                          .data[index].candidatepaperWeblink ??
                      "2 years",
                  style: const TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    fontSize: 13.5,
                  ),
                ),
              ),
              Text(
                apiResponseResearchPopulate
                        .data[index].candidatepaperPublisheddate ??
                    "2 years",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 12.5,
                ),
              ),
              Text(
                apiResponseResearchPopulate.data[index].candidatepaperDesc ??
                    "2 years",
                style: TextStyle(
                  fontFamily: "ProximaNova",
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the Controllers when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
}
