import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() => _instance;

  HiveManager._internal();

  static const String userBoxName = 'loginData';

  // static const String settingsBoxName = 'settingsBox';

  Future<void> init() async {
    // Hive.initFlutter();
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);

    // Register adapters here
    // Hive.registerAdapter(UserAdapter());

    await Hive.openBox(userBoxName);
    // await Hive.openBox(settingsBoxName);
  }

  Box get userBox => Hive.box(userBoxName);

  // Box get settingsBox => Hive.box(settingsBoxName);

  // Utility getters/setters
  dynamic getUser(String key) => userBox.get(key);

  Future<void> setUser(String key, dynamic value) => userBox.put(key, value);

  dynamic deleteUser(String key) => userBox.delete(key);
}
