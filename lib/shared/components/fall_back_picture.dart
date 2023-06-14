import 'package:find_my_ca/shared/providers/avatar_provider.dart';
import 'package:find_my_ca/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class FallBackPicture extends ConsumerWidget {
  final String name;
  const FallBackPicture({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(initialProvider(name)).when(
          data: (data) => ClipRRect(
              borderRadius: BorderRadius.circular(
                  (MediaQuery.of(context).size.width * 0.2)),
              child: Image.memory(
                data,
                fit: BoxFit.cover,
              )),
          error: (obj, err) => const Icon(Icons.person),
          loading: () => Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
          ),
        );
  }
}
