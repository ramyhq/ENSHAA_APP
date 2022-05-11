import 'package:shared_preferences/shared_preferences.dart';


class Cashing {
  late SharedPreferences prefs ;


  init() async{
    print("init - Shared pref initialize called");
    prefs = await SharedPreferences.getInstance();
  }

  dynamic getMyData(String key) async {
    print("get - Shared pref called");
    return prefs.get(key);
  }

  setMyData(String key,String data) async {
    print("set - Shared pref called");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }



}

