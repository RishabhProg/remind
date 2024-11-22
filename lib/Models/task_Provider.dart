import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class taskProvider extends ChangeNotifier {
  String? _name;
  String? get name => _name;

  String? _imgUrl;
  String? get imgUrl => _imgUrl;

  Future<void> getInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('UserName');
    _imgUrl = prefs.getString('ImgUrl');

    notifyListeners();
  }
  


 
}
