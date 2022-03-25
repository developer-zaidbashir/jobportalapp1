import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/JobList.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Theme/colors.dart';

import 'JobApply.dart';

class SavedJobUi extends StatefulWidget {
  const SavedJobUi({Key key}) : super(key: key);

  @override
  State<SavedJobUi> createState() => _SavedJobUiState();
}

class _SavedJobUiState extends State<SavedJobUi> {
  ApiResponse apiResponse;
  List<dynamic> obj;

  final insert = SavedJob(
  sort: ""
  );

  bool isLoading = false;
  ApiServices apiService = ApiServices();
var message ;
  getData() async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await apiService.savedJobs(insert);
    obj = apiResponse.data;
    // message = await secureStorage.read(key: "msg");
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
      child: Scaffold(
        // bottomNavigationBar:  BottomAppBar(
        //   child: Container(
        //     child:
        //   ),
        // ) ,
        appBar: AppBar(
          backgroundColor: KColors.background,
          iconTheme: const IconThemeData(color: KColors.primary),
          elevation: 1,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Saved Jobs",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "(You can select multiple jobs to apply)",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.5,
                  fontSize: 14.5,
                ),
              ),
            ],
          ),
        ),
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
            child: ListView(
              children: [
                for (var i = 0; i < obj.length; i++)
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  JobDetailPage(uuid: obj[i]["jobUuid"])));

                    },
                    child: Card(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(20.0)),
                      elevation: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 5, right: 10),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          obj[i]["jobHeadline"],
                                          style: TextStyle(
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            fontSize: 14.5,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          obj[i]["companyName"],
                                          style: TextStyle(
                                            color: Color(0xff3e61ed),
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            fontSize: 13.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10, top: 10),
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
                                    obj[i]["cities"],
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.work_outline_outlined,
                                    color: Color(0xff3e61ed),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    obj[i]["jobtypeName"] +
                                        "/" +
                                        obj[i]["employmenttypeName"],
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 10, top: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: Color(0xff3e61ed),
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    obj[i]["jobMinSalary"] +
                                        "/" +
                                        obj[i]["jobMaxSalary"],
                                    style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.5,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10, top: 10),
                            //   child: Row(
                            //     children: const [
                            //       Icon(
                            //         Icons.email_outlined,
                            //         color: Color(0xff3e61ed),
                            //         size: 20,
                            //       ),
                            //       SizedBox(
                            //         width: 10,
                            //       ),
                            //       Text(
                            //         "unacadmy@godaddy.com",
                            //         style: TextStyle(
                            //           fontFamily: "ProximaNova",
                            //           fontWeight: FontWeight.w500,
                            //           letterSpacing: 1.5,
                            //           fontSize: 13.5,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "6d ago",
                                    style: TextStyle(
                                      color: Color(0xff3e61ed),
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Color(0xff3e61ed),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () async{
                                          setState(() {
                                            isLoading = true;
                                          });
                                          final insert = obj[i]["jobUuid"];
                                          final result = await apiService.deleteJobs(insert);
                                          final   message = await secureStorage.read(key: "message");
                                          setState(() {
                                            getData();
                                            isLoading = false;
                                          });

                                          if (result.data) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Row(children:  [
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
                                            ).closed.then((reason)async {
                                              await secureStorage.delete(key: "message");


                                              // Navigator.pop(context);
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
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.5,
                                            fontSize: 12.5,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Icon(
                                        Icons.bookmark,
                                        color: Color(0xff3e61ed),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          final insert = obj[i]["jobUuid"];
                                          final result = await apiService
                                              .jobSave(insert);
                                          final message =
                                          await secureStorage.read(
                                              key: "message");
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
                                                  const SizedBox(
                                                      width: 7),
                                                  Text(message),
                                                ]),
                                                backgroundColor:
                                                Colors.green,
                                                duration:
                                                const Duration(
                                                    milliseconds:
                                                    1500),
                                              ),
                                            ).closed.then((reason) async {
                                              await secureStorage.delete(
                                                  key: "message");
                                              // Navigator.pop(context);
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
                                              duration: const Duration(
                                                  milliseconds: 2500),
                                            ));
                                          }
                                        },
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
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GFButton(
                                        text: "Apply",
                                        shape: GFButtonShape.pills,
                                        onPressed: () async{
                                          setState(() {
                                            isLoading = true;
                                          });
                                          final insert = obj[i]["jobUuid"];
                                          final result = await apiService.jobApply(insert);
                                          final   message = await secureStorage.read(key: "message");
                                          setState(() {
                                            isLoading = false;
                                          });

                                          if (result.data) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Row(children:  [
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
                                            ).closed.then((reason)async {
                                              await secureStorage.delete(key: "message");
                                              // Navigator.pop(context);
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

                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  // borderRadius: BorderRadius.vertical(
                  //   top: Radius.circular(20.0),
                  // ),
                ),
                child: Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 20,
                            // width: 20,
                            // padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: KColors.primary)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  "WFH",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 20,
                            // width: 20,
                            // padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: KColors.primary)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,

                                ),
                                child: Text(
                                  "Latest",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 20,
                            // width: 20,
                            // padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: KColors.primary)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,

                                ),
                                child: Text(
                                  "Location",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 20,
                            // width: 20,
                            // padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: KColors.primary)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,

                                ),
                                child: Text(
                                  "Experience",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 20,
                            // width: 20,
                            // padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: KColors.primary)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,

                                ),
                                child: Text(
                                  "Industries",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 20,
                            // width: 20,
                            // padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: KColors.primary)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,

                                ),
                                child: Text(
                                  "Company",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 20,
                            // width: 20,
                            // padding: EdgeInsets.only(top:5,bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: KColors.primary)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,

                                ),
                                child: Text(
                                  "Salary",
                                  style: TextStyle(
                                      fontFamily: "ProximaNova",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
