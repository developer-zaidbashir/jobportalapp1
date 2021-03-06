

import 'Connect.dart';

class ApiUrls extends Connect {
  static String kgetOTP = Connect.AppURL() + "generate-otp";
  static String kverifyOTP = Connect.AppURL() + "validate-otp";
  static String ktitles = Connect.AppURL() + "populate/title";
  static String kgender = Connect.AppURL() + "populate/gender";
  static String kPassingYear = Connect.AppURL() + "populate/year";
  static String kGradingSystem = Connect.AppURL() + "populate/grading-system";
  static String kShift = Connect.AppURL() + "populate/shift";
  static String kjobrole = Connect.AppURL() + "populate/jobrole?query=";
  static String kHighestQualification =
      Connect.AppURL() + "populate/qualification?query=";
  static String kCourse = Connect.AppURL() + "populate/course?query=";
  static String kStream = Connect.AppURL() + "populate/stream?query=";
  static String kindustry = Connect.AppURL() + "populate/industry?query=";
  static String kcompany = Connect.AppURL() + "populate/organization?query=";
  static String kNationality = Connect.AppURL() + "populate/nationality?query=";
  static String kCity = Connect.AppURL() + "populate/city?query=";
  static String kCountry = Connect.AppURL() + "populate/country?query=";
  static String kCaste = Connect.AppURL() + "populate/reservedcategory";
  static String kMarital = Connect.AppURL() + "populate/marital-status";
  static String kInstitute = Connect.AppURL() + "populate/institute?query=";
  static String kItskill = Connect.AppURL() + "populate/itskill?query=";
  static String kLocation = Connect.AppURL() + "populate/city?query=";

  static String kEmpType = Connect.AppURL() + "populate/employmenttype";
  static String kJobType = Connect.AppURL() + "populate/jobtype";
  static String kKeySkills = Connect.AppURL() + "populate/keyskill?query=";
  static String kGetprofileNoticePeriod = Connect.AppURL() + "populate/notice";
  static String kGetJobList =
      "http://192.168.0.20:9030/jobportal-app/test/job-list";
  static String kGetItSkill = Connect.AppURL() + "candidate/itskill-list";

  static String kLogin = Connect.AppURL() + "jwt/login";
  static String kItSkillAdd = Connect.AppURL() + "candidate/itskill-add";
  static String kItSkillUpdate = Connect.AppURL() + "candidate/itskill-add";
  static String kItSkillDelete = Connect.AppURL() + "candidate/itskill-add";
  static String kGetQualificationPop =
      Connect.AppURL() + "candidate/qualification-list";
  static String kGetPersonalPop =
      Connect.AppURL() + "candidate/personaldetail-list";
  static String kPersonalUpdate =
      Connect.AppURL() + "candidate/personaldetail-add";
  static String kItSkillUpdatePop =
      Connect.AppURL() + "candidate/itskill-populate?input=";
  static String kQualificationUpdate =
      Connect.AppURL() + "candidate/qualification-add";
  static String kPopulateLanguage =
      Connect.AppURL() + "candidate/language-list";
  static String kPopulatePatent = Connect.AppURL() + "candidate/patent-list";
  static String kDropLanguages = Connect.AppURL() + "populate/language?query=";
  static String kDropProfeciency =
      Connect.AppURL() + "populate/proficiency?query=";
  static String kpopulatecareerpreferenceprofile =
      Connect.AppURL() + "candidate/careerpreference-list";
  static String kAddLanguage = Connect.AppURL() + "candidate/language-add";

