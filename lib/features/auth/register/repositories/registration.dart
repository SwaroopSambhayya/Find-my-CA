import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';

class Registration extends StateNotifier<Profile> {
  Registration() : super(const Profile()) {
    init();
  }

  init() async {
    state = state.copyWith(id: ID.custom(const Uuid().v1()));
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
    state = state.copyWith(token: token);
  }

  changeRegistrationState(Profile profile) {
    state = profile;
  }

  updateUserId(String userId) {
    state = state.copyWith(userId: userId);
  }

  updateRoleType(RoleType roletype) {
    state = state.copyWith(roletype: roletype);
  }

  updateRegType(CARegistererType registererType) {
    state = state.copyWith(registererType: registererType);
  }

  updateId(String id) {
    state = state.copyWith(id: id);
  }

  changeExpertise(List<String> expertise) {
    state = state.copyWith(expertise: [...expertise]);
  }

  changeFname(String name) {
    state = state.copyWith(fname: name);
  }

  changeLname(String name) {
    state = state.copyWith(lname: name);
  }

  changeEmail(String email) {
    state = state.copyWith(email: email);
  }

  changePhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  changeAge(int age) {
    state = state.copyWith(age: age);
  }

  changeDescription(String description) {
    state = state.copyWith(profileDescription: description);
  }

  changeAddress(String address) {
    state = state.copyWith(address: address);
  }

  changeCountry(String country) {
    state = state.copyWith(country: country);
  }

  changeCity(String city) {
    state = state.copyWith(city: city);
  }

  changeUPI(String upi) {
    state = state.copyWith(upiId: upi);
  }

  changeLatLng(LocationData data) {
    state = state.copyWith(
        geoLat: data.latitude.toString(), geoLong: data.longitude.toString());
  }

  reset() {
    state = const Profile();
  }
}
