import 'package:find_my_ca/shared/models/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Registration extends StateNotifier<Profile> {
  Registration() : super(const Profile());

  changeRegistrationState(Profile profile) {
    state = profile;
  }
}
