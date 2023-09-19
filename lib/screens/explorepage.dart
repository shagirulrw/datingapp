// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:datingapp/method/firebase_methods.dart';

// import 'package:datingapp/widgets/keybutton.dart';
// import 'package:datingapp/widgets/myswiper.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../model/usermodel.dart';
// import '../provider/cardprovider.dart';
// import '../provider/user_provider.dart';
// import '../widgets/tindertile.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// // Color basecolor = Color(0xff1C1D21);
// Color basecolor = const Color(0xffFFFFFF);

// // Color primarycolor = Color(0xff19BE8E);
// Color primarycolor = const Color(0xffF1AB16);

// Color keycolor = const Color(0xffEDF583);
// Color secondarycolor = const Color(0xffE7E6EB);

// class ExplorePage extends StatefulWidget {
//   const ExplorePage({Key? key}) : super(key: key);

//   @override
//   State<ExplorePage> createState() => _ExplorePageState();
// }

// class _ExplorePageState extends State<ExplorePage> {
//   List<dynamic> result = [];

//   @override
//   Widget build(BuildContext context) {
//     Users currentuser =
//         Provider.of<UserProvider>(context, listen: true).getuser;

//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: basecolor,
//           body: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("users")
//                   .where("female", isEqualTo: !currentuser.gender)
//                   .snapshots(),
//               builder: (context,
//                   AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasData) {
//                   result = snapshot.data!.docs
//                       .map((doc) => doc.data()["uid"])
//                       .toList();
// ////////////////////////////////////////////////////////////////////////////////////
//                   result.removeWhere(
//                       (element) => currentuser.liked.contains(element));
//                   result.removeWhere(
//                       (element) => currentuser.disliked.contains(element));
//                   /////////////////////////////////////////////
//                   Iterable matchedbuket = currentuser.matched.map((e) =>
//                       FirebaseMethod().roomcodedecode(
//                           code: e, currentuserid: currentuser.uid));
//                   //////////////////////////////////////////
//                   result
//                       .removeWhere((element) => matchedbuket.contains(element));
// /////////////////////////////////////////////////////////////////////////////////////
//                   int maxl = result.length - 1;

//                   return Column(
//                     children: [
//                       Center(
//                         child: Container(
//                             padding: const EdgeInsets.all(10),
//                             height: 642.h,
//                             width: MediaQuery.of(context).size.width,
//                             child: Stack(
//                               children: [
//                                 // (result.length > 1)
//                                 //     ? Tindercard(
//                                 //         isFront: false,
//                                 //         child: TinderTile(
//                                 //           functional: false,
//                                 //           // snap: snapshot.data!.docs[l].data(),
//                                 //           uid: result[maxl - 1],
//                                 //         ),
//                                 //       )
//                                 //     : const Center(
//                                 //         child: Text(""),
//                                 //       ),
//                                 (result.isEmpty)
//                                     ? const Center(
//                                         child: Text("No more profile left"),
//                                       )
//                                     : Tindercard(
//                                         isFront: false,
//                                         child: TinderTile(
//                                           functional: true,
//                                           uid: result[maxl],
//                                         ),
//                                       )
//                               ],
//                             )),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               if (result.isNotEmpty) {
//                                 context.read<CardProvider>().swipeLeft();
//                                 FirebaseMethod().firebasedisLike(
//                                     currentuid: currentuser.uid,
//                                     targetuid: result[maxl],
//                                     context: context);
//                               }
//                               context.read<UserProvider>().refrehUser();
//                               context.read<UserProvider>().indexreset();
//                             },
//                             child: keybutton(
//                                 textsize: 30.sp,
//                                 kheight: 66.h,
//                                 kwidth: 162.w,
//                                 kcolor: const Color(0xffE7E6EB),
//                                 ktext: "DISLIKE"),
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               context.read<CardProvider>().swipeRight();
//                               if (result.isNotEmpty) {
//                                 await FirebaseMethod().firebaseLike(
//                                   targetuid: result[maxl],
//                                   context: context,
//                                   currentuid: currentuser.uid,
//                                 );
//                               }

//                               await context.read<UserProvider>().refrehUser();
//                               context.read<UserProvider>().indexreset();
//                             },
//                             child: keybutton(
//                                 textsize: 30.sp,
//                                 kheight: 66.h,
//                                 kwidth: 162.w,
//                                 kcolor: result.isEmpty
//                                     ? const Color(0xffE7E6EB)
//                                     : primarycolor,
//                                 ktext: "LIKE"),
//                           )
//                         ],
//                       ),
//                     ],
//                   );
//                 } else {
//                   return const Center(child: Text("Something Went Wrong"));
//                 }
//               })),
//     );
//   }
// }
////////////////////////////////////////////////////////////////////////////////////////////////
///

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/method/firebase_methods.dart';

