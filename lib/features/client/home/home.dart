import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_my_ca/features/client/home/providers/provider.dart';
import 'package:find_my_ca/features/profile/providers/profile_provider.dart';
import 'package:find_my_ca/shared/providers/route_const.dart';
import 'package:find_my_ca/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/const.dart';
import '../../../shared/models/profile.dart';
import '../../../shared/providers/account_provider.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          children: [
            ref.watch(profileProvider).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error: $err'),
                data: (data) {
                  return Text("Hi, ${data?.fname ?? ''}",
                      style: const TextStyle(
                          fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500));
                }),
            Text(homeHeading, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 30),
            const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const CategoryItems(),
            const Text("Top CA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            ref.watch(currentHomeProvider).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error: $err'),
                data: (data) {
                  return Column(
                      children: List.generate(
                          data.length, (i) => CaListItem(profileData: data, index: i)));
                })
          ],
        ),
      ),
    );
  }
}

class CategoryItems extends StatefulWidget {
  const CategoryItems({Key? key}) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            expertise.length,
            (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Row(
                    children: [
                      Card(
                        color: getBackgroundColor(index),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: backgroundColor, borderRadius: BorderRadius.circular(5)),
                                child:
                                    Icon(Icons.add_business, size: 18, color: getIconColor(index)),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                expertise[index],
                                style: TextStyle(color: getFontColor(index), fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                )),
      ),
    );
  }

  getBackgroundColor(index) {
    return selectedIndex == index ? primaryColor : secondaryColor;
  }

  getFontColor(index) {
    return selectedIndex == index ? secondaryColor : Colors.black45;
  }

  getIconColor(index) {
    return selectedIndex == index ? primaryColor : Colors.black45;
  }
}

class CaListItem extends StatelessWidget {
  final List<Profile>? profileData;
  final int? index;

  const CaListItem({Key? key, this.profileData, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("check data: ${profileData?.first.fname}");
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12)
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      "$appWriteBaseURl/storage/buckets/$profilePicBucketId/files/${profileData?[index!].userId}/preview?project=$projectID",
                  fit: BoxFit.fill,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(profileData?[index!].fname ?? '',
                              style: const TextStyle(fontSize: 12)),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: primaryColor.withOpacity(0.5),
                            ),
                            child: Text(profileData?[index!].expertise?.first ?? '',
                                style: TextStyle(fontSize: 12)),
                          )
                        ],
                      ),
                      Text(profileData?[index!].address ?? '',
                          style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      const Row(
                        children: [
                          Icon(Icons.star_rate, color: Colors.yellow, size: 16),
                          SizedBox(width: 5),
                          Text("4.8", style: TextStyle(fontSize: 10, color: Colors.grey))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
