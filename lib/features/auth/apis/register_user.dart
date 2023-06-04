import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:uuid/uuid.dart';

Future<User> registerNewUser(
    {required String email,
    required String password,
    required Account account,
    required Profile profile,
    required Databases database}) async {
  User user = await account.create(
    userId: ID.unique(),
    email: email,
    password: password,
  );
  profile =
      profile.copyWith(userId: user.$id, id: ID.custom(const Uuid().v1()));
  await createProfile(database, profile);
  return user;
}

Future<void> createProfile(Databases database, Profile profile) async {
  await database.createDocument(
      databaseId: databaseId,
      collectionId: profileCollectionID,
      documentId: profile.id!,
      data: profile.toMap());
}
