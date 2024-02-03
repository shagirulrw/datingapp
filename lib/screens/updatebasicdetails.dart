import 'package:datingapp/method/authmethod.dart';

import 'package:datingapp/screens/explorepage.dart';
import 'package:datingapp/utils.dart';
import 'package:datingapp/widgets/backgrounds.dart';
import 'package:datingapp/widgets/keybutton.dart';

import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

// import '../utils.dart';
import '../widgets/Emailtextfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//  const Color(0xffF26D68)
// const Color(0xffF26D68)
// EFC338
class UpdateBasicDetails extends StatefulWidget {
  const UpdateBasicDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateBasicDetails> createState() => _UpdateBasicDetailsState();
}

double ageSlider = 23;

class _UpdateBasicDetailsState extends State<UpdateBasicDetails> {
  final bioController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bioController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////////////

    ////////////////////////////////////////////////////////////

    double height = MediaQuery.of(context).size.height;
    ////////////////////////////////////////////////image title widget

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
                        size: 30,
                        color: Colors.black,
                      )),
                  Center(
                    child: Text(
                      "Basic",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.sp,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                ],
              ),
              SizedBox(
                height: 90.h,
              ),
              Center(
                child: Text(
                  ageSlider.round().toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 64.sp,
                      color: Colors.black),
                ),
              ),
              Slider(
                activeColor: primarycolor,
                inactiveColor: const Color.fromARGB(255, 247, 247, 247),
                value: ageSlider,
                min: 18,
                max: 82,
                divisions: 100,
                label: ageSlider.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    ageSlider = value;
                  });
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              customtextfield(
                  height: 57.h,
                  width: 339.w,
                  radius: 12,
                  obscure: false,
                  hint: "Enter Your Short Bio",
                  controller: nameController),
              SizedBox(
                height: height * 0.018,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Bio",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
              ),
              customtextfield(
                  height: 57.h,
                  width: 339.w,
                  radius: 12,
                  obscure: false,
                  hint: "Enter Your Short Bio",
                  controller: bioController),
              SizedBox(
                height: height * 0.018,
              ),
              InkWell(
                onTap: () {
                  if (bioController.text.isNotEmpty &&
                      nameController.text.isNotEmpty) {
                    AuthMethod().updatebasicdetails(
                        age: ageSlider.round(),
                        bio: bioController.text.trim(),
                        name: nameController.text.trim(),
                        context: context);

                    // print("details Updated");
                    Navigator.pop(context);
                  } else {
                    showSnackbar(context, "You Have To Select Six photos");
                  }
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
