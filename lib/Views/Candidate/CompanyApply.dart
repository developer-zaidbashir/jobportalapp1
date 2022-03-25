import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';

import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Theme/colors.dart';
import 'package:job_portal/Theme/images.dart';
import 'package:job_portal/Utility/Connect.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetailPage extends StatefulWidget {
  CompanyDetailPage({Key key, this.uuid}) : super(key: key);
  String uuid;
  @override
  _CompanyDetailPageState createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage> {

  List<dynamic> obj;
  bool isLoading = false;
  bool isLoadingLogo = false;
  ApiResponse apiResponse;
  ApiResponse<dynamic> apiResponseGetLogo;
  ApiServices apiService = ApiServices();
  var logo;
  getIcons()async{
    setState(() {
      isLoadingLogo = true;
    });
    logo = await secureStorage.read(key: "companyLogo");
    apiResponseGetLogo = await apiService.getLogos(logo);
    await secureStorage.delete(key:"companyLogo");
    print(apiResponseGetLogo.responseCode);
    print(logo);
    setState(() {
      isLoadingLogo = false;
    });
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await apiService.companyDesc(widget.uuid);
    obj = apiResponse.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getIcons();
    getData();
    super.initState();
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(Connect().convertStringToUint8List(str: apiResponseGetLogo.data)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )??
                      CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.home),),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obj[0]["companyName"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: KColors.title,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff3e61ed),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            obj[0]["companyLocation"],
                            style: TextStyle(
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.industry,
                            color: Color(0xff3e61ed),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            obj[0]["industryName"],
                            style: TextStyle(
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category_outlined,
                            color: Color(0xff3e61ed),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            obj[0]["companycategories"],
                            style: TextStyle(
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.link,
                            color: Color(0xff3e61ed),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            focusColor: Colors.blueGrey,
                            onTap: () => launch("https   www.doodle.com"),
                            child: Text(
                              obj[0]["companyWebsite"],
                              style: TextStyle(
                                fontFamily: "ProximaNova",
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.view_headline_outlined,
                            color: Color(0xff3e61ed),
                            size: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            obj[0]["companyHeadline"],
                            style: TextStyle(
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 5, top: 10, right: 25),
                      child: Row(
                        children: [
                          Text(
                            "Since",
                            style: TextStyle(
                              color: Color(0xff3e61ed),
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 12.5,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            obj[0]["companyEstablishedyear"],
                            style: TextStyle(
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Divider(
            color: KColors.icon,
            height: 25,
          )
        ],
      ),
    );
  }
  // Widget _tabbar(BuildContext context){
  //   return Container(
  //     child: TabBar(
  //
  //       tabs: [
  //          Tab(text: "Outline",),
  //         Tab(text:"Jobs")
  //       ],
  //     ),
  //   );
  // }

  Widget _aboutCompany(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "About Company",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                obj[0]["companyProfile"],
                style: TextStyle(fontSize: 14, color: KColors.subtitle),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    child: const Text("read more",
                        style: TextStyle(fontSize: 14, color: KColors.primary)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _companyCEO(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Company CEO",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    obj[0]["companyLogo"],
                  ),
                ),
                title: Text(
                  obj[0]["companyCeo"],
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "Chief Executive Officer at Google since 2009 ",
                  style: TextStyle(fontSize: 12.5, color: KColors.subtitle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _companyDetails(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Company Details",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Company Address',
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        obj[0]["companyAddress"],
                        style: TextStyle(fontSize: 14, color: KColors.subtitle),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Company Pin',
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        obj[0]["companyPin"],
                        style: TextStyle(fontSize: 14, color: KColors.subtitle),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'No of employees',
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        obj[0]["employeeCountName"],
                        style: TextStyle(fontSize: 14, color: KColors.subtitle),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Total Branches',
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        obj[0]["companyTotalBranches"],
                        style: TextStyle(fontSize: 14, color: KColors.subtitle),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColors.background,
          iconTheme: const IconThemeData(color: KColors.primary),
          elevation: 1,

          // actions: [
          //   IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {})
          // ],
        ),
        floatingActionButton: SpeedDial(
            tooltip: "Social links",
            direction: SpeedDialDirection.down,
            child: const Icon(Icons.link),
            children: [
              SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: FaIcon(
                    FontAwesomeIcons.linkedinIn,
                    color: Color(0xff3e61ed),
                    size: 20,
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateStudent()));
                  }),
              SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Color(0xff3e61ed),
                    size: 20,
                  ),
                  onTap: () {}),
              SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Color(0xff3e61ed),
                    size: 20,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => obj[0]["companyFacebook"]));
                  }),
              SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: Color(0xff3e61ed),
                    size: 20,
                  ),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateStudent()));
                  }),
            ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context),
                      // _tabbar(context),
                      _aboutCompany(context),
                      SizedBox(
                        height: 20,
                      ),
                      _companyCEO(context),
                      SizedBox(
                        height: 20,
                      ),
                      _companyDetails(context),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Jobs in Google",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
