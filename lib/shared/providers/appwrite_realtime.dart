import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:find_my_ca/shared/providers/account_provider.dart';
import 'package:find_my_ca/shared/providers/appwrite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appWriteRealTimeProvider = Provider<Realtime>((ref) {
  Client client = ref.read(appWriteClientProvider);
  return Realtime(client);
});

final userSessonProvider = StreamProvider<RealtimeMessage>((ref) {
  Realtime realTime = ref.read(appWriteRealTimeProvider);
  final subscription = realTime.subscribe(['account']);
  subscription.stream.listen((event) {
    print(event.events);
  });
  return subscription.stream;
});

final authStateProvider = FutureProvider<User?>((ref) async {
  User? user = await ref.read(accountProvider).get();
  return user;
});

final authStateListener = StateProvider<List<String>>((ref) => []);
