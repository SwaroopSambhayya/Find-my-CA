import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/providers/appwrite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageProvider = Provider<Storage>((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Storage(client);
});
