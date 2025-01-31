import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubits/theme_cubit/theme_cubit.dart';
import 'package:news_app/core/helpers/extensions.dart';
import 'package:news_app/core/helpers/size_config.dart';
import 'package:news_app/core/routing/routes.dart';
import 'package:news_app/features/news/presentation/widgets/home_screen_widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: homeAppBar(context),
      body: const HomeScreenBody(),
    );
  }

  AppBar homeAppBar(BuildContext context) {
    return AppBar(
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'News',
          ),
          Text('Cloud', style: TextStyle(color: Colors.orange)),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.search);
          },
          icon: const Icon(
            Icons.search,
          ),
        ),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: Icon(
                  state == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
            );
          },
        ),
      ],
    );
  }
}