import 'package:appwrite/appwrite.dart';
import 'package:find_my_ca/shared/components/custom_dialog.dart';
import 'package:find_my_ca/shared/const.dart';
import 'package:find_my_ca/shared/enums.dart';
import 'package:find_my_ca/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue<void> {
  // isLoading shorthand (AsyncLoading is a subclass of AsycValue)
  bool get isLoading => this is AsyncLoading<void>;

  // show a snackbar on error only
  void showLiveStatus(BuildContext context, PageController controller) =>
      whenOrNull(
        loading: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
                status: Status.loading, message: registrationLoading),
          );
        },
        data: (data) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
                status: Status.sucess, message: registrationSuccess),
          );
          controller.animateToPage(0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
        error: (error, _) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: ErrorText(
              error: error,
            )),
          );
        },
      );
}

class ErrorText extends StatelessWidget {
  final dynamic error;
  const ErrorText({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Text(error is AppwriteException
        ? getErrorBasedOnType(error.type)
        : error.toString());
  }
}
