import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ConfigProvider with ChangeNotifier {
  Map<String, bool> _featureToggles = Map()
    ..addAll({
      'enableButtonGoogle': true,
      'enableButtonFacebook': true,
    });
  FirebaseDatabase _database;
  
  ConfigProvider() {
    _database = FirebaseDatabase.instance;
    _database.reference().child('/featureToggle').once().then((snapshot) {
      _featureToggles.clear();
      _featureToggles.addAll({
        'enableButtonGoogle': snapshot.value['enableButtonGoogle'],
        'enableButtonFacebook': snapshot.value['enableButtonFacebook'],
      });
      notifyListeners();
    });
  }

  Map<String, bool> get featureToggles => _featureToggles;
  
}
