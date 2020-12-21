import 'package:hive/hive.dart';

abstract class BaseBox<T> {
  Box _storageBox;

  Box<T> get storageBox => _storageBox;

  bool get boxIsClosed => !(_storageBox?.isOpen ?? false);

  // Abstract getters
  String get storageBoxName;

  Future<void> openBox() async {
    if (boxIsClosed) {
      _storageBox = await Hive.openBox<T>(storageBoxName);
    } else {
      _storageBox = Hive.box<T>(storageBoxName);
    }
    return;
  }

  Future<void> closeBox() async {
    return Hive.close();
  }
}
