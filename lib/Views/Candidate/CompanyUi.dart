import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:job_portal/Controllers/menucontroller.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/CompanyList.dart';
import 'package:job_portal/Models/JobList.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Theme/colors.dart';
import 'package:job_portal/Views/Home/screens/NetworkHandler.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CompanyApply.dart';
import 'JobApply.dart';
import 'Sidebar.dart';

class CompanyListUi extends StatefulWidget {
  const CompanyListUi({Key key}) : super(key: key);

  @override
  State<CompanyListUi> createState() => _CompanyListUiState();
}

class _CompanyListUiState extends State<CompanyListUi> {
  NetworkHandler network = NetworkHandler();
ApiServices apiServices = ApiServices();
  ApiResponse apiResponse;
  List<dynamic> obj;
  bool isLoading = false;

  final insert = CompanyList(
      location:"",
      keyword: "",
      strOrderBy:"companyId",
      recPerPage:"6",
      companySize:"",
      companyOwnershipId:"",
      companyId:"",
      minYear:"",
      maxYear:"",
      establishedYear:"",
      companyTypeId:"",
    sort:"ASC",

  );

  getData()async{
    setState(() {
      isLoading = true;
    });

    apiResponse = await apiServices.companyList(insert);
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
    return isLoading ? Center(child:CircularProgressIndicator(
    )):SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KColors.background,
          iconTheme: const IconThemeData(color:Colors.black),
          elevation: 1,
          title:    Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Company List.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
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

        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10, top: 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    for (var i = 0; i < obj.length; i++)

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(

                          elevation: 5,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 5, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [


                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:  [
                                            Text(obj[i]["companyName"],
                                              style: TextStyle(
                                                fontFamily: "ProximaNova",
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5,
                                                fontSize: 14.5,
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 30,
                                        height: 30,
                                        child:
                                         CircleAvatar(
                                           radius: 20,
                                           backgroundImage:network.getImage("comp_afd046de-0261-48c6-a590-f0714b288640.png") ,
                                         )
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: Row(
                                    children:  [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Color(0xff3e61ed),
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        obj[i]["companyLocation"],
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
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: Row(
                                    children:  [
                                      FaIcon
                                        (

                                        FontAwesomeIcons.industry,
                                        color: Color(0xff3e61ed),
                                        size: 20,

                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        obj[i]["companyIndustryName"],
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
                                  padding: const EdgeInsets.only(left: 10, top: 10),
                                  child: Row(
                                    children:  [
                                      Icon(
                                        Icons.category_outlined,
                                        color: Color(0xff3e61ed),
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        obj[i]["companycategories"] ,
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
                                  padding: const EdgeInsets.only(left: 10, top: 10),
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
                                        obj[i]["companyHeadline"],
                                        style: TextStyle(
                                          fontFamily: "ProximaNova",
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.5,
                                          fontSize: 11.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Since" ,
                                            style: TextStyle(
                                              color: Color(0xff3e61ed),
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.5,
                                              fontSize: 12.5,
                                            ),
                                          ),
                                          SizedBox(
                                            width:4
                                          ),
                                          Text(
                                            obj[i]["companyEstablishedyear"] ,
                                            style: TextStyle(


                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 13.5,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Row(
                                        children:  [
                                          Icon(
                                            Icons.visibility_off_outlined,
                                            color: Color(0xff3e61ed),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Hide",
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 12.5,
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
                                          Text(
                                            "Saved",
                                            style: TextStyle(
                                              fontFamily: "ProximaNova",
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.5,
                                              fontSize: 12.5,
                                            ),
                                          ),
                                          SizedBox(
                                            width:10,
                                          ),
                                          GFButton(text: "View",
                                            shape: GFButtonShape.pills,
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>CompanyDetailPage( uuid: obj[i][
                                                  "companyUuid"])));
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
                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}