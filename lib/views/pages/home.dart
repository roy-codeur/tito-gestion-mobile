import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubits/home_cubit.dart';
import '../screens/home/histories_screen.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../screens/home/activities_screen.dart';
import '../screens/home/profile_screen.dart';
import '../screens/home/home_screen.dart';

class HomePage extends StatelessWidget {

  static String tag = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Home();
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.index,
            children: const [HomeScreen(), HistoriesScreen(),ActivitiesScreen(), ProfileScreen()],
          );
        }
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }

}
