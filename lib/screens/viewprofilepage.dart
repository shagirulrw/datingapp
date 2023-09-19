import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewProfilePage extends StatefulWidget {
  final uid;
  const ViewProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

int i = 0;

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  void dispose() {
    i = 0;
    super.dispose();
  }

  Widget detailtile(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              title,
              style: const TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }

  Widget detailcolumn(List<dynamic> arr) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Column(children: [
            Container(
                color: Colors.black,
                height: 40.h,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Ionicons.create_outline,
                    //       size: 25,
                    //       color: Colors.white,
                    //     ))
                  ],
                )),
            Column(
              children: [
                if (arr[0] == "" &&
                    arr[1] == "" &&
                    arr[2] == "" &&
                    arr[3] == "" &&
                    arr[4] == "" &&
                    arr[5] == "" &&
                    arr[6] == "" &&
                    arr[7] == "")
                  const FittedBox(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "No Data Added Yet",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                if (arr[0] != "")
                  detailtile(Ionicons.pin_outline, "City: ${arr[0]}"), //city
                if (arr[1] != "")
                  detailtile(
                      Ionicons.body_outline, "Height: ${arr[1]}"), //height
                if (arr[2] != "")
                  detailtile(Ionicons.briefcase_outline,
                      "Education: ${arr[2]}"), //education
                if (arr[3] != "")
                  detailtile(Ionicons.color_palette_outline,
                      "Hobbie : ${arr[3]}"), //hobbie
                if (arr[4] != "")
                  detailtile(Ionicons.color_filter_outline,
                      "Follows ${arr[4]} "), //religion
                if (arr[5] != "")
                  detailtile(Ionicons.barbell_outline,
                      "exercise ${arr[5]}"), //exercise
                if (arr[6] != "")
                  detailtile(Ionicons.beer_outline, "Drink ${arr[6]}"), //drink
                if (arr[7] != "")
                  detailtile(
                      Ionicons.flame_outline, "Smoke ${arr[7]}"), //smoke],),
              ],
            )
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
          List photosUrls = snapshot.data!.docs.first.get("photoURLs");

          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Ionicons.chevron_back_outline,
                    size: 30,
                    color: Colors.black,
                  )),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 70.h,
                    //   child: IconButton(
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       icon: const Icon(
                    //         Ionicons.chevron_back_outline,
                    //         size: 30,
                    //         color: Colors.black,
                    //       )),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Tile(photourllist: photosUrls),
                    ),
                    const Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Row(
                        children: [
                          Text(
                            "${snapshot.data!.docs.first.get("username")} ",
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text("${snapshot.data!.docs.first.get("age")}",
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Text("${snapshot.data!.docs.first.get("bio")}",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: detailcolumn(
                          snapshot.data!.docs.first.get("details") ??
                              ["", "", "", "", "", "", "", ""]),
                    )
                  ],
                ),
              ),
            ),
          ));
        } else {
          return const Center(child: Text("Something Went Wrong"));
        }
      },
    );
  }
}

Widget indicator(int q) {
  return Container(
    decoration: BoxDecoration(
        color: (i == q) ? Colors.white : const Color.fromARGB(137, 3, 2, 2),
        borderRadius: BorderRadius.circular(12)),
    height: 7.h,
    width: 40.w,
  );
}

class Tile extends StatefulWidget {
  final photourllist;
  Tile({
    Key? key,
    required this.photourllist,
  }) : super(key: key);

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    // print(widget.photourllist);
    return SizedBox(
      height: 450.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.photourllist[i]),
                      fit: BoxFit.cover)),
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
            SizedBox(
              // height: 620.h,
              // width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // context.read<UserProvider>().decrementindex();
                        setState(() {
                          if (i <= 0) {
                            i = 5;
                          } else {
                            --i;
                          }
                        });
                        // print(i);
                      },
                      child: Container(),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // context.read<UserProvider>().incrementindex();
                        setState(() {
                          if (i >= 5) {
                            i = 0;
                          } else {
                            ++i;
                          }
                        });
                      },
                      child: Container(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
