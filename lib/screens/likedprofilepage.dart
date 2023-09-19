// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:datingapp/method/firebase_methods.dart';
// import 'package:datingapp/screens/explorepage.dart';
// import 'package:datingapp/screens/viewprofilepage.dart';
// import 'package:datingapp/widgets/simplebutton.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../model/usermodel.dart';
// import '../provider/user_provider.dart';

// class LikedProfilePage extends StatefulWidget {
//   const LikedProfilePage({Key? key}) : super(key: key);

//   @override
//   State<LikedProfilePage> createState() => _LikedProfilePageState();
// }

// class _LikedProfilePageState extends State<LikedProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     Users currentuser =
//         Provider.of<UserProvider>(context, listen: true).getuser;
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: basecolor,
//       ),

//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection("users")
//             .where("uid", isEqualTo: currentuser.uid)
//             .snapshots(),
//         builder: (context,
//             AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData || snapshot.data!.docs.isNotEmpty) {
//             return SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Text(
//                       "LIKES",
//                       style: TextStyle(
//                           fontSize: 32.sp, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   (snapshot.data!.docs.first.data()["liked"].length != 0)
//                       ? Container(
//                           padding: EdgeInsets.symmetric(horizontal: 10.w),
//                           child: GridView.builder(
//                             physics: const ScrollPhysics(),
//                             shrinkWrap: true,
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     crossAxisSpacing: 4.0,
//                                     mainAxisSpacing: 10.0),
//                             itemCount: snapshot.data!.docs.first
//                                 .data()["liked"]
//                                 .length,
//                             itemBuilder: (context, index) {
//                               return ListTile(
//                                 title: tile(
//                                     snapshot.data!.docs.first["liked"][index]),
//                               );
//                             },
//                           ),
//                         )
//                       : SizedBox(
//                           height: 400.h,
//                           child: const Center(
//                               child: Text(
//                             "No Data To Show Here!!!\nStart Liking Profiles",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.black54),
//                           )),
//                         ),
//                   SizedBox(
//                     height: 100.h,
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text("No Data To Show"));
//           }
//         },
//       ),
//       /////////////////////////////
//     ));
//   }
// }

