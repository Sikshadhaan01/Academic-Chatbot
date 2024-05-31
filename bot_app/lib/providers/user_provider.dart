import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  var userInfo;
  get getUserInfo => userInfo;

  setUserInfo(info){
    userInfo = info;
    notifyListeners();
  }

  removeUserInfo(){
    userInfo=null;
    notifyListeners();
  }
}