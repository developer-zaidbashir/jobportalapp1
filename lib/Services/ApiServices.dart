import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:job_portal/Models/Awards.dart';
import 'package:job_portal/Models/BasicDetailsParticularPopulate.dart';
import 'package:job_portal/Models/BasicInfoPopulate.dart';
import 'package:job_portal/Models/Boards.dart';
import 'package:job_portal/Models/CareerPreferencePopulate.dart';
import 'package:job_portal/Models/CareerPreferencePost.dart';
import 'package:job_portal/Models/Certification-Add.dart';
import 'package:job_portal/Models/CertificationPopulate.dart';
import 'package:job_portal/Models/ChangePassword.dart';
import 'package:job_portal/Models/CompaniesFetch.dart';
import 'package:job_portal/Models/CompanyList.dart';
import 'package:job_portal/Models/CompanyOwnership.dart';
import 'package:job_portal/Models/Country.dart';
import 'package:job_portal/Models/CurerntLocation.dart';
import 'package:job_portal/Models/EmploymentType.dart';
import 'package:job_portal/Models/GetCategory.dart';
import 'package:job_portal/Models/GetCompany.dart';
import 'package:job_portal/Models/GetIndustry.dart';
import 'package:job_portal/Models/GetJobList.dart';
import 'package:job_portal/Models/GetMarital.dart';
import 'package:job_portal/Models/InstituteQualified.dart';
import 'package:job_portal/Models/ItSkillAdd.dart';
import 'package:job_portal/Models/ItSkillRetrive.dart';
import 'package:job_portal/Models/ItSkills.dart';
import 'package:job_portal/Models/ItSkillsPost.dart';
import 'package:job_portal/Models/JobList.dart';
import 'package:job_portal/Models/JobType.dart';
import 'package:job_portal/Models/Language-Populate.dart';
import 'package:job_portal/Models/Languages.dart';
import 'package:job_portal/Models/KeySkillAddProfile.dart';
import 'package:job_portal/Models/KeySkillDeleteProfile.dart';
import 'package:job_portal/Models/KeySkillProfilePopulate.dart';
import 'package:job_portal/Models/LanguagesAdd.dart';
import 'package:job_portal/Models/Login.dart';
import 'package:job_portal/Models/Nationality.dart';
import 'package:job_portal/Models/Patent-Populate.dart';
import 'package:job_portal/Models/PatentAdd.dart';
import 'package:job_portal/Models/PersonalDetails-post.dart';
import 'package:job_portal/Models/PersonalDetailsRetrive.dart';
import 'package:job_portal/Models/PostProfessionRegistration.dart';
import 'package:job_portal/Models/PresentaionAdd.dart';
import 'package:job_portal/Models/Presentation-Populate.dart';
import 'package:job_portal/Models/ProfessionDetailsPost.dart';
import 'package:job_portal/Models/ProfessionalPopulate.dart';
import 'package:job_portal/Models/Profiecency.dart';
import 'package:job_portal/Models/ProfileGetNoticePeriod.dart';
import 'package:job_portal/Models/ProfileSummaryPopulate.dart';
import 'package:job_portal/Models/ProjectPopulate.dart';
import 'package:job_portal/Models/QualificationDetails.dart';
import 'package:job_portal/Models/QualificationPopulate.dart';
import 'package:job_portal/Models/Researchpaper.dart';
import 'package:job_portal/Models/SavedJobs.dart';


import 'package:job_portal/Models/SchoolMedium.dart';
import 'package:job_portal/Models/ShowDataLogin.dart';
import 'package:job_portal/Models/Stream.dart';
import 'package:job_portal/Models/BasicDetailsPost.dart';
import 'package:job_portal/Models/JobRole.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/CareerProfileUpdate.dart';
import 'package:job_portal/Models/getgender.dart';
import 'package:job_portal/Models/GetOtp.dart';
import 'package:job_portal/Models/GetShift.dart';
import 'package:job_portal/Models/GetTitle.dart';
import 'package:job_portal/Models/GradingSystem.dart';
import 'package:job_portal/Models/PassingYear.dart';
import 'package:job_portal/Models/VerifyOtp.dart';
import 'package:job_portal/Models/keyskill.dart';
import 'package:job_portal/Models/location.dart';
import 'package:job_portal/Models/postkeyskills.dart';
import 'package:job_portal/Models/qualification-post.dart';
import 'package:job_portal/Utility/Connect.dart';
import 'package:job_portal/Utility/apiurls.dart';
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String signOutToken = "";
FlutterSecureStorage secureStorage = FlutterSecureStorage();

class ApiServices {
  var log = Logger();

  String key = "";

