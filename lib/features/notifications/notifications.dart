import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_my_ca/features/notifications/providers/notification_provider.dart';
import 'package:find_my_ca/shared/components/fall_back_picture.dart';
import 'package:find_my_ca/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class Notifications extends ConsumerWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationList = ref.watch(notificationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: notificationList.when(
          data: (data) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: data[index].profilePic == null
                      ? FallBackPicture(name: data[index].customerName ?? "")
                      : CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            data[index].profilePic!,
                            errorListener: () {
                              print(data[index].profilePic);
                            },
                          ),
                        ),
                  title: Text(data[index].title ?? ""),
                  subtitle: Text(data[index].body ?? ""),
                  trailing: const Text(
                    "5m ago",
                    style: TextStyle(height: -3),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 9,
                );
              },
              itemCount: data.length,
            );
          },
          error: (error, stackTrace) {
            return const Center(
              child: Text("Could not load notifications, something went wrong"),
            );
          },
          loading: () => Shimmer.fromColors(
                loop: 1,
                baseColor: Colors.grey,
                highlightColor: backgroundColor,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                ),
              )),
    );
  }
}
