import 'package:find_my_ca/shared/enums.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Status status;
  final String message;
  const CustomDialog({super.key, required this.status, required this.message});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      children: [
        if (status == Status.sucess)
          Icon(
            Icons.check_circle,
            color: Theme.of(context).primaryColor,
            size: 80,
          ),
        if (status == Status.error)
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 80,
          ),
        if (status == Status.loading)
          Center(
            child: Container(
                margin: const EdgeInsets.all(20),
                child: const CircularProgressIndicator()),
          ),
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}
