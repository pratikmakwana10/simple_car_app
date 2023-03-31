
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtils{
SharedPreferences? _preferences;
static SharedPreferenceUtils? sharedPreferenceUtils;

 Future initializePreference() async {
  _preferences = await SharedPreferences.getInstance();
}
static SharedPreferenceUtils getInstance() {
  return sharedPreferenceUtils ??= SharedPreferenceUtils();
}
setData(String key, dynamic value){
  _preferences!.setStringList(key, value);
}

List<String>? getStringList(String key, ){
  return _preferences?.getStringList(key);


}
getString(String key){
  return _preferences?.getString(key);
}

removeString(String key){
  return _preferences?.remove(key);
}
}