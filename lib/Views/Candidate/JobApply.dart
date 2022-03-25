import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/JobList.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Theme/colors.dart';
import 'package:job_portal/Theme/images.dart';
import 'package:job_portal/Utility/Connect.dart';

class JobDetailPage extends StatefulWidget {
  JobDetailPage({Key key, this.uuid}) : super(key: key);

  String uuid;

  static Route<T> getJobDetail<T>() {
    return MaterialPageRoute(
      builder: (_) => JobDetailPage(),
    );
  }

  @override
  _JobDetailPageState createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  ApiResponse apiResponse;
  List<dynamic> obj;
  bool isLoading = false;
  ApiServices apiService = ApiServices();



  //
  // dynamic message;
  // getMessage()async{
  //   message = await secureStorage.read(key: "message");
  // }

  var logo;
  bool isLoadingLogo = false;
  ApiResponse<dynamic> apiResponseGetLogo;

getIcons()async{
  setState(() {
    isLoadingLogo = true;
  });
  logo = await secureStorage.read(key: "companyLogo");
  apiResponseGetLogo = await apiService.getLogos(logo);

  print(apiResponseGetLogo.responseCode);
  print(logo);
  setState(() {
    isLoadingLogo = false;
  });
  await secureStorage.delete(key:"companyLogo");

}
  var insert;

  getData() async {
    setState(() {
      isLoading = true;
    });

    apiResponse = await apiService.jobDesc(insert);
    obj = apiResponse.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // getLogo();
    insert = JobDes(jobUuid: widget.uuid);
    getData();
    getIcons();
    // getMessage();
    super.initState();
  }

