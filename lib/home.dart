import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:premier_league_table/bloc.dart';
import 'package:premier_league_table/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PLCubit()
        ..getStandingData()
        ..startFetchingFixtureData(),
      child: BlocConsumer<PLCubit, PLStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = PLCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF002E2E),
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 20),
              title: cubit.currentIndex == 0
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            cubit.decreaseDay();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.increaseDay();
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          DateFormat("yyyy-MM-dd").format(cubit.currentDate),
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  : const Text("Premier League Table"),
              actions: [Image.asset("assets/images/applogo.png")],
            ),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: false,
              backgroundColor: const Color(0xFF002E2E),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.view_timeline_sharp), label: "Fixtures"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.table_rows_rounded), label: "Standings"),
              ],
              currentIndex: PLCubit.get(context).currentIndex,
              onTap: (index) {
                cubit.navbarOnTap(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
