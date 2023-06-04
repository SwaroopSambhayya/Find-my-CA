import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_my_ca/features/auth/providers/password_provider.dart';
import 'package:find_my_ca/features/auth/register/components/expertise_card.dart';
import 'package:find_my_ca/features/auth/register/providers/form_state_provider.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/features/auth/register/utils.dart';
import 'package:find_my_ca/shared/components/image_picker/image_picker_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/providers/location_provider.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class EnterDetails extends ConsumerWidget {
  const EnterDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(registrationProvider.select((value) => value.roletype)) ==
            RoleType.ca
        ? const CAForm()
        : const ClientForm();
  }
}

class CAForm extends ConsumerStatefulWidget {
  const CAForm({super.key});

  @override
  ConsumerState<CAForm> createState() => _CAFormState();
}

class _CAFormState extends ConsumerState<CAForm> {
  bool isExpertiseFieldActive = false;

  @override
  Widget build(BuildContext context) {
    List<String> expertises =
        ref.watch(registrationProvider.select((value) => value.expertise)) ??
            [];
    List<String> availableExpertises = ref.watch(availableExpertiseProvider);

    return Form(
      key: ref.read(formStateProvider),
      child: Column(
        children: [
          const CommonForm(),
          ExpertiseCard(
              availableExpertises: availableExpertises,
              expertises: expertises,
              ref: ref),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextFormField(
              validator: (val) => membershipValidator(
                  ref.read(registrationProvider).registererType, val),
              decoration: getInputDecoration(
                  hintText: ref.read(registrationProvider).registererType ==
                          CARegistererType.sole
                      ? "Membership number of 6 digits"
                      : "Firm Number of 7 digits",
                  iconData: Icons.numbers),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextFormField(
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

class CommonForm extends ConsumerStatefulWidget {
  const CommonForm({
    super.key,
  });

  @override
  ConsumerState<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends ConsumerState<CommonForm> {
  late TextEditingController address;
  late TextEditingController country;
  late TextEditingController city;
  bool showPassword = false;

  @override
  void initState() {
    initializeControllers();
    super.initState();
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
        Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              child: CachedNetworkImage(
                imageUrl:
                    "$appWriteBaseURl/storage/buckets/$profilePicBucketId/files/${ref.read(registrationProvider).id}/view",
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.person,
                  size: 32,
                ),
              ),
            ),
            const ImagePickerButton()
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: TextFormField(
            obscureText: !showPassword,
            onChanged: (value) {
              ref.read(passwordProvider.notifier).state = value;
            },
            validator: passwordValidator,
            decoration: getInputDecoration(
                suffixOnTap: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                hintText: "Create new password",
                iconData:
                    showPassword ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ],
    );
  }
}

class ClientForm extends ConsumerWidget {
  const ClientForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: ref.read(formStateProvider),
      child: const CommonForm(),
    );
  }
}
