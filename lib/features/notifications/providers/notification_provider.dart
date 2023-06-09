import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/models/notification_data.dart';
import 'package:find_my_ca/shared/providers/database_provider.dart';
import 'package:find_my_ca/shared/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationProvider = FutureProvider.autoDispose((ref) async {
  Databases database = ref.read(databaseProvider);

  DocumentList notifications = await database.listDocuments(
    databaseId: databaseId,
    collectionId: notificationCollectionId,
    queries: [
      Query.limit(25),
      Query.equal(
        'ca_id',
        ref.read(userIdProvider),
      )
    ],
  );
  List<NotificationData> notificationList = notifications.documents
      .map(
        (ele) => NotificationData.fromMap(ele.data),
      )
      .toList();
  return notificationList;
});
