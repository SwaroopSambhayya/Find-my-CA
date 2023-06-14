import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1686343916755-9b411972c06e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=686&q=80'),
            ),
            title: Text("Hello you have a message!"),
            subtitle: Text("Please click to view customer request"),
            trailing: Text(
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
        itemCount: 10,
      ),
    );
  }
}
