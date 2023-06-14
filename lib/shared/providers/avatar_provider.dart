import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/providers/appwrite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialProvider =
    FutureProvider.family<Uint8List, String>((ref, name) async {
  Client client = ref.read(appWriteClientProvider);
  Avatars avatar = Avatars(client);
  return await avatar.getInitials(name: name);
});
