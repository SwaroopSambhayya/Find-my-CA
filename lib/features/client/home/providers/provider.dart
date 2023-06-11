import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/features/client/home/home.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/const.dart';
import '../../../../shared/providers/database_provider.dart';

final homeProvider = Provider.autoDispose<Home>((ref) => const Home());

final currentHomeProvider = FutureProvider<List<Profile>>((ref) async {
  final database = ref.read(databaseProvider);
  try {
    final data = await database.listDocuments(
      databaseId: databaseId,
      collectionId: profileCollectionID,
      queries: [Query.equal('roletype', 'ca')],
    );
    final documents = data.documents;
    final profileList = documents.map((e) => Profile.fromMap(e.data)).toList();
    return profileList;
  } catch (e) {
    print(e);
    return [];
  }
});

final currentHome = StateProvider<List<Profile>?>((ref) => null);
