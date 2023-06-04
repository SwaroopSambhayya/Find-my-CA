import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class DottedButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const DottedButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor.withOpacity(0.4),
      onTap: onTap,
      child: DottedBorder(
        strokeCap: StrokeCap.round,
        strokeWidth: 1.2,
        radius: const Radius.circular(10),
        padding: const EdgeInsets.all(0),
        color: Theme.of(context).primaryColor,
        dashPattern: const [7, 5],
        child: Ink(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          padding: const EdgeInsets.all(8),
          child: Text(
            label,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
