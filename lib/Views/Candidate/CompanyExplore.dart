import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:job_portal/Data_Controller/apiresponse.dart';
import 'package:job_portal/Models/CompaniesFetch.dart';
import 'package:job_portal/Models/CompanyList.dart';
import 'package:job_portal/Models/CompanyOwnership.dart';
import 'package:job_portal/Models/CurerntLocation.dart';
import 'package:job_portal/Models/GetCompany.dart';
import 'package:job_portal/Models/Location.dart';
import 'package:job_portal/Services/ApiServices.dart';

import 'CompanyUi.dart';


class ExploreCompanies extends StatefulWidget {
  const ExploreCompanies({Key key}) : super(key: key);

  @override
  _ExploreCompaniesState createState() => _ExploreCompaniesState();
}

class _ExploreCompaniesState extends State<ExploreCompanies> {


  TextEditingController titleDesc = TextEditingController();
  TextEditingController myController = TextEditingController();

  //general variables
  Ownership owner;
  String cityID = "";
  bool  isLoading = false;
  bool  isLoadingCompany = false;
  bool  isLoadingLocation = false;
  ApiServices apiServices = ApiServices();
  ApiResponse<List<CompanyFetch>> _apiResponseCompany;
  ApiResponse<List<CurrentLocation>> _apiResponseCurrentLocation;
  ApiResponse<List<Ownership>> _apiResponseOwnership;

  List<String> parseData() {
    List<CompanyFetch> category = _apiResponseCompany.data;
    List<String> dataItems = [];
    for (int i = 0; i < category.length; i++) {
      dataItems.add(category[i].titleDesc);
    }
    return dataItems;
  }

  fetchOwnership() async {
    setState(() {
      isLoading = true;
    });
    _apiResponseOwnership = await apiServices.getOwnership();
    setState(() {
      isLoading = false;
    });
  }
  @override
  void initState() {
    fetchOwnership();
    super.initState();
  }

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
                  children:  [
                    Text(
                      "Search Companies.",
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
              padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 8.0,),
                    child: TypeAheadFormField(

                      textFieldConfiguration:
                      TextFieldConfiguration(
                          controller:
                              titleDesc,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                              labelText: 'Job title ,keywords ,company',
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

                          )
                      ),
                      debounceDuration:
                      Duration(milliseconds: 500),
                      suggestionsCallback:
                      ApiServices.getCompaniesFetch,
                      itemBuilder:
                          (context, CompanyFetch suggestions) {
                        final skillorganization = suggestions;
                        return ListTile(
                          title: Text(skillorganization.titleDesc),
                        );
                      },
                      noItemsFoundBuilder: (context) =>
                          Text(""),
                      onSuggestionSelected:
                          (CompanyFetch suggesstion) {
                        titleDesc.text =
                            suggesstion.titleDesc;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: TypeAheadFormField(
                      // validator: (input) {
                      //   if (input.isEmpty) {
                      //     return "Select Current Location";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: myController,
                          decoration: const InputDecoration(
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

                          )
                      ),

                      debounceDuration: Duration(milliseconds: 500),
                      suggestionsCallback: ApiServices.getCurrentLoc,
                      itemBuilder: (context, CurrentLocation suggestions) {
                        final skill = suggestions;
                        return ListTile(
                          title: Text(skill.cityName),
                        );
                      },
                      noItemsFoundBuilder: (context) => Text(""),
                      onSuggestionSelected: (CurrentLocation suggesstion) {

                        myController.text = suggesstion.cityName;
                        cityID = suggesstion.cityId;
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // DropdownButtonFormField<Ownership>(
                  //   decoration: const InputDecoration(
                  //     contentPadding: EdgeInsets.all(0.0),
                  //     labelText: 'Ownership type',
                  //     labelStyle: TextStyle(
                  //       color: Colors.blueGrey,
                  //       fontFamily: "ProximaNova",
                  //       fontWeight: FontWeight.w500,
                  //       letterSpacing: 1.5,
                  //       fontSize: 13.5,
                  //     ),
                  //     floatingLabelStyle: TextStyle(
                  //       color: Color(0xff3e61ed),
                  //       fontFamily: "ProximaNova",
                  //       fontWeight: FontWeight.bold,
                  //       // letterSpacing: 1.5,
                  //       fontSize: 17.5,
                  //     ),
                  //
                  //   ) ,
                  //
                  //   value: owner,
                  //   onChanged: (Ownership newValue) {
                  //     setState(() {
                  //       owner = newValue;
                  //     });
                  //   },
                  //
                  //   items: _apiResponseOwnership.data.map((Ownership user) {
                  //     return DropdownMenuItem<Ownership>(
                  //       value: user,
                  //       child: Text(
                  //         user.ownershipName,
                  //         style: const TextStyle(color: Colors.black),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                  SizedBox(
                    height: 20,
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20,top: 20,bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GFButton(
                      color: const Color(0xff3e61ed),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
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
                        final result = await apiServices.companyList(insert);

                        setState(() {
                          isLoading = false;
                        });
                        if(result.data != null){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CompanyListUi()));
                        }
                      },
                      child: const Text("Search Companies",style:TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.bold,
                    // letterSpacing: 1.5,
                    fontSize: 13.5,
                  ),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
