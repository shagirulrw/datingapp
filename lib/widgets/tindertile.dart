import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/provider/cardprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// import '../provider/user_provider.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class TinderTile extends StatefulWidget {
  // final snap;
  final uid;
  final bool functional;
  const TinderTile(
      {Key? key,
      // required this.snap,
      required this.uid,
      required this.functional})
      : super(key: key);

  @override
  State<TinderTile> createState() => _TinderTileState();
}

// Widget indicator(int q) {
//   return Container(
//     decoration: BoxDecoration(
//         color: (i == q) ? Colors.white : Color.fromARGB(137, 3, 2, 2),
//         borderRadius: BorderRadius.circular(12)),
//     height: 7.h,
//     width: 40.w,
//   );
// }

Widget detailswidget({String? wtitle}) {
  return wtitle != ""
      ? FittedBox(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: Colors.white)),
            margin: const EdgeInsets.only(right: 8.0, top: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                wtitle!,
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          ),
        )
      : const SizedBox();
}

class _TinderTileState extends State<TinderTile> {
  // int i = 0;
  // int i =context.watch<CardProvider>().index;

  @override
  Widget build(BuildContext context) {
    int i = widget.functional ? context.watch<CardProvider>().index : 0;
    Widget indicator(int q) {
      return Container(
        decoration: BoxDecoration(
            color: (i == q) ? Colors.white : const Color.fromARGB(137, 3, 2, 2),
            borderRadius: BorderRadius.circular(12)),
        height: 7.h,
        width: 40.w,
      );
    }

    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // List<dynamic> imgl = widget.snap["photoURLs"];
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("users")
          .where("uid", isEqualTo: widget.uid)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          List<dynamic> detailslist = snapshot.data!.docs.first.get("details");
          return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${snapshot.data!.docs.first.get("photoURLs")[i]}"),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.5, 7]),
                      ),
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "${snapshot.data!.docs.first.get("username")} "
                                        .toCapitalized(),
                                    style: TextStyle(
                                        fontSize: 50.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    overflow: TextOverflow.fade,
                                  ),
                                  Text(
                                      "${snapshot.data!.docs.first.get("age")}",
                                      style: TextStyle(
                                          fontSize: 50.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                          Text(
                            "${snapshot.data!.docs.first.get("bio")}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                          if (detailslist[0] != "" ||
                              detailslist[2] != "" ||
                              detailslist[3] != "")
                            SizedBox(
                              height: 40.h,
                              child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  children: [
                                    detailswidget(wtitle: detailslist[0]),
                                    detailswidget(wtitle: detailslist[1]),
                                    detailswidget(wtitle: detailslist[2]),
                                    if (detailslist[4] != "prefer not to say")
                                      detailswidget(wtitle: detailslist[4]),
                                  ]
                                  // detailslist.map((doc) {
                                  //   return doc != ""
                                  //       ? FittedBox(
                                  //           child: Container(
                                  //             decoration: BoxDecoration(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(12),
                                  //                 border: Border.all(
                                  //                     width: 1,
                                  //                     color: Colors.white)),
                                  //             margin: EdgeInsets.only(
                                  //                 right: 8.0, top: 8.0),
                                  //             child: Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(5.0),
                                  //               child: Text(
                                  //                 doc,
                                  //                 style: TextStyle(
                                  //                     color: Colors.white,
                                  //                     fontSize: 20.sp),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         )
                                  //       : SizedBox();
                                  // }).toList(),
                                  ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: 40.w,
                      top: 20.h,
                      child: SizedBox(
                        width: 300.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            indicator(0),
                            indicator(1),
                            indicator(2),
                            indicator(3),
                            indicator(4),
                            indicator(5),
                          ],
                        ),
                      )),
                  widget.functional
                      ? Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<CardProvider>().decrementindex();
                                  // setState(() {
                                  //   if (i <= 0) {
                                  //     i = 5;
                                  //   } else {
                                  //     --i;
                                  //   }
                                  // });
                                  // print(i);
                                },
                                child: Container(),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<CardProvider>().incrementindex();
                                  // setState(() {
                                  //   if (i >= 5) {
                                  //     i = 0;
                                  //   } else {
                                  //     ++i;
                                  //   }
                                  // });
                                  // print(i);
                                },
                                child: Container(),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ));
        } else {
          return const Center(child: Text("Something Went Wrong"));
        }
      },
    );
    // return ClipRRect(
    //     borderRadius: BorderRadius.circular(20),
    //     child: Stack(
    //       children: [
    //         Container(
    //           decoration: BoxDecoration(
    //               image: DecorationImage(
    //                   image: NetworkImage("${widget.snap["photoURLs"][i]}"),
    //                   fit: BoxFit.cover)),
    //           child: Container(
    //             decoration: const BoxDecoration(
    //               gradient: LinearGradient(
    //                   colors: [Colors.transparent, Colors.black],
    //                   begin: Alignment.topCenter,
    //                   end: Alignment.bottomCenter,
    //                   stops: [0.5, 7]),
    //             ),
    //             padding: const EdgeInsets.all(25),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Spacer(),
    //                 Row(
    //                   children: [
    //                     Text(
    //                       "${widget.snap["username"]} ".toCapitalized(),
    //                       style: TextStyle(
    //                           fontSize: 50.sp,
    //                           fontWeight: FontWeight.bold,
    //                           color: Colors.white),
    //                     ),
    //                     Text("${widget.snap["age"]}",
    //                         style: TextStyle(
    //                             fontSize: 50.sp,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white))
    //                   ],
    //                 ),
    //                 Text(
    //                   "${widget.snap["bio"]}",
    //                   style: TextStyle(color: Colors.white, fontSize: 20.sp),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //             left: 40.w,
    //             top: 20.h,
    //             child: SizedBox(
    //               width: 300.w,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   indicator(0),
    //                   indicator(1),
    //                   indicator(2),
    //                   indicator(3),
    //                   indicator(4),
    //                   indicator(5),
    //                 ],
    //               ),
    //             )),
    //         widget.functional
    //             ? Row(
    //                 children: [
    //                   Expanded(
    //                     child: InkWell(
    //                       onTap: () {
    //                         setState(() {
    //                           if (i <= 0) {
    //                             i = 5;
    //                           } else {
    //                             --i;
    //                           }
    //                         });
    //                         print(i);
    //                       },
    //                       child: Container(),
    //                     ),
    //                   ),
    //                   Expanded(
    //                     child: InkWell(
    //                       onTap: () {
    //                         setState(() {
    //                           if (i >= 5) {
    //                             i = 0;
    //                           } else {
    //                             ++i;
    //                           }
    //                         });
    //                         print(i);
    //                       },
    //                       child: Container(),
    //                     ),
    //                   ),
    //                 ],
    //               )
    //             : SizedBox(),
    //       ],
    //     ));
  }
}
