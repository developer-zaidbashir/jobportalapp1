import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/JobList.dart';
import 'package:job_portal/Services/ApiServices.dart';

import 'JobList.dart';

class ExploreJobs extends StatefulWidget {
  const ExploreJobs({Key key}) : super(key: key);

  @override
  _ExploreJobsState createState() => _ExploreJobsState();
}

class _ExploreJobsState extends State<ExploreJobs> {
  ApiServices apiService = ApiServices();
  bool isLoading = false;

  TextEditingController jobCont = TextEditingController();
  TextEditingController compCont = TextEditingController();
  TextEditingController locCont = TextEditingController();

  ApiResponse apiResponse;
  List<dynamic> obj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back)),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Search Jobs.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                          // fontFamily: "ProximaNova",

                          // letterSpacing: 1.5,
                          // fontSize: 18.5,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      "assets/accent.png",
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Column(
                children: [
                  TextFormField(
                    controller: jobCont,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Skills, Designation, Job Type',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 13.5,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xff3e61ed),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: compCont,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Companies',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 13.5,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xff3e61ed),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: compCont,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      labelText: 'Location',
                      labelStyle: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5,
                        fontSize: 13.5,
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xff3e61ed),
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GFButton(
                    color: const Color(0xff3e61ed),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final insert = JobList(
                        strOrderBy: "jobId",
                        recPerPage: "10",
                        pageIndex: "1",
                        employementTypeIdsList: "",
                        jobTypeIdIdsList: "",
                      );
                      final result = await apiService.jobList(insert);

                      setState(() {
                        isLoading = false;
                      });
                      if (result.data != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobListUi()));
                      }
                    },
                    child: const Text(
                      "Search Jobs",
                      style: TextStyle(
                        fontFamily: "ProximaNova",
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 1.5,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(obj["data"][]),
          ],
        ),
      ),
    );
  }
}
