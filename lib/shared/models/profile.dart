import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:find_my_ca/shared/utils.dart';

class Profile {
  final String? id;
  final String? userId;
  final String? fname;
  final String? lname;
  final RoleType roletype;
  final List<dynamic>? expertise;
  final int? ratings;
  final String? phone;
  final String? email;
  final String? address;
  final String? geoLat;
  final String? geoLong;
  final CARegistererType registererType;
  final String? profileDescription;
  final int? age;
  final String? gender;

  const Profile({
    this.id,
    this.userId,
    this.fname,
    this.lname,
    this.roletype = RoleType.none,
    this.expertise,
    this.ratings,
    this.phone,
    this.email,
    this.address,
    this.geoLat,
    this.geoLong,
    this.registererType = CARegistererType.none,
    this.profileDescription,
    this.age,
    this.gender,
  });

  factory Profile.fromMap(Map<String, dynamic> data) => Profile(
        id: data['id'] as String?,
        userId: data['userId'] as String?,
        fname: data['fname'] as String?,
        lname: data['lname'] as String?,
        roletype: data['roletype'] as RoleType,
        expertise: data['expertise'] as List<dynamic>?,
        ratings: data['ratings'] as int?,
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        address: data['address'] as String?,
        geoLat: data['geoLat'] as String?,
        geoLong: data['geoLong'] as String?,
        registererType: data['registererType'] as CARegistererType,
        profileDescription: data['profileDescription'] as String?,
        age: data['age'] as int?,
        gender: data['gender'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'fname': fname,
        'lname': lname,
        'roletype': roletype,
        'expertise': expertise,
        'ratings': ratings,
        'phone': phone,
        'email': email,
        'address': address,
        'geoLat': geoLat,
        'geoLong': geoLong,
        'registererType': registererType,
        'profileDescription': profileDescription,
        'age': age,
        'gender': gender,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Profile].
  factory Profile.fromJson(String data) {
    return Profile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Profile] to a JSON string.
  String toJson() => json.encode(toMap());

  Profile copyWith({
    String? id,
    String? userId,
    String? fname,
    String? lname,
    RoleType? roletype,
    List<dynamic>? expertise,
    int? ratings,
    String? phone,
    String? email,
    String? address,
    String? geoLat,
    String? geoLong,
    CARegistererType? registererType,
    String? profileDescription,
    int? age,
    String? gender,
  }) {
    return Profile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      roletype: roletype ?? this.roletype,
      expertise: expertise ?? this.expertise,
      ratings: ratings ?? this.ratings,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      geoLat: geoLat ?? this.geoLat,
      geoLong: geoLong ?? this.geoLong,
      registererType: registererType ?? this.registererType,
      profileDescription: profileDescription ?? this.profileDescription,
      age: age ?? this.age,
      gender: gender ?? this.gender,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Profile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      fname.hashCode ^
      lname.hashCode ^
      roletype.hashCode ^
      expertise.hashCode ^
      ratings.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      address.hashCode ^
      geoLat.hashCode ^
      geoLong.hashCode ^
      registererType.hashCode ^
      profileDescription.hashCode ^
      age.hashCode ^
      gender.hashCode;
}
