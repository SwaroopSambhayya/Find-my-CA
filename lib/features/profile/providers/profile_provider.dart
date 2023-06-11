import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:find_my_ca/shared/providers/database_provider.dart';
import 'package:find_my_ca/shared/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = FutureProvider<Profile?>((ref) async {
  String? userId = ref.watch(userIdProvider);
  if (userId != null) {
    final database = ref.read(databaseProvider);
    final profileData = await database.getDocument(
        databaseId: databaseId,
        collectionId: profileCollectionID,
        documentId: userId);
    final profile = Profile.fromMap(profileData.data);
    return profile;
  }
  return null;
});
