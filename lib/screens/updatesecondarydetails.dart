// import 'dart:html';

import 'package:datingapp/method/firebase_methods.dart';

import 'package:datingapp/provider/user_provider.dart';

import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/utils.dart';
import 'package:datingapp/widgets/backgrounds.dart';
import 'package:datingapp/widgets/keybutton.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
// import '../utils.dart';
import '../widgets/Emailtextfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//  const Color(0xffF26D68)
// const Color(0xffF26D68)
// EFC338

// ignore: must_be_immutable
class UpdateSecondaryDetails extends StatefulWidget {
  final List<dynamic>? prefetchdetail;

  const UpdateSecondaryDetails({
    Key? key,
    // required this.snap,
    required this.prefetchdetail,
  }) : super(key: key);

  @override
  State<UpdateSecondaryDetails> createState() => _UpdateSecondaryDetailsState();
}

double heightslider = 165;
List<String> exercise = ["Often", "Sometimes", "Never"];
String selectedexercise = prefetchdetails[5];
List<String> drink = ["Often", "Sometimes", "Never"];
String selecteddrink = prefetchdetails[6];
List<String> smoke = ["Often", "Sometimes", "Never"];
String selectedsmoke = prefetchdetails[7];
List<String> religion = [
  "Atheism",
  "Christianity",
  "Catholicism",
  "Islam",
  "Hinduism",
  "Buddhism",
  "Sikh",
  "prefer not to say"
];
late TextEditingController cityController;
late TextEditingController educationController;
late TextEditingController hobbieController;
String selectedreligion = prefetchdetails[4];
late List prefetchdetails;

class _UpdateSecondaryDetailsState extends State<UpdateSecondaryDetails> {
  @override
  void initState() {
    // TODO: implement initState

    prefetchdetails = widget.prefetchdetail!;
    cityController = TextEditingController(text: prefetchdetails[0]);
    educationController = TextEditingController(text: prefetchdetails[2]);
    hobbieController = TextEditingController(text: prefetchdetails[3]);
    super.initState();
  }

  String cmToFeetAndInches(double cm) {
    double inches = cm * 0.393701;
    int feet = (inches ~/ 12);
    int remainingInches = (inches % 12).toInt();

    return "$feet' ${remainingInches}";
  }
/////////////

