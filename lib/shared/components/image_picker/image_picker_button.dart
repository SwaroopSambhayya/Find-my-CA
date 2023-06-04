// ignore_for_file: unused_field

import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerButton extends ConsumerStatefulWidget {
  const ImagePickerButton({super.key});

  @override
  ImagePickerButtonState createState() => ImagePickerButtonState();
}

class ImagePickerButtonState extends ConsumerState<ImagePickerButton> {
  final ImagePicker picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage != null) {
      final userId = ref.read(registrationProvider).id;
      await uploadImageToAppwrite(pickedImage.path, userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Select photo source'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: const Icon(
          Icons.edit,
          size: 26,
        ),
      ),
    );
  }

  Future<void> uploadImageToAppwrite(String filePath, String userId) async {
    final storage = ref.read(storageProvider);
    await storage.createFile(
      bucketId: profilePicBucketId,
      fileId: userId,
      file: InputFile.fromPath(path: filePath, filename: 'userId-profile.jpg'),
    );
  }
}
