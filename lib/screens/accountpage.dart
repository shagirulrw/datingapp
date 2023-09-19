import 'package:datingapp/model/usermodel.dart';
import 'package:datingapp/screens/editphoto.dart';
import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/screens/messagelistpage.dart';
import 'package:datingapp/screens/updatebasicdetails.dart';
import 'package:datingapp/screens/updatesecondarydetails.dart';
import 'package:datingapp/screens/viewprofilepage.dart';
import 'package:datingapp/widgets/keybutton.dart';
import 'package:datingapp/widgets/simplebutton.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../method/authmethod.dart';
import '../provider/user_provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);
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

  Widget detailcolumn(BuildContext context, List<dynamic> arr) {
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
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Details",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateSecondaryDetails(
                                      prefetchdetail: context
                                          .read<UserProvider>()
                                          .getuser
                                          .details,
                                    )),
                          );
                        },
                        icon: const Icon(
                          Ionicons.create_outline,
                          size: 25,
                          color: Colors.white,
                        ))
                  ],
                )),
            Column(
              children: [
                (arr[0] != "")
                    ? detailtile(Ionicons.pin_outline, "City: ${arr[0]}")
                    : detailtile(
                        Ionicons.pin_outline, "City: Update Your City"), //city
                (arr[1] != "")
                    ? detailtile(Ionicons.body_outline, "Height: ${arr[1]}")
                    : detailtile(Ionicons.body_outline,
                        "Height: Update Your Height"), //height
                (arr[2] != "")
                    ? detailtile(
                        Ionicons.briefcase_outline, "Education: ${arr[2]}")
                    : detailtile(Ionicons.briefcase_outline,
                        "Education: Update Your Education"), //education
                (arr[3] != "")
                    ? detailtile(
                        Ionicons.color_palette_outline, "Hobbie : ${arr[3]}")
                    : detailtile(Ionicons.color_palette_outline,
                        "Hobbie: Update Your Hobbies"), //hobbie

                (arr[4] != "")
                    ? detailtile(
                        Ionicons.color_filter_outline, "Follows ${arr[4]} ")
                    : detailtile(Ionicons.color_filter_outline,
                        "Religion: Update your religious belief"), //religion

                (arr[5] != "")
                    ? detailtile(Ionicons.barbell_outline, "exercise ${arr[5]}")
                    : detailtile(Ionicons.barbell_outline,
                        "Exercise: Update How Often You Exercise"), //exercise

                (arr[6] != "")
                    ? detailtile(Ionicons.beer_outline, "Drink ${arr[6]}")
                    : detailtile(Ionicons.beer_outline,
                        "Drink: Update How Often You Exercise"), //drink

                (arr[7] != "")
                    ? detailtile(Ionicons.flame_outline, "Smoke ${arr[7]}")
                    : detailtile(Ionicons.flame_outline,
                        "Smoke: Update How Often You Smoke"), //smoke],),
              ],
            )
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    Users currentuser =
        Provider.of<UserProvider>(context, listen: true).getuser;
    // print(currentuser.newmess);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPhotoPage()),
                        );
                      },
                      child: Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${currentuser.photoURLs[0]}"),
                                  fit: BoxFit.cover)),
                          child: SizedBox(
                            height: 500.h,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                            bottom: 10.h,
                            right: 10.w,
                            child: simplebutton(
                                sheight: 50.h,
                                swidth: 90.w,
                                scolor: Colors.white70,
                                text: "Edit image",
                                textsize: 12.sp,
                                sborder: true,
                                borderradius: 8)),
                        Positioned(
                          bottom: 10.h,
                          left: 10.w,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewProfilePage(
                                          uid: currentuser.uid,
                                        )),
                              );
                            },
                            child: simplebutton(
                                sheight: 50.h,
                                swidth: 90.w,
                                scolor: Colors.white70,
                                text: "View Profile",
                                textsize: 12.sp,
                                sborder: true,
                                borderradius: 8),
                          ),
                        )
                      ]),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        "${currentuser.username}  ".toCapitalized(),
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text("${currentuser.age}",
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const UpdateBasicDetails()),
                            );
                          },
                          icon: const Icon(
                            Ionicons.create_outline,
                            size: 30,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(currentuser.bio,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54)),
                  ),
                ),
                const Divider(),
                detailcolumn(context, currentuser.details!.toList()),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                //   child: Container(
                //     width: double.infinity,
                //     decoration: const BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(4))),
                //     child: Column(
                //       children: [
                //         Container(
                //             color: Colors.black,
                //             height: 40.h,
                //             child: const Row(
                //               children: [
                //                 Padding(
                //                   padding: EdgeInsets.all(8.0),
                //                   child: Text(
                //                     "Details",
                //                     style: TextStyle(
                //                         color: Colors.white,
                //                         fontSize: 20,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //                 Spacer()
                //               ],
                //             )),
                //         detailtile(
                //             Ionicons.body_outline, "height, 5'9"), //height
                //         detailtile(Ionicons.barbell_outline, "slim"), //fitness
                //         detailtile(Ionicons.briefcase_outline,
                //             "education"), //education
                //         detailtile(
                //             Ionicons.beer_outline, "Drink often"), //drink
                //         detailtile(
                //             Ionicons.flame_outline, "smoke often"), //smoke
                //         detailtile(Ionicons.color_filter_outline,
                //             "religon"), //religion
                //         detailtile(Ionicons.color_palette_outline,
                //             "hobbies"), //religion
                //       ],
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const UpdateBasicDetails()),
                    //     );
                    //   },
                    //   child: keybutton(
                    //       textsize: 30.sp,
                    //       kheight: 66.h,
                    //       kwidth: 122.w,
                    //       kcolor: primarycolor,
                    //       ktext: "EDIT"),
                    // ),
                    InkWell(
                      onTap: () {
                        AuthMethod().logOut(context);
                      },
                      child: keybutton(
                          textsize: 30.sp,
                          kheight: 66.h,
                          // kwidth: 190.w,
                          kwidth: 320.w,
                          kcolor: primarycolor,
                          ktext: "LOG OUT"),
                    )
                  ],
                ),
                SizedBox(
                  height: 100.h,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
