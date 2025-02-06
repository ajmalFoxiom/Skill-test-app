import 'package:get/get.dart';

import '../../core/service/api.dart';
import '../../core/service/urls.dart';

import '../../core/shared_preference/shared_pref.dart';

import '../model/profile.dart';

class MainController extends GetxController {
  final Rx<Profile?> profile = Profile().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await SharedPref().getUserToken();
  }

  Future<bool> getUserProfile() async {
    final response = await Api.call(
      endPoint: profileUrl,
      onRetryPressed: () => getUserProfile(),
    );
    if (response.success) {
      profile.value = Profile.fromJson(response.data);

      return true;
    }
    return false;
  }

}