  void _showExerciseRadioPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: exercise.map((color) {
              return RadioListTile<String>(
                title: Text(color),
                value: color,
                groupValue: selectedexercise,
                onChanged: (value) {
                  setState(() {
                    selectedexercise = value!;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showdrinkRadioPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: drink.map((color) {
              return RadioListTile<String>(
                title: Text(color),
                value: color,
                groupValue: selecteddrink,
                onChanged: (value) {
                  setState(() {
                    selecteddrink = value!;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showSmokeRadioPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: smoke.map((color) {
              return RadioListTile<String>(
                title: Text(color),
                value: color,
                groupValue: selectedsmoke,
                onChanged: (value) {
                  setState(() {
                    selectedsmoke = value!;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showreligionRadioPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: religion.map((color) {
              return RadioListTile<String>(
                title: Text(color),
                value: color,
                groupValue: selectedreligion,
                onChanged: (value) {
                  setState(() {
                    selectedreligion = value!;
                  });
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  ////////////////////////////////////////////////image title widget

  @override
  void dispose() {
    educationController.dispose();
    hobbieController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future<void> fetchDataFromFirebase() async {
    //   print("starting \n\n");
    //   User currentUser = FirebaseAuth.instance.currentUser!;
    //   DocumentReference<Map<String, dynamic>> dataCollection =
    //       FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

    //   // Fetch the data
    //   DocumentSnapshot<Map<String, dynamic>> querySnapshot =
    //       await dataCollection.get();

    //   // Process the querySnapshot to store data in the list
    //   prefetchdetails = querySnapshot["details"];
    //   // querySnapshot.docs.map((doc) => doc["details"]).toList();
    //   // print(prefetchdetails);
    // }

    // fetchDataFromFirebase();
    //////////////////////////////
    // final currentuser =
    //     Provider.of<UserProvider>(context, listen: true).getuser;
    ////////////////////////////////////////////////////////////
    double height = MediaQuery.of(context).size.height;
///////////////////////////////////////////////////////////////
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: background2(Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Ionicons.arrow_back_outline,
                        size: 27,
                        color: Colors.black,
                      )),
                  Center(
                    child: InkWell(
                      onTap: () {
                        print(prefetchdetails);
                      },
                      child: Text(
                        "Edit Details",
                        // prefetchdetails[0],
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "City",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              customtextfield(
                  height: 57.h,
                  width: 339.w,
                  radius: 12,
                  obscure: false,
                  hint: "Enter Your City e.g(New Dellhi,India)",
                  controller: cityController),
              SizedBox(
                height: height * 0.008,
              ),
              Text(
                "Height  ${cmToFeetAndInches(heightslider)} (${heightslider.round().toString()} cm)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: Colors.black),
              ),
              Slider(
                activeColor: primarycolor,
                inactiveColor: const Color.fromARGB(255, 247, 247, 247),
                value: heightslider,
                min: 91,
                max: 241,
                divisions: 100,
                label: heightslider.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    heightslider = value;
                  });
                },
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Text(
                "Education",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              customtextfield(
                  height: 57.h,
                  width: 339.w,
                  radius: 12,
                  obscure: false,
                  hint: "highest qualification e.g(BTech(2019-2023))",
                  controller: educationController),
              SizedBox(
                height: height * 0.008,
              ),
              Text(
                "Hobbie",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              customtextfield(
                  height: 57.h,
                  width: 339.w,
                  radius: 12,
                  obscure: false,
                  hint: "hobbies you like (separate them using ' , ')",
                  controller: hobbieController),
              SizedBox(
                height: height * 0.008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Religion",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.sp),
                      ),
                      InkWell(
                        onTap: () {
                          _showreligionRadioPicker(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                              color: secondarycolor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 5.w),
                            child: Text(
                              selectedreligion,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.sp, color: Colors.black45),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exercise",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.sp),
                      ),
                      InkWell(
                        onTap: () {
                          _showExerciseRadioPicker(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                              color: secondarycolor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 5.w),
                            child: Text(
                              selectedexercise,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.sp, color: Colors.black45),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.008,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.008,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Drink",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.sp),
                      ),
                      InkWell(
                        onTap: () {
                          _showdrinkRadioPicker(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                              color: secondarycolor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 5.w),
                            child: Text(
                              selecteddrink,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.sp, color: Colors.black45),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Smoke",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.sp),
                      ),
                      InkWell(
                        onTap: () {
                          _showSmokeRadioPicker(context);
                        },
                        child: Container(
                          height: 50.h,
                          width: 160.w,
                          decoration: BoxDecoration(
                              color: secondarycolor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 5.w),
                            child: Text(
                              selectedsmoke,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15.sp, color: Colors.black45),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: height * 0.020,
                  // ),
                ],
              ),
              SizedBox(
                height: height * 0.020,
              ),
              InkWell(
                onTap: () {
                  // _showMaterialRadioPicker(context);
                  // if (cityController.text.isNotEmpty &&
                  //     educationController.text.isNotEmpty &&
                  //     hobbieController.text.isNotEmpty) {
                  FirebaseMethod().updateDetails(
                      context.read<UserProvider>().getuser.uid,
                      cityController.text.isNotEmpty
                          ? cityController.text.trim()
                          : "",
                      cmToFeetAndInches(heightslider).toString(),
                      educationController.text.isNotEmpty
                          ? educationController.text.trim()
                          : "",
                      hobbieController.text.isNotEmpty
                          ? hobbieController.text.trim()
                          : "",
                      selectedreligion,
                      selectedexercise,
                      selecteddrink,
                      selectedsmoke);
                  showSnackbar(context, "details updated");
                  context.read<UserProvider>().refrehUser();
                  // setState(() {
                  //   selecteddrink == "";
                  //   selectedexercise == "";
                  //   selectedreligion == "";
                  //   selectedsmoke == "";
                  //   hobbieController.clear();
                  //   educationController.clear();
                  //   cityController.clear();
                  // });
                  Navigator.pop(context);

                  // } else {
                  //   showSnackbar(context, "Please fill all fields");
                  // }
                },
                child: keybutton(
                    textsize: 25.sp,
                    kwidth: 328.w,
                    kheight: 66.h,
                    kcolor: primarycolor,
                    ktext: "Update"),
              )
            ],
          ),
        ),
      )),
    ));
  }
}
