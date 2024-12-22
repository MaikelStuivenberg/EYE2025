import 'package:eye2025/app/injection.dart';
import 'package:eye2025/shared/bloc/common_cubit.dart';
import 'package:flutter/material.dart';

abstract class BaseStatePage<T extends StatefulWidget, C extends CommonCubit>
    extends State<T> {
  late final C cubit = getIt<C>();

  @override
  void initState() {
    super.initState();
    cubit.init();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  // C createCubit();
}
