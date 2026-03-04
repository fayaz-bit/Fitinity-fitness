import 'package:hive/hive.dart';
import 'package:_app/models/usermodel.dart';

class AgeController {
  int selectedAge = 18;

  void setAge(int index) {
    selectedAge = 10 + index;
  }

  Future<void> saveAge() async {
    var box = await Hive.openBox<UserModel>('users');
    var user = box.get('currentUser');

    if (user != null) {
      user.age = selectedAge;
      await user.save();
    }
  }
}
