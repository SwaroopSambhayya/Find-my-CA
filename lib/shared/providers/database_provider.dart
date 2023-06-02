import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/providers/appwrite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final databaseProvider = Provider<Databases>((ref) {
  Client client = ref.read(appWriteClientProvider);
  return Databases(client);
});