  Widget _header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 26),
      child: Column(
        children: [
          Row(
            children: [
              isLoadingLogo?Center(child: CircularProgressIndicator(),):  Container(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    obj[0]["jobHeadline"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: KColors.title,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    obj[0]["companyName"],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: KColors.subtitle,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 32),
          // Row(
          //   children: [
          //     _headerStatic("Job-Type", "Full-Time"),
          //     _headerStatic("Applicants", "45"),
          //     _headerStatic("Time", "6 days ago"),
          //   ],
          // ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle_outlined,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["jobEmploymenttypeName"],
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.work_outline_outlined,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["jobJobtypeName"],
                      style: TextStyle(
                          fontFamily: "ProximaNova",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.schedule_outlined,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["shiftName"],
                      style: TextStyle(
                          fontFamily: "ProximaNova",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["cities"],
                      style: TextStyle(
                          fontFamily: "ProximaNova",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Text("Full-Time"),
          //     Text("45 Applicants"),
          //     Text("4 days ago"),
          //     Text("Delhi"),
          //   ],
          // ),
          const Divider(
            color: KColors.icon,
            height: 25,
          )
        ],
      ),
    );
  }

  Widget _multi(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Date Posted",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["jobEntryDate"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.hourglassEnd,

                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Expiration Date",
                      style: TextStyle(
                          fontFamily: "ProximaNova",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["jobExpiryDate"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Job Role",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    FittedBox(
                      child: Text(
                        obj[0]["jobRoleName"],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: KColors.subtitle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(
              //   child: Column(
              //     children: [
              //       Icon(
              //         Icons.schedule_outlined,
              //         color: Color(0xff3e61ed),
              //       ),
              //       SizedBox(
              //         height: 6,
              //       ),
              //       Text(
              //        "",
              //         style: TextStyle(
              //             fontFamily: "ProximaNova",
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       )
              //       SizedBox(
              //         height: 6,
              //       ),
              //       Text(
              //         obj[0]["jobEmploymenttypeName"],
              //         style: TextStyle(
              //           fontFamily: "ProximaNova",
              //           fontSize: 15,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Expanded(
              //   child: Column(
              //     children: [
              //       Icon(
              //         Icons.location_on_outlined,
              //         color: Color(0xff3e61ed),
              //       ),
              //       SizedBox(
              //         height: 6,
              //       ),
              //       Text(
              //         obj[0]["cities"],
              //         style: TextStyle(
              //             fontFamily: "ProximaNova",
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 32),
          // Row(
          //   children: [
          //     _headerStatic("Job-Type", "Full-Time"),
          //     _headerStatic("Applicants", "45"),
          //     _headerStatic("Time", "6 days ago"),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.calendarDay,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Day(s)",
                      style: TextStyle(
                          fontFamily: "ProximaNova",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_circle,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Position",
                      style: TextStyle(
                          fontFamily: "ProximaNova",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["jobEmploymenttypeName"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.database,
                      color: Color(0xff3e61ed),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Career Level",
                      style: TextStyle(
                          fontFamily: "ProximaNova",
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      obj[0]["careerlevelName"],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: KColors.subtitle,
                      ),
                    ),
                  ],
                ),
              ),


            ],

          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Text("Full-Time"),
          //     Text("45 Applicants"),
          //     Text("4 days ago"),
          //     Text("Delhi"),
          //   ],
          // ),
          const Divider(
            color: KColors.icon,
            height: 25,
          )
        ],
      ),
    );
  }

  // Widget _headerStatic(String title, String sub) {
  //   return Expanded(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           title,
  //           style: TextStyle(
  //             fontSize: 12,
  //             fontWeight: FontWeight.w400,
  //             color: KColors.subtitle,
  //           ),
  //         ),
  //         SizedBox(height: 5),
  //         Text(
  //           sub,
  //           style: TextStyle(
  //             fontSize: 14,
  //             fontWeight: FontWeight.bold,
  //             color: KColors.title,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _jobDescription(BuildContext context) {
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
                "Job Description",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                obj[0]["jobDesc"],
                style: TextStyle(fontSize: 14, color: KColors.subtitle),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: const Text("Learn more",
                    style: TextStyle(fontSize: 14, color: KColors.primary)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _WorkingDays(BuildContext context) {
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
                "Working Days",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                "SUN,MON,TUE,WED,THU",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: KColors.subtitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _KeyResponsibilities(BuildContext context) {
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
                "Key Responsibilities",
                style: TextStyle(
                    fontFamily: "ProximaNova",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 6, right: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green),
                child: Row(
                  children: [

                    Text(
                      obj[0]["keyskills"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: "ProximaNova",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _SkillExperience(BuildContext context) {
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
                "Skill & Experience",
                style: TextStyle(
                    fontFamily: "ProximaNova",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                obj[0]["itskills"],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: KColors.subtitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _companyDescription(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Related Jobs",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text("2020 jobs - 292 added today"),
            ],
          ),
        ),
      ),
    );
  }

  //
  // Widget _recruiterDescription(BuildContext context) {
  //   return Container(
  //     width: double.infinity,
  //     child: Card(
  //       elevation: 2,
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Text(
  //               "Recruiters Details",
  //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //             ),
  //             const SizedBox(height: 20),
  //              Text(
  //               obj[0]["recruiterName"],
  //               style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "ProximaNova" ),
  //             ),
  //             const SizedBox(height: 5),
  //              Text(
  //               "Company Recruiter at"+obj[0]["companyName"],
  //               style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "ProximaNova", color: KColors.subtitle),
  //             ),
  //             const SizedBox(height: 5),
  //             const Text(
  //               "Communications Pvt.Ltd",
  //               style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "ProximaNova", color: KColors.subtitle),
  //             ),
  //             const SizedBox(height: 5),
  //             const Text(
  //               "Mumbai",
  //               style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: "ProximaNova", color: KColors.subtitle ),
  //             ),
  //             Row(
  //               children: [
  //                 const Icon(Icons.language_outlined),
  //                     const SizedBox(
  //                       width: 5,
  //                     ),
  //                 TextButton(
  //                   onPressed: () {},
  //                   style: ButtonStyle(
  //                       padding: MaterialStateProperty.all(EdgeInsets.zero)),
  //                   child:  Text(obj[0]["companyWebsite"],
  //                       style: TextStyle(fontSize: 14, color: KColors.primary)),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _ourPeople(BuildContext context) {
  //   return Container(
  //     height: 92,
  //     padding: const EdgeInsets.only(left: 16),
  //     margin: const EdgeInsets.only(top: 30),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         const Text("Our People",
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
  //         const SizedBox(height: 12),
  //         Expanded(
  //           child: ListView(
  //             scrollDirection: Axis.horizontal,
  //             children: [
  //               _people(context, img: Images.user1, name: "J. Smith"),
  //               _people(context, img: Images.user2, name: "L. James"),
  //               _people(context, img: Images.user3, name: "Emma"),
  //               _people(context, img: Images.user4, name: "Mattews"),
  //               _people(context, img: Images.user5, name: "Timothy"),
  //               _people(context, img: Images.user6, name: "Kyole"),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _people(BuildContext context, {String img, String name}) {
    return Container(
      margin: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(img),
          ),
          const SizedBox(height: 8),
          Text(name,
              style: const TextStyle(fontSize: 10, color: KColors.subtitle)),
        ],
      ),
    );
  }

  Widget _apply(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 54),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(KColors.primary),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16))),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                final insert = widget.uuid;
                final result = await apiService.jobApply(insert);
                final message = await secureStorage.read(key: "message");
                setState(() {
                  isLoading = false;
                });

                if (result.data) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                        SnackBar(
                          content: Row(children: [
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(width: 7),
                            Text(message),
                          ]),
                          backgroundColor: Colors.green,
                          duration: const Duration(milliseconds: 1500),
                        ),
                      )
                      .closed
                      .then((reason) async {
                    await secureStorage.delete(key: "message");
                    Navigator.pop(context);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
              },
              child: const Text(
                "Apply Now",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          GestureDetector(
            // onTap: () async {
            //   setState(() {
            //     isLoading = true;
            //   });
            //   final insert = obj[i]["jobUuid"];
            //   final result = await apiService
            //       .jobSave(insert);
            //   final message =
            //   await secureStorage.read(
            //       key: "message");
            //   setState(() {
            //     isLoading = false;
            //   });

            // if (result.data) {
            //   ScaffoldMessenger.of(context)
            //       .showSnackBar(
            //     SnackBar(
            //       content: Row(children: [
            //         const Icon(
            //           Icons.add,
            //           color: Colors.white,
            //         ),
            //         const SizedBox(
            //             width: 7),
            //         Text(message),
            //       ]),
            //       backgroundColor:
            //       Colors.green,
            //       duration:
            //       const Duration(
            //           milliseconds:
            //           1500),
            //     ),
            //   ).closed.then((reason) async {
            //     await secureStorage.delete(
            //         key: "message");
            //     // Navigator.pop(context);
            //   });
            // } else {
            //     ScaffoldMessenger.of(context)
            //         .showSnackBar(SnackBar(
            //       content: Row(children: const [
            //         Icon(
            //           Icons.error_outline,
            //           color: Colors.white,
            //         ),
            //         SizedBox(width: 7),
            //         Text("An Error Occurred.."),
            //       ]),
            //       backgroundColor: Colors.red,
            //       duration: const Duration(
            //           milliseconds: 2500),
            //     ));
            //   }
            // },
            child: Text(
              "Saved",
              style: TextStyle(
                fontFamily: "ProximaNova",
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
                fontSize: 12.5,
              ),
            ),
          ),
          Icon(
            Icons.bookmark,
            color: Color(0xff3e61ed),
          ),
        ],
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
                  onTap: () {  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => obj[0]["companyTwitter"]));}),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => obj[0]["companyInstagram"]));
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
                      _multi(context),
                      _jobDescription(context),
                      _WorkingDays(context),
                      _KeyResponsibilities(context),
                      _SkillExperience(context),

                      const SizedBox(
                        height: 10,
                      ),
                      // _recruiterDescription(context),
                      const SizedBox(
                        height: 10,
                      ),
                      _companyDescription(context),
                      // _ourPeople(context),
                      _apply(context)
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
