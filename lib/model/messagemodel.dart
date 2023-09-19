import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String tx;
  final String rx;
  final Timestamp time;
  final String read;

  const Message({
    required this.message,
    required this.tx,
    required this.rx,
    required this.time,
    required this.read,
  });
  Map<String, dynamic> toJson() =>
      {"message": message, "tx": tx, "rx": rx, "time": time, "read": read};
  static Message fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Message(
        message: snapshot["message"],
        tx: snapshot["tx"],
        rx: snapshot["rx"],
        time: snapshot["time"],
        read: snapshot["read"]);
  }
}
