import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appWriteClientProvider = Provider<Client>(
    (ref) => Client().setEndpoint(appWriteBaseURl).setProject(projectID));
