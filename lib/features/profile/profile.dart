// ignore_for_file: unused_field
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/features/client/home/components/logout_button.dart';
import 'package:find_my_ca/features/profile/providers/profile_provider.dart';
import 'package:find_my_ca/shared/components/two_line_widget.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/providers/route_const.dart';
import 'package:find_my_ca/shared/theme.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../shared/components/google_maps/google_maps_widget.dart';
import '../../shared/providers/location_provider.dart';

class UserProfile extends ConsumerStatefulWidget {
  static String get routeName => '/profile';
  static String get routeLocation => 'profile';

  const UserProfile({
    super.key,
  });

  @override
  ConsumerState<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends ConsumerState<UserProfile> {
  late Profile userProfile;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return const [
                PopupMenuItem(
                  value: 1,
                  child: Text("Edit Profile"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: LogoutButton(),
                ),
              ];
            },
            onSelected: (value) async {
              if (value == 1) {
                final initialProfile = userProfile;
                final regProvider = ref.read(registrationProvider.notifier);
                Location location = ref.read(locationProvider);
                LocationData locationDetail = await location.getLocation();
                regProvider.changeLatLng(locationDetail);
                regProvider.changeUPI(initialProfile.upiId ?? "");
                regProvider.changePhone(initialProfile.phone ?? "");

                regProvider.changeLname(initialProfile.lname ?? "");

                regProvider.changeFname(initialProfile.fname ?? "");
                regProvider.changeExpertise(initialProfile.expertise ?? []);
                regProvider.changeEmail(initialProfile.email ?? "");
                regProvider
                    .changeDescription(initialProfile.profileDescription ?? "");
                regProvider.changeCountry(initialProfile.country ?? "");
                regProvider.changeCity(initialProfile.city ?? "");
                regProvider.changeAge(initialProfile.age ?? 0);
                regProvider.changeAddress(initialProfile.address ?? "");
                regProvider.updateUserId(initialProfile.userId ?? "");
                regProvider.updateRoleType(initialProfile.roletype);
                regProvider.updateRegType(initialProfile.registererType);
                regProvider.updateId(initialProfile.id ?? "");
                context.push(editProfile, extra: userProfile);
              } else if (value == 2) {
                // TODO: replace with logout
              }
            },
          ),
        ],
      ),
      body: ref.watch(profileProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error: $err'),
            data: (data) {
              userProfile = data!;
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                child: Container(
                  margin: const EdgeInsets.all(4).copyWith(bottom: 8),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.36,
                        child: Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "$appWriteBaseURl/storage/buckets/$profilePicBucketId/files/${userProfile.id}/preview?project=$projectID",
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                width: double.infinity,
                                child: Card(
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(
                                        "${userProfile.fname} ${userProfile.lname}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      subtitle: Visibility(
                                        visible:
                                            userProfile.roletype == RoleType.ca,
                                        child: Text(
                                          "Chartered Accountant",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      trailing: Visibility(
                                        visible:
                                            userProfile.roletype == RoleType.ca,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: primaryColor,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              //TODO: replace with widget.profile.rating
                                              "4.5",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: userProfile.roletype == RoleType.ca,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            elevation: 4,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 16),
                              //TODO: replace with data
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TwoLineWidget("Experience", "8 yrs"),
                                  TwoLineWidget("Consultations", "398"),
                                  TwoLineWidget("Ratings", "120"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Visibility(
                          visible: userProfile.roletype == RoleType.ca,
                          replacement: const Text("About User"),
                          child: Text(
                            "About Chartered Accountant",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: userProfile.profileDescription != null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            userProfile.profileDescription!,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Location",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Card(
                          elevation: 4,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: GoogleMapsWidget(
                              LatLng(
                                getDoubleValue(userProfile.geoLat),
                                getDoubleValue(userProfile.geoLat),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
