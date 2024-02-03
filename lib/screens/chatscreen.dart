import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datingapp/method/firebase_methods.dart';
import 'package:datingapp/model/usermodel.dart';
import 'package:datingapp/screens/explorepage.dart';

import 'package:datingapp/widgets/Emailtextfield.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../model/messagemodel.dart';
import '../provider/user_provider.dart';

class ChatScreen extends StatefulWidget {
  final doc;
  final name;
  final photo;

  const ChatScreen({
    Key? key,
    required String this.doc,
    required String this.name,
    required String this.photo,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //for storing all messages
  final List<Message> _list = [];

  //for handling message text changes
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Users currentuser = Provider.of<UserProvider>(context).getuser;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          //app bar
          appBar: AppBar(
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${widget.photo}"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(widget.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15.sp)),
              ],
            ),
            elevation: 0,
            backgroundColor: primarycolor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Ionicons.arrow_back_outline,
                  size: 30,
                  color: Colors.black,
                )),
          ),

          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("chats")
                      .doc(widget.doc)
                      .collection("message")
                      .orderBy('time', descending: true)
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    switch (snapshot.connectionState) {
                      //if data is loading
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox();

                      //if some or all data is loaded then show it
                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasData) {
                          return ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              // padding: EdgeInsets.only(top: mq.height * .01),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                String tx = snapshot.data!.docs[index]["tx"];
                                ///////////////////////////////////////////////
                                Timestamp date =
                                    snapshot.data!.docs[index]["time"];

                                final DateTime date1 =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        date.millisecondsSinceEpoch);
                                String time = DateFormat('hh:mm a')
                                    .format(date1)
                                    .toString();
                                ////////////////////////////////
                                String messageid = snapshot
                                    .data!.docs[index].reference.id
                                    .toString();
///////////////////////////////////////////////////////////////////////////////
                                if (currentuser.uid != tx &&
                                    snapshot.data!.docs[index]["read"] == "") {
                                  FirebaseFirestore.instance
                                      .collection("chats")
                                      .doc(widget.doc)
                                      .collection("message")
                                      .doc(messageid)
                                      .update({
                                    'read': DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString()
                                  });
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(currentuser.uid)
                                      .update({"newmess": false});
                                }
                                return ListTile(
                                  title: Row(
                                    mainAxisAlignment: (tx == currentuser.uid)
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            minWidth: 10.w, maxWidth: 260.w),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h, horizontal: 10.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5.w,
                                                color: Colors.black),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data!.docs[index]["message"]}",
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  time,
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),
                                                (tx == currentuser.uid)
                                                    ? Icon(
                                                        Ionicons
                                                            .checkmark_done_outline,
                                                        size: 20,
                                                        color: snapshot.data!
                                                                            .docs[
                                                                        index]
                                                                    ["read"] ==
                                                                ""
                                                            ? Colors.black54
                                                            : primarycolor,
                                                      )
                                                    : const SizedBox()
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: Text('Say Hii! 👋',
                                style: TextStyle(fontSize: 20)),
                          );
                        }
                    }
                  },
                ),
              ),
              Container(
                color: primarycolor,
                height: 76.h,
                width: double.infinity,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 300.w,
                      child: customtextfield(
                          height: 60.h,
                          width: 300.w,
                          radius: 8,
                          obscure: false,
                          hint: "Text Message",
                          controller: messageController),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    IconButton(
                        onPressed: () async {
                          if (messageController.text.isNotEmpty) {
                            await FirebaseMethod().sendmessage(
                                currentuid: currentuser.uid,
                                message: messageController.text.trim(),
                                targetuid: FirebaseMethod().roomcodedecode(
                                    code: widget.doc,
                                    currentuserid: currentuser.uid),
                                context: context,
                                roomid: widget.doc);
                            messageController.clear();
                          }
                        },
                        icon: const Icon(Ionicons.send_sharp))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
