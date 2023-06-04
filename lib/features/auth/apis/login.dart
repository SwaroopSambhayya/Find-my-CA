import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

Future<Session> login(String email, String password, Account account) async {
  print(email);
  return await account.createEmailSession(email: email, password: password);
}

Future logout(Account account) async {
  return await account.deleteSession(sessionId: 'current');
}
