import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/screens/accountpage.dart';
import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/screens/likedprofilepage.dart';
import 'package:datingapp/screens/messagelistpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import '../model/usermodel.dart' as model;
import '../model/usermodel.dart';
import '../provider/user_provider.dart';

import 'package:ionicons/ionicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  // int pageindex;
  const HomePage({
    Key? key,

    //  required this.pageindex
  }) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

int pageindex = 1;

class _HomePageState extends State<HomePage> {
  final pcontroller = PageController(initialPage: (pageindex - 1));
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).refrehUser();
    super.initState();
  }

  @override
  void dispose() {
    pcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Users currentuser =
        Provider.of<UserProvider>(context, listen: true).getuser;
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: pcontroller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              pageindex = index + 1;
            });
          },
          scrollDirection: Axis.horizontal,
          children: const [
            ExplorePage(),
            LikedProfilePage(),
            MessageListPage(),
            AccountPage()
          ],
        ),
        Column(
          children: [
            const Spacer(),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        pcontroller.animateToPage(0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                      icon: Icon(
                        Ionicons.earth_outline,
                        size: 30,
                        color: (pageindex == 1) ? Colors.black : Colors.black45,
                      )),
                  IconButton(
                      onPressed: () {
                        pcontroller.animateToPage(1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                      icon: Icon(
                        Ionicons.heart_outline,
                        size: 30,
                        color: (pageindex == 2) ? Colors.black : Colors.black45,
                      )),
                  IconButton(
                    onPressed: () {
                      pcontroller.animateToPage(2,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut);
                    },
                    icon: Stack(
                      children: <Widget>[
                        Icon(
                          Ionicons.chatbox_outline,
                          size: 30,
                          color:
                              (pageindex == 3) ? Colors.black : Colors.black45,
                        ),
                        //////////////////////////////////

                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .where("uid", isEqualTo: currentuser.uid)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            switch (snapshot.connectionState) {
                              //if data is loading
                              case ConnectionState.waiting:
                              case ConnectionState.none:
                                return const Center(
                                    child: Text('No internet available'));

                              //if some or all data is loaded then show it
                              case ConnectionState.active:
                              case ConnectionState.done:
                                if (snapshot.hasData &&
                                    snapshot.data!.docs.isNotEmpty) {
                                  return (snapshot.data!.docs.last
                                              .data()["newmess"] ==
                                          true)
                                      ? Positioned(
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            constraints: const BoxConstraints(
                                              minWidth: 12,
                                              minHeight: 12,
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                } else {
                                  return Icon(
                                    Ionicons.chatbox_outline,
                                    size: 30,
                                    color: (pageindex == 3)
                                        ? Colors.black
                                        : Colors.black45,
                                  );
                                }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        pcontroller.animateToPage(3,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut);
                      },
                      icon: Icon(
                        Ionicons.person_outline,
                        size: 30,
                        color: (pageindex == 4) ? Colors.black : Colors.black45,
                      )),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
