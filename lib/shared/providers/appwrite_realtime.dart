import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/providers/appwrite_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appWriteRealTimeProvider = Provider<Realtime>((ref) {
  Client client = ref.read(appWriteClientProvider);
  return Realtime(client);
});

final userSessionProvider = StateProvider<List<String>>((ref) {
  Realtime realTime = ref.read(appWriteRealTimeProvider);
  List<String> events = [];
  final subscription = realTime.subscribe(['account']);
  subscription.stream.listen((event) {
    events = event.events;
  });
  return events;
});

final authStateListener = StateProvider<List<String>>((ref) => []);
