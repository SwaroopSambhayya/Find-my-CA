// ignore_for_file: unused_field
import 'package:find_my_ca/features/auth/register/components/expertise_card.dart';
import 'package:find_my_ca/features/auth/register/providers/form_state_provider.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/features/auth/register/utils.dart';
import 'package:find_my_ca/shared/components/profile_image_picker.dart';

import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/providers/location_provider.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:find_my_ca/shared/models/profile.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class EditProfile extends ConsumerStatefulWidget {
  static String get routeName => '/editProfile';
  static String get routeLocation => 'editProfile';
  final Profile profile;

  const EditProfile({
    super.key,
    required this.profile,
  });

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.profile.roletype;
    final buildWidget = role == RoleType.ca
        ? CAEditForm(profile: widget.profile)
        : ClientEditForm(profile: widget.profile);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        child: Container(
          margin: const EdgeInsets.all(14),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 12),
              buildWidget,
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  final editedProfile = ref.read(registrationProvider);
                  ref
                      .read(registrationAuthProvider.notifier)
                      .editProfile(editedProfile);
                },
                child: const Text(
                  "Edit",
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class CAEditForm extends ConsumerStatefulWidget {
  final Profile profile;
  const CAEditForm({super.key, required this.profile});

  @override
  ConsumerState<CAEditForm> createState() => _CAEditFormState();
}

class _CAEditFormState extends ConsumerState<CAEditForm> {
  bool isExpertiseFieldActive = false;

  @override
  Widget build(BuildContext context) {
    List<String> expertises = widget.profile.expertise ?? [];

    List<String> availableExpertises = ref.watch(availableExpertiseProvider);

    return Form(
      key: ref.read(formStateProvider),
      child: Column(
        children: [
          CommonEditForm(profile: widget.profile),
          ExpertiseCard(
              availableExpertises: availableExpertises,
              expertises: expertises,
              ref: ref),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextFormField(
              initialValue: widget.profile.upiId,
              validator: upiValidator,
              onChanged: (value) {
                ref.read(registrationProvider.notifier).changeUPI(value);
              },
              decoration: getInputDecoration(
                  hintText: "UPI ID", iconData: Icons.payment),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonEditForm extends ConsumerStatefulWidget {
  final Profile profile;
  const CommonEditForm({
    super.key,
    required this.profile,
  });

  @override
  ConsumerState<CommonEditForm> createState() => _CommonEditFormState();
}

class _CommonEditFormState extends ConsumerState<CommonEditForm> {
  late TextEditingController address;
  late TextEditingController country;
  late TextEditingController city;
  bool showPassword = false;

  @override
  void initState() {
    initializeControllers();
    super.initState();
    address.text = widget.profile.address!;
    country.text = widget.profile.country!;
    city.text = widget.profile.city!;
  }

  initializeControllers() {
    address = TextEditingController();
    country = TextEditingController();
    city = TextEditingController();
    fillLocation();
  }

  @override
  void dispose() {
    address.dispose();
    country.dispose();
    city.dispose();
    super.dispose();
  }

  void fillLocation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GoogleGeocodingResult? result = ref.watch(currentLocation);
      if (result is GoogleGeocodingResult) {
        List<String> formElements = getAddressCityCountry(result);
        address.text = formElements[0];

        city.text = formElements[1];
        country.text = formElements[2];
        ref.read(registrationProvider.notifier).changeRegistrationState(ref
            .read(registrationProvider)
            .copyWith(
                address: formElements[0],
                city: formElements[1],
                country: formElements[2]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImagePicker(
          loadImageInitially: true,
          userId: widget.profile.id,
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                initialValue: widget.profile.fname,
                onChanged: (value) {
                  ref.read(registrationProvider.notifier).changeFname(value);
                },
                decoration: getInputDecoration(
                    hintText: "First Name", iconData: Icons.person),
                validator: emptyValidators,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextFormField(
                initialValue: widget.profile.lname,
                onChanged: (value) {
                  ref.read(registrationProvider.notifier).changeLname(value);
                },
                decoration: getInputDecoration(
                    hintText: "Last Name", iconData: Icons.person),
                validator: emptyValidators,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: widget.profile.email,
                  validator: emailValidator,
                  onChanged: (value) {
                    ref.read(registrationProvider.notifier).changeEmail(value);
                  },
                  decoration: getInputDecoration(
                      hintText: "Email", iconData: Icons.email),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextFormField(
                  initialValue: widget.profile.phone,
                  validator: phoneValidator,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    ref.read(registrationProvider.notifier).changePhone(value);
                  },
                  decoration: getInputDecoration(
                      hintText: "Phone", iconData: Icons.phone_android),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: TextFormField(
            initialValue: widget.profile.profileDescription,
            keyboardType: TextInputType.text,
            maxLines: 4,
            onChanged: (value) {
              ref.read(registrationProvider.notifier).changeDescription(value);
            },
            decoration: getInputDecoration(
                hintText: "About you", iconData: Icons.description),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: TextFormField(
            initialValue: widget.profile.age.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref
                  .read(registrationProvider.notifier)
                  .changeAge(int.parse(value));
            },
            validator: ageValidator,
            decoration:
                getInputDecoration(hintText: "Age", iconData: Icons.numbers),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: TextFormField(
            //initialValue: widget.profile.address,

            controller: address,
            onChanged: (value) {
              ref.read(registrationProvider.notifier).changeAddress(value);
            },
            validator: emptyValidators,
            decoration: getInputDecoration(
                hintText: "Address", iconData: Icons.my_location),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  // initialValue: widget.profile.country,
                  controller: country,
                  onChanged: (value) {
                    ref
                        .read(registrationProvider.notifier)
                        .changeCountry(value);
                  },
                  validator: emptyValidators,
                  decoration: getInputDecoration(
                      hintText: "Country", iconData: Icons.flag_outlined),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextFormField(
                  // initialValue: widget.profile.city,
                  controller: city,
                  onChanged: (value) {
                    ref.read(registrationProvider.notifier).changeCity(value);
                  },
                  validator: emptyValidators,
                  decoration: getInputDecoration(
                      hintText: "City", iconData: Icons.location_city_rounded),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ClientEditForm extends ConsumerWidget {
  final Profile profile;
  const ClientEditForm({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(formStateProvider),
      child: CommonEditForm(profile: profile),
    );
  }
}
