import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_portal/Services/ApiServices.dart';
import 'package:job_portal/Views/Candidate/BottomNavbar.dart';
import 'package:job_portal/Views/Candidate/test.dart';
import 'package:job_portal/Views/Profile/Profile.dart';
import 'package:job_portal/Views/Candidate/Settings.dart';
import 'package:job_portal/Views/Candidate/JobSuggested.dart';
import 'package:job_portal/Views/Home/constants/Constants.dart';
import 'package:job_portal/Views/SignIn/SignIn.dart';
import 'package:job_portal/Views/SignIn/Step8-PersonalDetails.dart';
import 'CompanyExplore.dart';
import 'JobApplied.dart';
import 'JobSearch.dart';
import 'SavedJobs.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String test = "info";

  @override
  initState() {
    getUserName();
    super.initState();
  }

  bool loadUser;

  dynamic username;

  getUserName() async {
    setState(() {
      loadUser = true;
    });
    username = await secureStorage.read(key: "candidateName");
    setState(() {
      loadUser = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FadeInDown(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 100,
                child: DrawerHeader(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: 30.0,
                      child: Image.network("https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-%EC%83%98%ED%94%8C-%EC%A7%80-%EB%B9%A8%EA%B0%84%EC%83%89-%EB%9D%BC%EC%9A%B4%EB%93%9C-%EC%8A%A4%ED%83%AC%ED%94%84.jpg"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            username,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontFamily: "ProximaNova",
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 14.5,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfilePage()));
                            },
                            child: const Text(
                              "Update Profile",
                              style: TextStyle(
                                color: Color(0xff3e61ed),
                                fontFamily: "ProximaNova",
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 9.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ),
            ),

            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Home",
                  svgSrc: Icons.home_work_outlined,
                  press: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Navbar()),
                        (route) => false);
                  },
                ),
              ),
            ),
            FadeInRightBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: ExpansionTile(
                title: DrawerListTile(
                  title: "My Profile",
                  svgSrc:
                  Icons.account_circle_outlined,

                  press: () {},
                ),
                children: <Widget>[
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                        title: "Basic Information",
                        svgSrc: Icons.feed_outlined,
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilePage(basic: test)));
                        },
                      ),
                    ),
                  ),
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                        title: "Career Preference",
                        svgSrc: Icons.location_on_outlined,
                        press: () {},
                      ),
                    ),
                  ),
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                        title: "Professional Details",
                        svgSrc: Icons.school_outlined,
                        press: () {},
                      ),
                    ),
                  ),
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                        title: "Qualification Details",
                        svgSrc: Icons.psychology_outlined,
                        press: () {},
                      ),
                    ),
                  ),
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                        title: "Key Skills",
                        svgSrc: Icons.translate_outlined,
                        press: () {},
                      ),
                    ),
                  ),
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                        title: "IT Skills",
                        svgSrc: Icons.stacked_bar_chart_outlined,
                        press: () {},
                      ),
                    ),
                  ),
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: DrawerListTile(
                        title: "Personal Details",
                        svgSrc: Icons.bookmark_border_outlined,
                        press: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const SavedJobs()));
                        },
                      ),
                    ),
                  ),
                  FadeInRightBig(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 500),
                    child: ExpansionTile(
                      title: DrawerListTile(
                        title: "Achievements",
                        svgSrc: Icons.update_outlined,
                        press: () {},
                      ),
                      children: [
                        FadeInRightBig(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DrawerListTile(
                              title: "Awards",
                              svgSrc: Icons.feed_outlined,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(basic: test)));
                              },
                            ),
                          ),
                        ),
                        FadeInRightBig(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DrawerListTile(
                              title: "Projects",
                              svgSrc: Icons.feed_outlined,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(basic: test)));
                              },
                            ),
                          ),
                        ),
                        FadeInRightBig(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DrawerListTile(
                              title: "Certifications",
                              svgSrc: Icons.feed_outlined,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(basic: test)));
                              },
                            ),
                          ),
                        ),
                        FadeInRightBig(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DrawerListTile(
                              title: "Presentations",
                              svgSrc: Icons.feed_outlined,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(basic: test)));
                              },
                            ),
                          ),
                        ),
                        FadeInRightBig(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DrawerListTile(
                              title: "Patents",
                              svgSrc: Icons.feed_outlined,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(basic: test)));
                              },
                            ),
                          ),
                        ),
                        FadeInRightBig(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DrawerListTile(
                              title: "Research Publication",
                              svgSrc: Icons.feed_outlined,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(basic: test)));
                              },
                            ),
                          ),
                        ),
                        FadeInRightBig(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: DrawerListTile(
                              title: "Languages",
                              svgSrc: Icons.feed_outlined,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfilePage(basic: test)));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Suggested Jobs",
                  svgSrc: Icons.work_outline_outlined,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SuggestedJobUi()));
                  },
                ),
              ),
            ),
            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Applied Jobs",
                  svgSrc: Icons.send_outlined,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppliedJobsUi()));
                  },
                ),
              ),
            ),
            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Saved Jobs",
                  svgSrc: Icons.save,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SavedJobUi()));
                  },
                ),
              ),
            ),
            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Shortlisted Jobs",
                  svgSrc:Icons.summarize_outlined,

                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExploreCompanies()));
                  },
                ),
              ),
            ),
            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Search Jobs",
                  svgSrc: Icons.search,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExploreJobs()));
                  },
                ),
              ),
            ),


            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Search Companies",
                  svgSrc: Icons.search,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExploreCompanies()));
                  },
                ),
              ),
            ),

            FadeInDownBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: const Divider(
                color: Colors.grey,
                thickness: 0.8,
                indent: 8.0,
                endIndent: 8.0,
              ),
            ),
            FadeInRightBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "E-Learning",
                  svgSrc: Icons.menu_book_outlined,
                  press: () {},
                ),
              ),
            ),
            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Chat for help",
                  svgSrc: Icons.question_answer_outlined,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyApptest()));
                  },
                ),
              ),
            ),
            FadeInRightBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Settings",
                  svgSrc: Icons.manage_accounts_outlined,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()));
                  },
                ),
              ),
            ),
            FadeInLeftBig(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: DrawerListTile(
                  title: "Sign out",
                  svgSrc: Icons.logout_outlined,
                  press: () async {
                    await secureStorage.deleteAll();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    this.title,
    this.svgSrc,
    this.press,
  }) : super(key: key);

  final String title;
  final IconData svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        svgSrc,
        color: const Color(0xff3e61ed),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: Constants.OPEN_SANS,
          fontWeight: FontWeight.w600,
          fontSize: 14.0,
        ),
      ),
    );
  }
}
