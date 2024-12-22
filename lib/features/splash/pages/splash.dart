import 'package:eye2025/core/widgets/base_state_page.dart';
import 'package:eye2025/features/splash/cubit/splash_cubit.dart';
import 'package:eye2025/core/widgets/base_state_consumer.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    super.key,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends BaseStatePage<SplashPage, SplashCubit> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseStateConsumer(
      cubit: cubit,
      onLoading: (context) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
