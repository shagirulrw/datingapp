// import 'package:datingapp/method/firebase_methods.dart';
// import 'package:datingapp/screens/explorepage.dart';
import 'package:flutter/cupertino.dart';

enum CardStatus { swiperight, swipeleft }

class CardProvider extends ChangeNotifier {
  int index = 0;

  //////////////////////////////////
  void incrementindex() {
    // index++;
    if (index >= 5) {
      index = 0;
    } else {
      ++index;
    }
    notifyListeners();
  }

  void indexreset() {
    index = 0;
    notifyListeners();
  }

  void decrementindex() {
    // index--;
    if (index <= 0) {
      index = 5;
    } else {
      --index;
    }
    notifyListeners();
  }

  bool _isDragging = true;
  int _speed = 0;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;
  /////////////////
  // List<Question> duplicatelist = question;
  // int _currentcardindex = 0;
  // int get currentindex => _currentcardindex;
  /////////////////
  Offset get postion => _position;
  bool get isDragging => _isDragging;
  double get angle => _angle;
  int get speed => _speed;
  ///////////////////////////////

  ////////////////////
  void setScreenSize(Size screenSize) {
    _screenSize = screenSize;
    notifyListeners();
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    _speed = 0;
    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;
    final x = _position.dx;
    final y = _position.dy;
    _angle = 10 * x / _screenSize.width;
    ///////////////////
    const delta = 20;
    // if (x >= delta
    //     // y >= delta ||
    //     // !(duplicatelist.elementAt(currentindex).islocked)
    //     ) {
    //   // reset2();
    // }
    ///////////////
    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    notifyListeners();
    final status = getStatus();
    switch (status) {
      case CardStatus.swiperight:
        //////////////////
        // resetPosition();
        swipeRight();
        break;
      case CardStatus.swipeleft:
        swipeLeft();
        break;
      default:
    }
    // resetPosition();
  }

  CardStatus? getStatus() {
    final x = _position.dx;
    const delta = 100;
    if (x > delta) {
      print("right");
      ///////////////
      // reset2();
      return CardStatus.swiperight;
    } else if (x <= -delta) {
      print("left");
      _isDragging = false;
      return CardStatus.swipeleft;
    } else {
      reset2();
    }
    return null;
  }

  void resetPosition() {
    // _isDragging = true;
    _speed = 0;
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  void reset2() {
    // _isDragging = false;
    _speed = 300;
    notifyListeners();
    _position = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  void swipeRight() {
    _speed = 700;
    // _isDragging = false;
    // notifyListeners();
    _angle = 30;
    _position += Offset(_screenSize.width * 2, 0);
    notifyListeners();
    nextCard();

    // print("button right");
  }

  void swipeLeft() {
    _speed = 700;
    // _isDragging = false;
    _angle = -30;

    _position -= Offset(_screenSize.width * 2, 0);
    notifyListeners();
    // reset2();
    nextCard();

    // print("button left");
  }

  void nextCard() async {
    await Future.delayed(const Duration(milliseconds: 200));

    notifyListeners();
    resetPosition();

    return;
  }
}
