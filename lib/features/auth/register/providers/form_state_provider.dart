import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formStateProvider =
    Provider<GlobalKey<FormState>>((ref) => GlobalKey<FormState>());