import 'package:datingapp/widgets/keybutton.dart';
import 'package:datingapp/widgets/myswiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/usermodel.dart';
import '../provider/cardprovider.dart';
import '../provider/user_provider.dart';
import '../widgets/tindertile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color basecolor = const Color(0xffFFFFFF);
// Color basecolor = const Color(0xffF8F3D8); code w

Color primarycolor = const Color(0xffF1AB16);
// Color primarycolor = const Color(0xffFF4F01); code w

// Color keycolor = const Color(0xffEDF583);
Color secondarycolor = const Color(0xffE7E6EB);

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().refrehUser();
  }

  List<dynamic> result = [];

  @override
  Widget build(BuildContext context) {
    Users currentuser =
        Provider.of<UserProvider>(context, listen: true).getuser;

    Future<List<dynamic>> fetchUsers() async {
      List<dynamic> users = [];
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('users')
          .where("female", isEqualTo: !currentuser.gender)
          .get();

      for (var doc in snapshot.docs) {
        users.add(doc.data()["uid"]);
      }

      return users;
    }

    return SafeArea(
        child: Scaffold(
      backgroundColor: basecolor,
      body: FutureBuilder<List<dynamic>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the data is being fetched
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If there's an error during the fetch
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData)
          // {
          //   // If the data is available
          //   List<dynamic> users = snapshot.data!;
          //   return ListView.builder(
          //     itemCount: users.length,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         title: Text(users[index]),
          //       );
          //     },
          //   );
          // }
          {
            List<dynamic> users = snapshot.data!;
            /////////////////////////////////////////////////////////////////
            users.removeWhere((element) => currentuser.liked.contains(element));
            users.removeWhere(
                (element) => currentuser.disliked.contains(element));
            /////////////////////////////////////////////
            Iterable matchedbuket = currentuser.matched.map((e) =>
                FirebaseMethod()
                    .roomcodedecode(code: e, currentuserid: currentuser.uid));
            //////////////////////////////////////////
            users.removeWhere((element) => matchedbuket.contains(element));
            /////////////////////////////////////////////////////////////////////////////////////
            int maxl = users.length - 1;

            return Column(
              children: [
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 642.h,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          // (result.length > 1)
                          //     ? Tindercard(
                          //         isFront: false,
                          //         child: TinderTile(
                          //           functional: false,
                          //           // snap: snapshot.data!.docs[l].data(),
                          //           uid: result[maxl - 1],
                          //         ),
                          //       )
                          //     : const Center(
                          //         child: Text(""),
                          //       ),

                          ///////////////////////////
                          (users.isEmpty)
                              ? const Center(
                                  child: Text("No more profile left"),
                                )
                              : Tindercard(
                                  isFront: false,
                                  child: TinderTile(
                                    functional: true,
                                    uid: users[maxl],
                                  ),
                                )
                        ],
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        if (users.isNotEmpty) {
                          context.read<CardProvider>().swipeLeft();
                          FirebaseMethod().firebasedisLike(
                              currentuid: currentuser.uid,
                              targetuid: users[maxl],
                              context: context);
                        }
                        context.read<UserProvider>().refrehUser();
                        context.read<CardProvider>().indexreset();
                      },
                      child: keybutton(
                          textsize: 30.sp,
                          kheight: 66.h,
                          kwidth: 162.w,
                          kcolor: const Color(0xffE7E6EB),
                          ktext: "DISLIKE"),
                    ),
                    InkWell(
                      onTap: () async {
                        context.read<CardProvider>().swipeRight();
                        if (users.isNotEmpty) {
                          await FirebaseMethod().firebaseLike(
                            targetuid: users[maxl],
                            context: context,
                            currentuid: currentuser.uid,
                          );
                        }

                        await context.read<UserProvider>().refrehUser();
                        context.read<CardProvider>().indexreset();
                      },
                      child: keybutton(
                          textsize: 30.sp,
                          kheight: 66.h,
                          kwidth: 162.w,
                          kcolor: users.isEmpty
                              ? const Color(0xffE7E6EB)
                              : primarycolor,
                          ktext: "LIKE"),
                    )
                  ],
                ),
              ],
            );
          } else {
            // If there's no data
            return Center(child: Text('No data available'));
          }
        },
      ),
    ));
  }
}

// 