  Future<ApiResponse<dynamic>> otpGet(
      {GetOTP objGetOtp, String countryCode}) async {
    final url = Uri.parse(ApiUrls.kgetOTP);
    final headers = {
      "Content-Type": "application/json",
    };
    final jsonData =
        jsonEncode({"registerMobile": "+91-" + objGetOtp.registerMobile});
    final response = await http.post(url, headers: headers, body: jsonData);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final dynamic data = jsonData;
      print(data);
      return ApiResponse<dynamic>(
          data: data, error: false, responseCode: response.statusCode);
    }
    if (response.statusCode == 400) {
      final jsonData = jsonDecode(response.body);
      final dynamic data = jsonData;
      print(data);
      return ApiResponse<dynamic>(
          data: data, error: true, responseCode: response.statusCode);
    }
    return ApiResponse<dynamic>(
        error: true,
        errorMessage: "Failed to Receive the OTP, Please try Again");
  }

  Future<ApiResponse<String>> otpVerifyGet(OTPVerify objOtpVerify) async {
    print("======" + objOtpVerify.otp + "======");
    final url = Uri.parse(ApiUrls.kverifyOTP + "/" + objOtpVerify.otp);
    final headers = {
      "Content-Type": "application/json",
    };
    final jsonData =
        jsonEncode({"registerMobile": "+91-${objOtpVerify.registerMobile}"});
    final response = await http.post(url, headers: headers, body: jsonData);
    if (response.statusCode == 200) {
      print(response.body);
      print("In Progress...");
      return ApiResponse<String>(
          data: response.body, responseCode: response.statusCode, error: false);
    }
    if (response.statusCode == 400) {
      print(response.body);
      print("In Progress...");
      return ApiResponse<String>(
          data: response.body, responseCode: response.statusCode, error: true);
    }
    return ApiResponse<String>(error: true, errorMessage: "An Error Occurred");
  }

  // industry in Professional details page

  Future<ApiResponse<List<Industry>>> getIndustry({String query}) async {
    final url = Uri.parse(ApiUrls.kindustry + query);
    print(ApiUrls.kindustry + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Industry>[];
      for (var item in jsonData) {
        list.add(Industry.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<Industry>>(data: list);
    }
    return ApiResponse<List<Industry>>(
        error: true, errorMessage: "An error occurred");
  }
  Future<ApiResponse<List<GetTitle>>> getTitle() async {
    final url = Uri.parse(ApiUrls.ktitles);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <GetTitle>[];
      for (var item in jsonData) {
        list.add(GetTitle.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<GetTitle>>(data: list);
    }
    return ApiResponse<List<GetTitle>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<GetGender>>> getGender() async {
    final url = Uri.parse(ApiUrls.kgender);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <GetGender>[];
      for (var item in jsonData) {
        list.add(GetGender.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<GetGender>>(data: list);
    }
    return ApiResponse<List<GetGender>>(
        error: true, errorMessage: "An error occurred");
  }

  static Future<List<Boards>> getBoards(String query) async {
    final url = Uri.parse(ApiUrls.kBoardDrop + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Boards.fromJson(json)).where((data) {
        final nameLower = data.boardName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  static Future<List<Medium>> getMedium(String query) async {
    final url = Uri.parse(ApiUrls.kSchoolMedium + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Medium.fromJson(json)).where((data) {
        final nameLower = data.schoolmediumName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  // PASSING YEAR DROPDOWN IN Qualification PAGE
  Future<ApiResponse<List<PassingYear>>> getPassingYear() async {
    final url = Uri.parse(ApiUrls.kPassingYear);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <PassingYear>[];
      for (var item in jsonData) {
        list.add(PassingYear.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<PassingYear>>(data: list);
    }
    return ApiResponse<List<PassingYear>>(
        error: true, errorMessage: "An error occurred");
  }

  // GRADING DROPDOWN IN Qualification PAGE
  Future<ApiResponse<List<GradingSystem>>> getGradingSystem() async {
    final url = Uri.parse(ApiUrls.kGradingSystem);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <GradingSystem>[];
      for (var item in jsonData) {
        list.add(GradingSystem.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<GradingSystem>>(data: list);
    }
    return ApiResponse<List<GradingSystem>>(
        error: true, errorMessage: "An error occurred");
  }

  // PREFERRED SHIFT IN CAREER PREFERENCES//
  Future<ApiResponse<List<PreferredShift>>> getShift() async {
    final url = Uri.parse(ApiUrls.kShift);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <PreferredShift>[];
      for (var item in jsonData) {
        list.add(PreferredShift.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<PreferredShift>>(data: list);
    }
    return ApiResponse<List<PreferredShift>>(error: true, errorMessage: "An error occurred");
  }

  //Get Job Category

  Future<ApiResponse<List<JobCategory>>> getJobCategory({String query}) async {
    final url = Uri.parse(ApiUrls.kjobrole + query);
    print(ApiUrls.kjobrole + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <JobCategory>[];
      for (var item in jsonData) {
        list.add(JobCategory.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<JobCategory>>(data: list);
    }
    return ApiResponse<List<JobCategory>>(
        error: true, errorMessage: "An error occurred");
  }

  //Get Highest Qualification

  static Future<List<Qualification>> getQualification(String query) async {
    final url = Uri.parse(ApiUrls.kHighestQualification + query);
    print(ApiUrls.kHighestQualification + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Qualification.fromJson(json)).where((data) {
        final nameLower = data.qualName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERROR");
    }
  }

  //Get Course

  static Future<List<Qualification>> getCourse(String query) async {
    final url = Uri.parse(ApiUrls.kCourse + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Qualification.fromJson(json)).where((data) {
        final nameLower = data.courseName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  //Get Course

  static Future<List<Streams>> getStream(String query) async {
    final url = Uri.parse(ApiUrls.kStream + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Streams.fromJson(json)).where((data) {
        final nameLower = data.streamName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  // JOB TYPE

  Future<ApiResponse<List<JobType>>> getjobType() async {
    final url = Uri.parse(ApiUrls.kJobType);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <JobType>[];
      for (var item in jsonData) {
        list.add(JobType.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<JobType>>(data: list);
    }
    return ApiResponse<List<JobType>>(
        error: true, errorMessage: "An error occurred");
  }

  // EMPLOYMENT
  Future<ApiResponse<List<EmploymentType>>> getEmploymentType() async {
    final url = Uri.parse(ApiUrls.kEmpType);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <EmploymentType>[];
      for (var item in jsonData) {
        list.add(EmploymentType.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<EmploymentType>>(data: list);
    }
    return ApiResponse<List<EmploymentType>>(
        error: true, errorMessage: "An error occurred");
  }

  //  Nationality Dropdown

  Future<ApiResponse<List<Nationality>>> getNationality({String query}) async {
    final url = Uri.parse(ApiUrls.kNationality + query);
    print(ApiUrls.kNationality + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Nationality>[];
      for (var item in jsonData) {
        list.add(Nationality.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<Nationality>>(data: list);
    }
    return ApiResponse<List<Nationality>>(
        error: true, errorMessage: "An error occurred");
  }

  //  City Dropdown
  Future<ApiResponse<bool>> basicinfoUpdate(
      BasicDetialModel basicUpdate) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kUpdateBasicInfo);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(basicUpdate);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<List<Map<String, String>>>> keySkillDeleteProfile(
      {KeySkillDeleteProfile obj}) async {
    dynamic authToken = await secureStorage.read(key: "token");

    log.i(obj.requestType);
    log.i(obj.candidatekeyskillUuid);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode([
      {
        "requestType": "delete",
        "candidatekeyskillUuid": obj.candidatekeyskillUuid
      }
    ]);
    var response = await http.post(Uri.parse(ApiUrls.kAddDeleteKeySkills),
        headers: headers, body: jsonData);
    log.i("Printing Response Here.....");
    print(response.body);
    print(response.statusCode);
    List<Map<String, String>> data = jsonDecode(response.body);
    if (response.statusCode == 202) {
      print("Successfully deleted...");
      return ApiResponse<List<Map<String, String>>>(data: data);
    }
    return ApiResponse<List<Map<String, String>>>(
        error: true, errorMessage: "An error occurred");
  }

  static Future<List<Company>> getCompany(String query) async {
    final url = Uri.parse(ApiUrls.kcompany + query);
    print(ApiUrls.kcompany + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Company.fromJson(json)).where((data) {
        final nameLower = data.organizationName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  Future<ApiResponse<List<Cities>>> getCity({String query}) async {
    final url = Uri.parse(ApiUrls.kCity + query);
    print(url);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Cities>[];
      for (var item in jsonData) {
        list.add(Cities.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<Cities>>(data: list);
    }
    return ApiResponse<List<Cities>>(
        error: true, errorMessage: "An error occurred");
  }

  //  Country

  Future<ApiResponse<List<Country>>> getCountry({String query}) async {
    final url = Uri.parse(ApiUrls.kCountry + query);
    print(ApiUrls.kCountry + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Country>[];
      for (var item in jsonData) {
        list.add(Country.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<Country>>(data: list);
    }
    return ApiResponse<List<Country>>(
        error: true, errorMessage: "An error occurred");
  }

  // CASTE
  Future<ApiResponse<List<Category>>> getCaste() async {
    final url = Uri.parse(ApiUrls.kCaste);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Category>[];
      for (var item in jsonData) {
        list.add(Category.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<Category>>(data: list);
    }
    return ApiResponse<List<Category>>(
        error: true, errorMessage: "An error occurred");
  }

  // MARITAL

  Future<ApiResponse<List<Marital>>> getMarital() async {
    final url = Uri.parse(ApiUrls.kMarital);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Marital>[];
      for (var item in jsonData) {
        list.add(Marital.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<Marital>>(data: list);
    }
    return ApiResponse<List<Marital>>(
        error: true, errorMessage: "An error occurred");
  }

  static Future<List<Institute>> getInstitute(String query) async {
    final url = Uri.parse(ApiUrls.kInstitute + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Institute.fromJson(json)).where((data) {
        final nameLower = data.instituteName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  // IT skills
  Future<ApiResponse<List<ITSkill>>> getITSkill({String query}) async {
    final url = Uri.parse(ApiUrls.kItskill + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <ITSkill>[];
      for (var item in jsonData) {
        list.add(ITSkill.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<ITSkill>>(data: list);
    }
    return ApiResponse<List<ITSkill>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<bool>> PostQualification(
      {QualificationPost qualifi}) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kQualify);

    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(qualifi);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 200) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> ItSkillsPost(PostItSkills skill) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kItSkill);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(skill);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 200) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  //CURRENT LOCATION STARTS HERE>.
  Future<ApiResponse<List<CurrentLocation>>> getCurrentLocation(
      {String query}) async {
    final url = Uri.parse(ApiUrls.kLocation + query);
    print(ApiUrls.kLocation + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <CurrentLocation>[];
      for (var item in jsonData) {
        list.add(CurrentLocation.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<CurrentLocation>>(data: list);
    }
    return ApiResponse<List<CurrentLocation>>(
        error: true, errorMessage: "An error occurred");
  }

  static Future<List<CurrentLocation>> getCurrentLoc(String query) async {
    final url = Uri.parse(ApiUrls.kLocation + query);
    print(ApiUrls.kLocation + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData
          .map((json) => CurrentLocation.fromJson(json))
          .where((data) {
        final nameLower = data.cityName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  Future<ApiResponse<Map<String, dynamic>>> postBasicDetials(
      BasicDetialModel obj) async {
    final url = Uri.parse(ApiUrls.kBasicDetial);
    final header = {
      "Content-Type": "application/json",
    };
    final jsonData = jsonEncode({
      "candidateTitleId": obj.candidateTitleId,
      "candidateMobile1": obj.candidateMobile1,
      "candidateFirstName": obj.candidateFirstName,
      "candidateMiddleName": obj.candidateMiddleName,
      "candidateLastName": obj.candidateLastName,
      "candidateEmail1": obj.candidateEmail1,
      "candidateGenderId": obj.candidateGenderId,
      "candidateTotalworkexp": obj.candidateTotalworkexp,
      // "candidateName": obj.candidateName,
      "candidatePreferredJobRoleList": obj.candidatePreferredJobRoleList,
      "candidateCurrentCityId": obj.candidateCurrentCityId,
    });
    final response = await http.post(
      url,
      headers: header,
      body: jsonData,
    );
    if (response.statusCode == 401) {
      log.i("Full Authentication is Required...");
      return ApiResponse<Map<String, dynamic>>(
          data: {}, responseCode: response.statusCode, error: true);
    }
    if (response.statusCode == 400) {
      log.i("Server didn't Process Request...");
      return ApiResponse<Map<String, dynamic>>(
          data: jsonDecode(response.body),
          responseCode: response.statusCode,
          error: true);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      print(data["candidateName"]);
      print(data["token"]);
      await secureStorage.write(
          key: "candidateName", value: data["candidateName"]);
      await secureStorage.write(key: "token", value: data["token"]);
      log.i(data);
      log.i(response.statusCode);

      return ApiResponse<Map<String, dynamic>>(
          data: data, responseCode: response.statusCode);
    }
    return ApiResponse<Map<String, dynamic>>(
        error: false,
        errorMessage: "Something went wrong, please try again...",
        responseCode: response.statusCode);
  }

  // career preference POST
  Future<ApiResponse<bool>> postPreference({
    CareerPreferencePost preference,
  }) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPreference);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode({
      // "candidatequalUuid": preference.candidateUuid,
      "candidateIndustryIdsList": preference.candidateIndustryIdsList,
      "candidateJobtypeIdsList": preference.candidateJobtypeIdsList,
      "candidateEmploymenttypeIdsList":
          preference.candidateEmploymenttypeIdsList,
      "candidatePreferredCityIdsList": preference.candidatePreferredCityIdsList,
      "candidateExpectedctc": preference.candidateExpectedctc,
      "candidateShiftId": preference.candidateShiftId,
      "candidateJoinimmediate": "1"
      // preference
    });

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Map<String,dynamic> data = jsonDecode(response.body);
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  // personal details post
  Future<ApiResponse<bool>> PostPersonal(PersonalDetailsPost personal) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPersonal);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(personal);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  // PROFESSIONPAGE STARTS HERE
  Future<ApiResponse<bool>> ProfessionPost(
      PostProfessionRegistration profes) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kProfession);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(profes);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  //Post Key Skills
  //===============

  Future<ApiResponse<bool>> postSkills(List<PostKeySkills> lst) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kpostSkill);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(lst);
    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: jsonDecode(response.body));
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  // KeySkills
  Future<ApiResponse<List<KeySkills>>> getSkills({String query}) async {
    final url = Uri.parse(ApiUrls.kKeySkills + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <KeySkills>[];
      for (var item in jsonData) {
        list.add(KeySkills.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<KeySkills>>(data: list);
    }
    return ApiResponse<List<KeySkills>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<GetJobList>>> getJobList() async {
    final url = Uri.parse(ApiUrls.kGetJobList);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = jsonData["listData"];
      final listData = <GetJobList>[];
      for (var item in list) {
        listData.add(GetJobList.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<GetJobList>>(data: listData);
    }
    return ApiResponse<List<GetJobList>>(
        error: true, errorMessage: "An error occurred");
  }

//populate professional
  //Populate Professional
  Future<ApiResponse<List<ProfessionalPopulate>>>
      ProfessionalDetailsPopulate() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kGetProfessionalPop);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <ProfessionalPopulate>[];
      for (var item in jsonData) {
        list.add(ProfessionalPopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<ProfessionalPopulate>>(data: list);
    }
    return ApiResponse<List<ProfessionalPopulate>>(
        error: true, errorMessage: "An error occurred");
    // }
  }

  // populate Keyskills
  Future<ApiResponse<List<PopulateKeySkillsProfileModel>>>
      getKeySkillsProfile() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kkeySkillsProfile);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <PopulateKeySkillsProfileModel>[];
      for (var item in jsonData) {
        list.add(PopulateKeySkillsProfileModel.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<PopulateKeySkillsProfileModel>>(data: list);
    }
    return ApiResponse<List<PopulateKeySkillsProfileModel>>(
        error: true, errorMessage: "An error occurred");
  }

  // populate career

  Future<ApiResponse<CareerPreferencePopulate>>
      getCareerPreferencePopulate() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kpopulatecareerpreferenceprofile);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      final list = jsonData;
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<CareerPreferencePopulate>(
          data: CareerPreferencePopulate.fromJson(list),
          error: false,
          errorMessage: "Successfully Parsed");
    }
    return ApiResponse<CareerPreferencePopulate>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<ItSkillProfile>>> PopulateItSkill() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kGetItSkill);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <ItSkillProfile>[];
      for (var item in jsonData) {
        list.add(ItSkillProfile.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<ItSkillProfile>>(data: list);
    }
    return ApiResponse<List<ItSkillProfile>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<bool>> itSkillAdd(ItSkillAdd skillAdd) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kItSkillAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(skillAdd);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> itSkillUpdate(ItSkillAdd skillAdd) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kItSkillUpdate);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(skillAdd);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> itSkillDelete(ItSkillAdd skillDelete) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kItSkillDelete);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(skillDelete);
    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  // service for login through JWT
  Future<ApiResponse<ShowDataLogin>> login({Login obj}) async {
    log.i(obj.candidateEmail1);
    log.i(obj.candidatePassword);
    final headers = {
      "Content-Type": "application/json",
    };
    final jsonData = jsonEncode(obj);
    var response = await http.post(Uri.parse(ApiUrls.kLogin),
        headers: headers, body: jsonData);
    ShowDataLogin data = ShowDataLogin.fromJson(jsonDecode(response.body));
    if (response.statusCode == 401) {
      print("Invalid User 401 Unauthorised...");
      return ApiResponse<ShowDataLogin>(responseCode: response.statusCode);
    }
    if (response.statusCode == 200) {
      Map<String, dynamic> output = jsonDecode(response.body);
      print(output["token"]);
      print(output["candidateName"]);
      await secureStorage.write(key: "token", value: output["token"]);
      await secureStorage.write(
          key: "candidateName", value: output["candidateName"]);
      print("Successfully Logged In...");
      return ApiResponse<ShowDataLogin>(
          data: data, responseCode: response.statusCode);
    }
    return ApiResponse<ShowDataLogin>(
        error: true,
        errorMessage: "An error occurred",
        responseCode: response.statusCode);
  }

  //basicinfo populate
  Future<ApiResponse<BasicInfoPopulate>> PopulateBasicInfo() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kGetBasicInfoPop);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      final list = jsonData;
      await secureStorage.write(key: "candidateProfileStrength", value: list["candidateProfileStrength"]);
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<BasicInfoPopulate>(data: BasicInfoPopulate.fromJson(list), error: false, errorMessage: "Successfully Parsed");
    }
    return ApiResponse<BasicInfoPopulate>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<QualificationPopulate>>>
      PopulateQualification() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kGetQualificationPop);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <QualificationPopulate>[];
      for (var item in jsonData) {
        list.add(QualificationPopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<QualificationPopulate>>(data: list);
    }
    return ApiResponse<List<QualificationPopulate>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<PersonalRetrive>>> PopulatePersonal() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kGetPersonalPop);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <PersonalRetrive>[];
      for (var item in jsonData) {
        list.add(PersonalRetrive.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<PersonalRetrive>>(data: list);
    }
    return ApiResponse<List<PersonalRetrive>>(
        error: true, errorMessage: "An error occurred");
  }

  // GET PARTICULAT STUDENT
  Future<ApiResponse<ItSkillProfile>> populateItSkillUpdate(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kItSkillPop + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<ItSkillProfile>(
          data: ItSkillProfile.fromJson(jsonData));
    }
    return ApiResponse<ItSkillProfile>(
        error: true, errorMessage: "An Error Occurred");
  }

  //update career preference
  Future<ApiResponse<bool>> careerpreferenceUpdate(
      CareerProfileUpdate preference) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kCareerUpdate);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode({
      "candidateIndustryIdsList": preference.candidateIndustryIdsList,
      "candidateJobtypeIdsList": preference.candidateJobtypeIdsList,
      "candidateEmploymenttypeIdsList":
          preference.candidateEmploymenttypeIdsList,
      "candidatePreferredCityIdsList": preference.candidatePreferredCityIdsList,
      "candidateExpectedctc": preference.candidateExpectedctc,
      "candidateShiftId": preference.candidateShiftId,
    });

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  // personal update
  Future<ApiResponse<bool>> personalUpdate(PersonalDetailsPost skillAdd) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPersonalUpdate);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(skillAdd);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 202) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> qualificationAdd(QualificationPost quall) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kQualificationUpdate);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(quall);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<QualificationPopulate>> populateQualificationUpdate(
      String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kQualPop + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<QualificationPopulate>(
          data: QualificationPopulate.fromJson(jsonData));
    }
    return ApiResponse<QualificationPopulate>(
        error: true, errorMessage: "An Error Occurred");
  }

// project populate
  Future<ApiResponse<List<ProjectPopulate>>> PopulateProject() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kProjectPopulate);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <ProjectPopulate>[];
      for (var item in jsonData) {
        list.add(ProjectPopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<ProjectPopulate>>(data: list);
    }
    return ApiResponse<List<ProjectPopulate>>(
        error: true, errorMessage: "An error occurred");
  }

  // certification populate
  Future<ApiResponse<List<CertificationPopulate>>>
      PopulateCertification() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kCertificationPopulate);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <CertificationPopulate>[];
      for (var item in jsonData) {
        list.add(CertificationPopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<CertificationPopulate>>(data: list);
    }
    return ApiResponse<List<CertificationPopulate>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<LanguagePopulate>>> PopulateLanguage() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPopulateLanguage);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <LanguagePopulate>[];
      for (var item in jsonData) {
        list.add(LanguagePopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<LanguagePopulate>>(data: list);
    }
    return ApiResponse<List<LanguagePopulate>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<PatentPopulate>>> PopulatePatent() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPopulatePatent);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <PatentPopulate>[];
      for (var item in jsonData) {
        list.add(PatentPopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<PatentPopulate>>(data: list);
    }
    return ApiResponse<List<PatentPopulate>>(
        error: true, errorMessage: "An error occurred");
  }

  static Future<List<Languages>> getLanguages(String query) async {
    final url = Uri.parse(ApiUrls.kDropLanguages + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Languages.fromJson(json)).where((data) {
        final nameLower = data.languageName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  static Future<List<Proficiency>> getProficiency(String query) async {
    final url = Uri.parse(ApiUrls.kDropProfeciency + query);
    print(ApiUrls.kItskill + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Proficiency.fromJson(json)).where((data) {
        final nameLower = data.proficiencyName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  Future<ApiResponse<List<GetProfileNoticePeriod>>>
      getprofNoticeperiod() async {
    final url = Uri.parse(ApiUrls.kGetprofileNoticePeriod);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <GetProfileNoticePeriod>[];
      for (var item in jsonData) {
        list.add(GetProfileNoticePeriod.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<GetProfileNoticePeriod>>(data: list);
    }
    return ApiResponse<List<GetProfileNoticePeriod>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<bool>> languagesAdd(LanguagesAddModel lang) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kAddLanguage);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(lang);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<LanguagePopulate>> populateLanguageUpdate(
      String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kLanguageUpdPop + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<LanguagePopulate>(
          data: LanguagePopulate.fromJson(jsonData));
    }
    return ApiResponse<LanguagePopulate>(
        error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> profileProfessionDelete(
      PostProfession professionDelete) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kProfessionalDelete);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(professionDelete);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<String>> signOut() async {
    dynamic authToken = await secureStorage.read(key: "token");

    var parsedUrl = Uri.parse(ApiUrls.kSignOut + signOutToken);
    // log.i(jwtTokenLogin);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    var response = await http.get(parsedUrl);
    if (response.statusCode == 200) {
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<String>(
          data: response.body, responseCode: response.statusCode);
    }
    return ApiResponse<String>(
        error: true,
        errorMessage: "An error occurred",
        responseCode: response.statusCode);
  }

  Future<ApiResponse<bool>> patentsAdd(AddPatent patent) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPatentAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(patent);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> patentsDelete(AddPatent patent) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPatentAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode({
      "requestType": patent.requestType,
      "candidatepatentUuid": patent.candidatepatentUuid,
    });

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<PatentPopulate>> populatePatentUpdate(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPatentUpdPOP + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<PatentPopulate>(
          data: PatentPopulate.fromJson(jsonData));
    }
    return ApiResponse<PatentPopulate>(
        error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<List<Awards>>> populateAwards() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPopulateAwards);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Awards>[];
      for (var item in jsonData) {
        list.add(Awards.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<Awards>>(data: list);
    }
    return ApiResponse<List<Awards>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<bool>> awardsAdd(Awards adwards) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kAddAwards);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(adwards);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<Awards>> populateAwardsUpdate(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kAwardsUpdPOP + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<Awards>(data: Awards.fromJson(jsonData));
    }
    return ApiResponse<Awards>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> projectAdd(ProjectPopulate quall) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kProjectAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(quall);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<ProjectPopulate>> populateProjectUp(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kProjectUpdatePop + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<ProjectPopulate>(
          data: ProjectPopulate.fromJson(jsonData));
    }
    return ApiResponse<ProjectPopulate>(
        error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> certificationAdd(
      CertificationPopulate quall) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kCertificationAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(quall);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<CertificationAdd>> populateCertificationUp(
      String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kCertfUpdatePop + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<CertificationAdd>(
          data: CertificationAdd.fromJson(jsonData));
    }
    print(response.body);
    print(response.statusCode);
    return ApiResponse<CertificationAdd>(
        error: true, errorMessage: "An Error Occurred");
  }

  //populate profile summary
  Future<ApiResponse<List<SummaryPopulate>>> PopulateSummary() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPopulateSummary);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <SummaryPopulate>[];
      for (var item in jsonData) {
        list.add(SummaryPopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<SummaryPopulate>>(data: list);
    }
    return ApiResponse<List<SummaryPopulate>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<Map<String, String>>>> keySkillAddProfile(
      {List<KeySkillAddProfile> lst}) async {
    dynamic authToken = await secureStorage.read(key: "token");

    log.i(lst[0].requestType);
    log.i(lst[0].candidatekeyskillName);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(lst);
    var response = await http.post(Uri.parse(ApiUrls.kAddDeleteKeySkills),
        headers: headers, body: jsonData);
    log.i("Printing Response Here.....");
    print(response.body);
    print(response.statusCode);
    List<Map<String, String>> data = jsonDecode(response.body);
    if (response.statusCode == 202) {
      print("Successfully Added...");
      return ApiResponse<List<Map<String, String>>>(data: data);
    }
    return ApiResponse<List<Map<String, String>>>(
        error: true, errorMessage: "An error occurred");
  }

  //summary add and update
  Future<ApiResponse<bool>> summaryAdd(SummaryPopulate quall) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kSummaryAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(quall);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

//

  // particular update for presenataion starts here
  Future<ApiResponse<PresentationPopulate>>
      populatePresentationParticularUpdate(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPresentationParticular + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<PresentationPopulate>(
          data: PresentationPopulate.fromJson(jsonData));
    }
    return ApiResponse<PresentationPopulate>(
        error: true, errorMessage: "An Error Occurred");
  }

  // PRESENTAION ADD HERE

  Future<ApiResponse<bool>> presentationAddService(
      PresentationAddModel objpresentation) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPresentationAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(objpresentation);
    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

// PRESENTAION ENDS HERE

  // PROFESSIONAL PROFILE ADD STARTS HERE
  Future<ApiResponse<bool>> professionalProfileAdd(PostProfession prof) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kProfessionalAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(prof);

    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  // get particular for profession profile UPDATE

  Future<ApiResponse<ProfessionalPopulate>> populateProfProfessionalUpdate(
      String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kParticularProfessionalUpdate + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<ProfessionalPopulate>(
          data: ProfessionalPopulate.fromJson(jsonData));
    }
    return ApiResponse<ProfessionalPopulate>(
        error: true, errorMessage: "An Error Occurred");
  }

// get particular for profession profile UPDATE ENDS HERE

  Future<ApiResponse<List<PresentationPopulate>>> PopulatePresentation() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kPresentationPopulate);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <PresentationPopulate>[];
      for (var item in jsonData) {
        list.add(PresentationPopulate.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<PresentationPopulate>>(data: list);
    }
    return ApiResponse<List<PresentationPopulate>>(
        error: true, errorMessage: "An error occurred");
  }

  // RESEARCH  PEPER POLULATE
  Future<ApiResponse<List<ResearchpaperAdd>>> researchPopulate() async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kResearchPaperList);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <ResearchpaperAdd>[];
      for (var item in jsonData) {
        list.add(ResearchpaperAdd.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<ResearchpaperAdd>>(data: list);
    }
    return ApiResponse<List<ResearchpaperAdd>>(
        error: true, errorMessage: "An error occurred");
  }

  // RESEARCH PAPER ADD
  Future<ApiResponse<bool>> researchpaperAdd(
      ResearchpaperAdd objresearch) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kResearchPaperAdd);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(objresearch);
    final response = await http.post(url, headers: headers, body: jsonData);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<ResearchpaperAdd>> populateResearchpaperUpdate(
      String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kResearchPaperUpdPop + uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return ApiResponse<ResearchpaperAdd>(
          data: ResearchpaperAdd.fromJson(jsonData));
    }
    return ApiResponse<ResearchpaperAdd>(
        error: true, errorMessage: "An Error Occurred");
  }

  //Profile Picture Upload Service Method
  //=====================================

  Future<ApiResponse<Map<String, String>>> postFile({String text, File file}) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse(ApiUrls.kUploadProfilePicture),
      );
      request.fields["file"] = text;
      var pic = await http.MultipartFile.fromPath(
        "file",
        file.path,
      );
      request.files.add(pic);
      request.headers.addAll(header);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);

      print(responseString);
    } catch (e) {
      throw Exception(
          "Something went wrong while uploading Profile Picture...");
    }
  }

  Future<ApiResponse<BasicParticularPopulate>> PopulateBasicParticular() async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kProfileGetBasicInfoPop);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      final list = jsonData;
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<BasicParticularPopulate>(
          data: BasicParticularPopulate.fromJson(list),
          error: false,
          errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<BasicParticularPopulate>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<dynamic>>> jobList(JobList joblist) async {
    // dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kJobList);
    final header = {
      "Content-Type": "application/json",
      // 'Authorization': "Bearer $authToken",
    };
    final jsonBody = jsonEncode(joblist);
    final response = await http.post(url, headers: header, body: jsonBody);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData["jobList"];
      // for (var c = 0 ;c<data.length;c++) {
      //   print(data[c]["jobHeadline"]);
      // }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<dynamic>>(
          data: data, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<List<dynamic>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<dynamic>>> jobDesc(JobDes jobdec) async {
    // dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kJobDesc);
    final header = {
      "Content-Type": "application/json",
      // 'Authorization': "Bearer $authToken",
    };
    final jsonBody = jsonEncode(jobdec);
    final response = await http.post(
      url,
      headers: header,
      body:jsonBody,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData["jobDescription"];
      await secureStorage.write(key: "companyLogo", value: data[0]["companyLogo"]);
      print(data[0]["careerlevelName"]);
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<dynamic>>(
          data: data, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<List<dynamic>>(
        error: true, errorMessage: "An error occurred");
  }

  // Future<http.StreamedResponse> postFile(String file)async{
  //   dynamic authToken = await secureStorage.read(key: "token");
  //   var headers = {
  //     'Content-Type': 'multipart/form-data',
  //     'Authorization': 'Bearer $authToken'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('http://192.168.0.20:9030/jobportal-app/api/candidate-registration/upload-resume'));
  //   request.files.add(await http.MultipartFile.fromPath('file', file));
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }

  // }

  Future<ApiResponse<bool>> changePassword(ChangePassword password) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kChangePassword);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonData = jsonEncode(password);

    final response = await http.post(url, headers: headers, body: jsonData);
    final data = jsonDecode(response.body);
    await secureStorage.write(key: "msg", value: data["msg"]);
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }
// HOME PAGE SERVICES
//companies populate
  static Future<List<CompanyFetch>> getCompaniesFetch(String query) async {
    final url = Uri.parse(ApiUrls.kCompaniesFetch + query);
    print(ApiUrls.kCompaniesFetch + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => CompanyFetch.fromJson(json)).where((data) {
        final nameLower = data.titleDesc.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }

  // location

  static Future<List<Cities>> getLocationFetch(String query) async {
    final url = Uri.parse(ApiUrls.kCity + query);
    print(ApiUrls.kCity + "=" + query);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Cities.fromJson(json)).where((data) {
        final nameLower = data.cityName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    }
    else {
      throw Exception("ERRORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    }
  }
  Future<ApiResponse<List<dynamic>>> companyList(CompanyList companylist) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kCompanyList);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonBody = jsonEncode(companylist);
    final response = await http.post(url, headers: header, body: jsonBody);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData["companyList"];
      // for (var c = 0 ;c<data.length;c++) {
      //   print(data[c]["jobHeadline"]);
      // }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<dynamic>>(
          data: data, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<List<dynamic>>(error: true, errorMessage: "An error occurred");
  }
  // get ownership
  Future<ApiResponse<List<Ownership>>> getOwnership() async {
    final url = Uri.parse(ApiUrls.kOwnership);
    final header = {
      "Content-Type": "application/json",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final list = <Ownership>[];
      for (var item in jsonData) {
        list.add(Ownership.fromJson(item));
      }
      log.i(response.body);
      log.i(response.statusCode);
      print(list);
      return ApiResponse<List<Ownership>>(data: list);
    }
    return ApiResponse<List<Ownership>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<bool>> jobApply(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kJobApply + uuid);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.post(
      url,
      headers: headers,
    );
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> output = jsonDecode(response.body);
      print(output["message"]);
      await secureStorage.write(key: "message", value: output["message"]);

      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }

  Future<ApiResponse<bool>> jobSave(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");

    final url = Uri.parse(ApiUrls.kJobSave + uuid);
    final headers = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.post(
      url,
      headers: headers,
    );
    log.i(response.body);
    log.i(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> output = jsonDecode(response.body);
      print(output["message"]);
      await secureStorage.write(key: "message", value: output["message"]);

      return ApiResponse<bool>(data: true);
    }
    return ApiResponse<bool>(error: true, errorMessage: "An Error Occurred");
  }



  Future<ApiResponse<List<dynamic>>> savedJobs(SavedJob savedJob) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kJobSaved);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonBody = jsonEncode(savedJob);
    final response = await http.post(url, headers: header, body: jsonBody);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData["savedJobList"];

      // for (var c = 0 ;c<data.length;c++) {
      //   print(data[c]["jobHeadline"]);
      // }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<dynamic>>(
          data: data, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<List<dynamic>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<dynamic>>> appliedJobs(SavedJob savedJob) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kJobApplied);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final jsonBody = jsonEncode(savedJob);
    final response = await http.post(url, headers: header, body: jsonBody);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData["appliedJobList"];
      // for (var c = 0 ;c<data.length;c++) {
      //   print(data[c]["jobHeadline"]);
      // }
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<dynamic>>(
          data: data, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<List<dynamic>>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<List<dynamic>>> suggestedJobs() async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kJobSuggestion);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.post(url, headers: header, );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData["jobList"];
      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<dynamic>>(
          data: data, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<List<dynamic>>(
        error: true, errorMessage: "An error occurred");
  }


  Future<ApiResponse<List<dynamic>>> companyDesc(String uuid) async {
    // dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kcompanyDesc+ uuid);
    final header = {
      "Content-Type": "application/json",
      // 'Authorization': "Bearer $authToken",
    };
    final response = await http.get(
      url,
      headers: header,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData["companyProfile"];
      await secureStorage.write(key: "companyLogo", value: data[0]["companyLogo"]);
      print(data[0]["companyProfile"]);

      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<List<dynamic>>(
          data: data, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<List<dynamic>>(
        error: true, errorMessage: "An error occurred");
  }



  Future<ApiResponse<bool>> deleteJobs(String uuid) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kJobDelete+uuid);
    final header = {
      "Content-Type": "application/json",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.post(url, headers: header, );
    if (response.statusCode == 200) {
     final  jsonData = jsonDecode(response.body);
     await secureStorage.write(key: "message", value: jsonData["message"]);

      log.i(response.body);
      log.i(response.statusCode);
      return ApiResponse<bool>(data: true, error: false, errorMessage: "Data Successfully Parsed");
    }
    return ApiResponse<bool>(
        error: true, errorMessage: "An error occurred");
  }

  Future<ApiResponse<dynamic>> getLogos(String img) async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kGetLogo+img);
    print(url);
    print(url);
    print("-----------------");
    final header = {
      // "Content-Type": "multipart/form-data",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = response.body;
      log.i(jsonData);
      return ApiResponse<dynamic>(data: jsonData,responseCode: response.statusCode,error: false,errorMessage: "Logo Fetched Succssfully");
    }
    return ApiResponse<dynamic>(data: null,responseCode: response.statusCode,
        error: true, errorMessage: "An Error Occurred");
  }

  //Profile Picture Upload Service Method
  //=====================================

  Future<ApiResponse<String>> postProfilePicture({String text, File file}) async{
    dynamic authToken = await secureStorage.read(key: "token");
    final header = {
      "Content-Type": "multipart/form-data",
      'Authorization': "Bearer $authToken",
    };
    var request = http.MultipartRequest("POST",Uri.parse(ApiUrls.kUploadProfilePicture),);
    request.fields["file"] = text;
    var pic = await http.MultipartFile.fromPath("file", file.path,);
    request.files.add(pic);
    request.headers.addAll(header);
    var response = await request.send();
    log.i(response.statusCode);
    if(response.statusCode == 200){
      var responseData = await response.stream.toBytes();
      log.i(responseData);
      var responseString = String.fromCharCodes(responseData);
      log.i(responseString);
      return ApiResponse<String>(data: responseString,responseCode: response.statusCode,error: false,);
    }else{
      var responseData = await response.stream.toBytes();
      log.i(responseData);
      var responseString = String.fromCharCodes(responseData);
      log.i(responseString);
      return ApiResponse<String>(data: responseString,responseCode: response.statusCode,error: true);
    }
  }

  // Get Image from API
  // ==================
  Future<ApiResponse<dynamic>> getImageOfUser() async {
    dynamic authToken = await secureStorage.read(key: "token");
    final url = Uri.parse(ApiUrls.kgetImageOfUser);
    final header = {
      // "Content-Type": "multipart/form-data",
      'Authorization': "Bearer $authToken",
    };
    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final jsonData = response.body;
      return ApiResponse<dynamic>(
          data: jsonData,responseCode: response.statusCode,error: false,errorMessage: "Image fetched Successfully...");
    }
    return ApiResponse<dynamic>(data: null,responseCode: response.statusCode,
        error: true, errorMessage: "An Error Occurred");
  }

  //Resume Upload
  //=============

  Future<ApiResponse<Map<String,String>>> postResume({String text,File file}) async{
    dynamic authToken = await secureStorage.read(key: "token");
    final header = {
      "Content-Type": "multipart/form-data",
      'Authorization': "Bearer $authToken",
    };
    try{
      var request = http.MultipartRequest("POST",Uri.parse(ApiUrls.kUploadResume),);
      request.fields["file"] = text;
      var pic = await http.MultipartFile.fromPath("file", file.path,);
      request.files.add(pic);
      request.headers.addAll(header);
      var response = await request.send();
      log.i(response.statusCode);
      if(response.statusCode == 200){
        var responseData = await response.stream.toBytes();
        log.i(responseData);
        var responseString = String.fromCharCodes(responseData);
        log.i(responseString);
        return ApiResponse<Map<String,String>>(data: responseString as Map<String,String>,responseCode: response.statusCode,error: false,);
      }else{
        var responseData = await response.stream.toBytes();
        log.i(responseData);
        var responseString = String.fromCharCodes(responseData);
        log.i(responseString);
        return ApiResponse<Map<String,String>>(data: responseString as Map<String,String>,responseCode: response.statusCode,error: true);
      }
    }catch(e){
      throw Exception("Somethiong went wrong while uploading Resume...");
    }
  }
}
