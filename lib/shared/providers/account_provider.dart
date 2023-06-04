import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/providers/appwrite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountProvider = Provider<Account>(
  (ref) => Account(
    ref.read(appWriteClientProvider),
  ),
);