  static String kGetBasicInfoPop =
      Connect.AppURL() + "candidate/basicdetail-list";
  static String kGetProfessionalPop = Connect.AppURL() + "candidate/professional-list";
  static String kkeySkillsProfile =
      Connect.AppURL() + "candidate/keyskill-list";
  static String kLanguageUpdPop =
      Connect.AppURL() + "candidate/language-populate?input=";
  static String kPatentAdd = Connect.AppURL() + "candidate/patent-add";
  static String kPatentUpdPOP =
      Connect.AppURL() + "candidate/patent-populate?input=";
  static String kPopulateAwards = Connect.AppURL() + "candidate/award-list";
  static String kAddAwards = Connect.AppURL() + "candidate/award-add";
  static String kUpdateBasicInfo =
      Connect.AppURL() + "candidate/basicdetail-update";
  static String kProjectUpdatePop =
      Connect.AppURL() + "candidate/project-populate?input=";
  static String kAwardsUpdPOP =
      Connect.AppURL() + "candidate/award-populate?input=";
  static String kProfessionalAdd =
      Connect.AppURL() + "candidate/professional-add";
  static String kAddDeleteKeySkills =
      Connect.AppURL() + "candidate/keyskill-add";
  static String kCareerUpdate =
      Connect.AppURL() + "candidate/careerpreference-add";
  static String kUpdateprofessionprofile =
      Connect.AppURL() + "candidate/professional-add";
  static String kProfessionalDelete =
      Connect.AppURL() + "candidate/professional-add";
  static String kSignOut = Connect.AppURL() + "jwt/logout?token=";
  static String kProjectPopulate = Connect.AppURL() + "candidate/project-list";
  static String kParticularProfessionalUpdate =
      Connect.AppURL() + "candidate/professional-populate?input=";
  static String kProjectAdd = Connect.AppURL() + "candidate/project-add";
  static String kCertificationAdd =
      Connect.AppURL() + "candidate/certification-add";
  static String kCertfUpdatePop =
      Connect.AppURL() + "candidate/certification-populate?input=";
  static String kCertificationPopulate =
      Connect.AppURL() + "candidate/certification-list";
  static String kPopulateSummary =
      Connect.AppURL() + "candidate/profilesummary-list";
  static String kSummaryAdd =
      Connect.AppURL() + "candidate/profilesummary-update";
  static String kPresentationPopulate =
      Connect.AppURL() + "candidate/presentation-list";
  static String kPresentationAdd =
      Connect.AppURL() + "candidate/presentation-add";
  static String kResearchPaperList = Connect.AppURL() + "candidate/paper-list";
  static String kResearchPaperAdd = Connect.AppURL() + "candidate/paper-add";
  static String kResearchPaperUpdPop =
      Connect.AppURL() + "candidate/paper-populate?input=";
static String kPresentationParticular =Connect.AppURL() + "candidate/presentation-populate?input=";

  //testing
  static String kPreference =
      Connect.AppURL() + "candidate-registration/step3-careerpreference";
  static String kpostSkill =
      Connect.AppURL() + "candidate-registration/step6-keyskill";
  static String kItSkill =
      Connect.AppURL() + "candidate-registration/step7-itskill";
  static String kQualify =
      Connect.AppURL() + "candidate-registration/step5-qualificationdetail";
  static String kBasicDetial =
      Connect.AppURL() + "candidate-registration/step2-basicdetail";
  static String kProfession =
      Connect.AppURL() + "candidate-registration/step4-professionaldetail";
  static String kPersonal =
      Connect.AppURL() + "candidate-registration/step8-personaldetail";
  static String kBoardDrop = Connect.AppURL() + "populate/board?query=";
  static String kSchoolMedium = Connect.AppURL() + "populate/schoolmedium?query=";
  static String kUploadProfilePicture = Connect.AppURL() + "candidate-registration/upload-img";
  static String kItSkillPop = Connect.AppURL() + "candidate/itskill-populate?input=";
  static String kQualPop = Connect.AppURL() + "candidate/qualification-populate?input=";
  static String kresponseFromServer = Connect.AppURL() + "populate/notice";
  static String kUploadResume =
      Connect.AppURL() + "candidate/candidate-resume?requestType=add";
  static String kProfileGetBasicInfoPop = Connect.AppURL() + "candidate/basicdetail-list";
  static String kJobList = Connect.AppURL() + "home/job-list";
  static String kJobSaved = Connect.AppURL() + "home/job-saved";
  static String kJobApplied = Connect.AppURL() + "home/job-applied";
  static String kJobDesc = Connect.AppURL() + "home/job-description";
  static String kJobSuggestion = Connect.AppURL() + "home/job-suggestion";
  static String kJobDelete = Connect.AppURL() + "home/removesaved-job/";
  static String kJobApply = Connect.AppURL() + "home/job-apply/";
  static String kJobSave = Connect.AppURL() + "home/job-save/";
  static String kChangePassword = Connect.AppURL() + "candidate/change-password";
  static String kCompanyList = Connect.AppURL() + "home/company-list";
  static String kCompaniesFetch = Connect.AppURL() + "populate/company?query=";
  static String kOwnership = Connect.AppURL() + "populate/ownershiptype";
  static String kcompanyDesc = Connect.AppURL() + "home/company-profile?uuid=";
  static String kGetLogo = Connect.AppURL() + "home/thumbnail?img=";
  static String kgetImageOfUser = Connect.AppURL() +
      "home/thumbnail?img=cand_65d0fa52-e625-455e-851b-f9306cc6235b.jpg&width=150";

}
