import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/method/firebase_methods.dart';
import 'package:datingapp/model/usermodel.dart';
import 'package:datingapp/provider/user_provider.dart';
import 'package:datingapp/screens/chatscreen.dart';
import 'package:datingapp/screens/explorepage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

class MessageListPage extends StatefulWidget {
  const MessageListPage({Key? key}) : super(key: key);

  @override
  State<MessageListPage> createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  @override
  Widget build(BuildContext context) {
    Users currentuser =
        Provider.of<UserProvider>(context, listen: true).getuser;
    // Users currentuser = context.read<UserProvider>().getuser;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: basecolor,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("uid", isEqualTo: currentuser.uid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "MESSAGE",
                            style: TextStyle(
                                fontSize: 32.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          (snapshot.data!.docs.first.data()["matched"].length !=
                                  0)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: snapshot.data!.docs.first
                                      .data()["matched"]
                                      .length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        title: InkWell(
                                      child:
                                          /////////////////////////////////////////////////
                                          tile2(
                                              FirebaseMethod().roomcodedecode(
                                                  code: snapshot.data!.docs
                                                      .first["matched"][index],
                                                  currentuserid:
                                                      currentuser.uid),
                                              snapshot.data!.docs
                                                  .first["matched"][index]),
                                      ///////////////////////////////////////////////////////
                                    ));
                                  },
                                )
                              : SizedBox(
                                  height: 400.h,
                                  child: const Center(
                                      child: Text(
                                    "No Data To Show Here!!!\nYou Haven't Matched With Anyone\ngo explore",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black54),
                                  )),
                                ),
                          SizedBox(
                            height: 100.h,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: Text("No Data To Show"));
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}

Widget tile2(String uid, String doc) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .snapshots(),
    builder:
        (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasData) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(
                          name: snapshot.data!.docs.first.get("username"),
                          photo: snapshot.data!.docs.first.get("photoURLs")[0],
                          doc: doc,
                        )));
          },
          child: Container(
              decoration: const BoxDecoration(),
              height: 100.h,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "${snapshot.data!.docs.first.get("photoURLs")[0]}"),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snapshot.data!.docs.first.get("username")}"
                            .toCapitalized(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                      // LastMessage(doc: doc)
                      ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 260.0.w),
                          child:
                              ////////////////////////////////////////////////////
                              LastMessage(doc: doc))
                      /////////////////////////////////////
                    ],
                  ),
                ],
              )),
        );
      } else {
        return const Center(child: Text("No Data To Show"));
      }
    },
  );
}

class LastMessage extends StatelessWidget {
  final String doc;
  const LastMessage({
    Key? key,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chats")
            .doc(doc)
            .collection("message")
            .orderBy('time', descending: false)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          switch (snapshot.connectionState) {
            //if data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const SizedBox(
                child: Text(""),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              List<dynamic> result = snapshot.data!.docs
                  .map((doc) => doc.data()["message"])
                  .toList();
              int urcount = 0;

              for (int i = 0; i < result.length; i++) {
                if (snapshot.data!.docs.elementAt(i)["rx"] ==
                        Provider.of<UserProvider>(context).getuser.uid &&
                    snapshot.data!.docs.elementAt(i)["read"] == "") {
                  urcount++;
                }
              }
              /////////////////
              if (urcount > 0) {
                FirebaseFirestore.instance
                    .collection("users")
                    .doc(Provider.of<UserProvider>(context, listen: false)
                        .getuser
                        .uid)
                    .update({"newmess": true});
              }

              return Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 230.0.w),
                    child: Text(result.last,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13.sp,
                            color: Colors.black54)),
                  ),
                  const Spacer(),
                  (snapshot.data!.docs.last["rx"] ==
                              Provider.of<UserProvider>(context).getuser.uid &&
                          snapshot.data!.docs.last["read"] == "")
                      ? Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 25.w,
                            minHeight: 25.h,
                          ),
                          child: Center(
                            child: Text(
                              "$urcount",
                              // "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox()
                  /////////////////////////////////////////////
                ],
              );
          }
        });
  }
}
