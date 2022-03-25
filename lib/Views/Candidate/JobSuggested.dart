import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/JobList.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Theme/colors.dart';

import 'JobApply.dart';

class SuggestedJobUi extends StatefulWidget {
  const SuggestedJobUi({Key key}) : super(key: key);

  @override
  State<SuggestedJobUi> createState() => _SuggestedJobUiState();
}

class _SuggestedJobUiState extends State<SuggestedJobUi> {
  ApiResponse apiResponse;
  List<dynamic> obj;


  bool isLoading = false;
  ApiServices apiService = ApiServices();

  getData() async {
    setState(() {
      isLoading = true;
    });
    apiResponse = await apiService.suggestedJobs();
    obj = apiResponse.data;
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
        ? const Center(child: CircularProgressIndicator())
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
            children: const [
              Text("Suggested Jobs",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
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
                                          style: const TextStyle(
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                            fontSize: 14.5,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Text(
                                          obj[i]["companyName"],
                                          style: const TextStyle(
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
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xff3e61ed),
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    obj[i]["cities"],
                                    style: const TextStyle(
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
                                  const Icon(
                                    Icons.work_outline_outlined,
                                    color: Color(0xff3e61ed),
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    obj[i]["jobtypeName"] +
                                        "/" +
                                        obj[i]["employmenttypeName"],
                                    style: const TextStyle(
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
                                  const Icon(
                                    Icons.attach_money,
                                    color: Color(0xff3e61ed),
                                    size: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    obj[i]["jobMinSalary"] +
                                        "/" +
                                        obj[i]["jobMaxSalary"],
                                    style: const TextStyle(
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
                                      const Icon(
                                        Icons.visibility_off_outlined,
                                        color: Color(0xff3e61ed),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Text(
                                        "Hide",
                                        style: TextStyle(
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5,
                                          fontSize: 12.5,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      const Icon(
                                        Icons.bookmark,
                                        color: Color(0xff3e61ed),
                                      ),
                                      const SizedBox(
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
                                        child: const Text("Saved",
                                          style: TextStyle(
                                            fontFamily: "ProximaNova",
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.5,
                                            fontSize: 12.5,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
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
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(
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