// Widget tile(String uid) {
//   return StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection("users")
//         .where("uid", isEqualTo: uid)
//         .snapshots(),
//     builder:
//         (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//       Users currentuser =
//           Provider.of<UserProvider>(context, listen: false).getuser;
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (snapshot.hasData) {
//         return Container(
//           // padding: EdgeInsets.all(10),
//           decoration: BoxDecoration(
//               border: Border.all(width: 2, color: Colors.black),
//               color: secondarycolor,
//               borderRadius: BorderRadius.circular(5)),
//           child: InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ViewProfilePage(
//                           uid: snapshot.data!.docs.first.get("uid"),
//                         )),
//               );
//             },
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(
//                                 "${snapshot.data!.docs.first.get("photoURLs")[0]}"),
//                             fit: BoxFit.cover)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 Text(snapshot.data!.docs.first.get("username"),
//                     style: TextStyle(
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.bold,
//                     )),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     FirebaseMethod().removeLike(
//                         currentuid: currentuser.uid,
//                         targetuid: uid,
//                         context: context);
//                     context.read<UserProvider>().refrehUser();
//                   },
//                   child: simplebutton(
//                       sheight: 40.h,
//                       swidth: 80.w,
//                       scolor: primarycolor,
//                       text: "DISLIKE",
//                       textsize: 14.sp,
//                       sborder: true,
//                       borderradius: 12),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 )
//               ],
//             ),
//           ),
//         );
//       } else {
//         return const Center(child: Text("Something Went Wrong"));
//       }
//     },
//   );
// }
/////////////////////////
///////////////////
///
///
///
///
///
///
///
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/method/firebase_methods.dart';
import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/screens/viewprofilepage.dart';
import 'package:datingapp/widgets/simplebutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/usermodel.dart';
import '../provider/user_provider.dart';

class LikedProfilePage extends StatefulWidget {
  const LikedProfilePage({Key? key}) : super(key: key);

  @override
  State<LikedProfilePage> createState() => _LikedProfilePageState();
}

class _LikedProfilePageState extends State<LikedProfilePage> {
  final PageController _pageController = PageController();
  // bool firstpage = true;
  int currentpage = 0;
  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Users currentuser =
        Provider.of<UserProvider>(context, listen: true).getuser;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: basecolor,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("uid", isEqualTo: currentuser.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData || snapshot.data!.docs.isNotEmpty) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "LIKES",
                      style: TextStyle(
                          fontSize: 32.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _goToPage(0);
                          },
                          child: Text(
                            "You Like",
                            style:
                                TextStyle(fontSize: 25.sp, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                        ),
                        InkWell(
                          onTap: () {
                            _goToPage(1);
                          },
                          child: Text(
                            "Likes You",
                            style:
                                TextStyle(fontSize: 25.sp, color: Colors.black),
                          ),
                        ),
                      ],
                    )),
                  ),
                  const Divider(),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 555.h,
                    child: PageView(
                      onPageChanged: (index) {
                        print(index);
                        // setState(() {
                        //   currentpage = index;
                        // });
                      },
                      // physics: const NeverScrollableScrollPhysics(),

                      /// [PageView.scrollDirection] defaults to [Axis.horizontal].
                      /// Use [Axis.vertical] to scroll vertically.
                      controller: _pageController,
                      // onPageChanged: (index) {
                      //   setState(() {
                      //     currentPage = index;
                      //   });
                      // },
                      children: <Widget>[
                        (snapshot.data!.docs.first.data()["liked"].length != 0)
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: GridView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 10.0),
                                  itemCount: snapshot.data!.docs.first
                                      .data()["liked"]
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: tile(
                                          snapshot.data!.docs.first["liked"]
                                              [index],
                                          false),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 555.h,
                                child: const Center(
                                    child: Text(
                                  "No Data To Show Here!!!\nStart Liking Profiles",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black54),
                                )),
                              ),
                        (snapshot.data!.docs.first.data()["likedyou"].length !=
                                0)
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: GridView.builder(
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 10.0),
                                  itemCount: snapshot.data!.docs.first
                                      .data()["likedyou"]
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: tile(
                                          snapshot.data!.docs.first["likedyou"]
                                              [index],
                                          true),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 555.h,
                                child: const Center(
                                    child: Text(
                                  "No Data To Show Here!!!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black54),
                                )),
                              ),
                      ],
                    ),
                  )
                  // (snapshot.data!.docs.first.data()["liked"].length != 0)
                  //     ? Container(
                  //         padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //         child: GridView.builder(
                  //           physics: const ScrollPhysics(),
                  //           shrinkWrap: true,
                  //           gridDelegate:
                  //               const SliverGridDelegateWithFixedCrossAxisCount(
                  //                   crossAxisCount: 2,
                  //                   crossAxisSpacing: 4.0,
                  //                   mainAxisSpacing: 10.0),
                  //           itemCount: snapshot.data!.docs.first
                  //               .data()["liked"]
                  //               .length,
                  //           itemBuilder: (context, index) {
                  //             return ListTile(
                  //               title: tile(
                  //                   snapshot.data!.docs.first["liked"][index]),
                  //             );
                  //           },
                  //         ),
                  //       )
                  //     : SizedBox(
                  //         height: 400.h,
                  //         child: const Center(
                  //             child: Text(
                  //           "No Data To Show Here!!!\nStart Liking Profiles",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(color: Colors.black54),
                  //         )),
                  //       ),
                  ,
                  // SizedBox(
                  //   height: 100.h,
                  // ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("No Data To Show"));
          }
        },
      ),
      /////////////////////////////
    ));
  }
}

Widget tile(String uid, bool hiddenimg) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .snapshots(),
    builder:
        (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      Users currentuser =
          Provider.of<UserProvider>(context, listen: false).getuser;
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasData) {
        return Container(
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black),
              color: secondarycolor,
              borderRadius: BorderRadius.circular(5)),
          child: InkWell(
            onTap: () {
              if (hiddenimg == false) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewProfilePage(
                            uid: snapshot.data!.docs.first.get("uid"),
                          )),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${snapshot.data!.docs.first.get("photoURLs")[0]}"),
                            fit: BoxFit.cover)),
                    child: hiddenimg
                        ? ClipRRect(
                            child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                                alignment: Alignment.center,
                                // color: Colors.grey.withOpacity(0.1),
                                child: SizedBox()),
                          ))
                        : const SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                          ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                    hiddenimg
                        ? "xxxxxxx"
                        : snapshot.data!.docs.first.get("username"),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(
                  height: 5.h,
                ),
                hiddenimg
                    ? SizedBox()
                    : InkWell(
                        onTap: () {
                          FirebaseMethod().removeLike(
                              currentuid: currentuser.uid,
                              targetuid: uid,
                              context: context);
                          context.read<UserProvider>().refrehUser();
                        },
                        child: simplebutton(
                            sheight: 40.h,
                            swidth: 80.w,
                            scolor: primarycolor,
                            text: "DISLIKE",
                            textsize: 14.sp,
                            sborder: true,
                            borderradius: 12),
                      ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        );
      } else {
        return const Center(child: Text("Something Went Wrong"));
      }
    },
  );
}
