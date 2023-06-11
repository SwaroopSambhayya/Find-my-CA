// ignore_for_file: avoid_print

import 'package:appwrite/appwrite.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:find_my_ca/features/auth/register/providers/registration_provider.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ProfileImagePicker extends ConsumerStatefulWidget {
  final bool loadImageInitially;
  final String? userId;
  const ProfileImagePicker(
      {super.key, this.loadImageInitially = false, this.userId});

  @override
  ProfileImagePickerState createState() => ProfileImagePickerState();
}

class ProfileImagePickerState extends ConsumerState<ProfileImagePicker> {
  String imageUrl = '';
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.loadImageInitially) {
      imageUrl = getImageUrl();
    }
  }

  String getImageUrl() {
    final userId = widget.userId ?? ref.read(registrationProvider).id;
    final imageUrl =
        "$appWriteBaseURl/storage/buckets/$profilePicBucketId/files/$userId/preview?project=$projectID";
    return imageUrl;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage =
        await picker.pickImage(source: source, imageQuality: 90);
    if (pickedImage != null) {
      final userId = ref.read(registrationProvider).id;
      await uploadImageToAppwrite(pickedImage.path, userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(imageUrl);
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          child: ClipOval(
            child: CachedNetworkImage(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              imageUrl: imageUrl,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                size: 32,
              ),
            ),
          ),
        ),
        InkWell(
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
        ),
      ],
    );
  }

  Future<void> uploadImageToAppwrite(String filePath, String userId) async {
    final storage = ref.read(storageProvider);
    final ProgressDialog pr = ProgressDialog(context: context);
    pr.show(
      max: 100,
      msg: uploadingImageMessage,
    );
    try {
      await storage.createFile(
        bucketId: profilePicBucketId,
        fileId: userId,
        file: InputFile.fromPath(path: filePath, filename: userId),
      );
      pr.close();
      setState(() {
        imageUrl = getImageUrl();
      });
    } on AppwriteException {
      // update image by deleting and uploading again
      await CachedNetworkImage.evictFromCache(imageUrl);
      await storage.deleteFile(
        bucketId: profilePicBucketId,
        fileId: userId,
      );
      await storage.createFile(
        bucketId: profilePicBucketId,
        fileId: userId,
        file: InputFile.fromPath(path: filePath, filename: userId),
      );
      pr.close();
      setState(() {
        imageUrl = getImageUrl();
      });
    } catch (e) {
      pr.close();
      print(e);
    }
  }
}
