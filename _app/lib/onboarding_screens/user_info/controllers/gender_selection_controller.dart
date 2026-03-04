import 'package:hive/hive.dart';
import 'package:_app/models/usermodel.dart';

class GenderSelectionController {
  String selectedGender = "";

  void selectGender(String gender) {
    selectedGender = gender;
  }

  Future<void> saveGenderToHive() async {
    var box = await Hive.openBox<UserModel>('users');
    var user = box.get('currentUser');

    if (user != null) {
      user.gender = selectedGender;
      await user.save();
    }
  }

  bool get isSelected => selectedGender.isNotEmpty;
}
