import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premier_league_table/bloc.dart';
import 'package:premier_league_table/states.dart';

class StandingScreen extends StatelessWidget {
  const StandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PLCubit, PLStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PLCubit.get(context).data;
        return Scaffold(
          body: cubit!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Column(
                  children: [
                    Container(
                      height: 35,
                      color: const Color(0xFF002E2E),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Pos",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Club",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 140,
                          ),
                          Text(
                            "PL",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 19,
                          ),
                          Text(
                            "W",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          Text(
                            "D",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "L",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "PTS",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            teamBuilder(cubit[index]),
                        separatorBuilder: (context, index) => Container(
                          height: 1,
                          color: Colors.white,
                        ),
                        itemCount: 20,
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  Widget teamBuilder(cubit) => Container(
        color:
            cubit!["Order"] == 1 ? Colors.amber[300] : const Color(0xFF002E2E),
        height: 40,
        child: Row(
          children: [
            Container(
              width: 10,
              color: color(cubit),
            ),
            SizedBox(
              width: 17,
              child: Text(
                "${cubit!["Order"]}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 102,
              child: Text(
                "${cubit!["ShortName"]}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 75,
            ),
            SizedBox(
              width: 17,
              child: Text(
                "${cubit!["Games"]}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 17,
              child: Text(
                "${cubit!["Wins"]}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 17,
              child: Text(
                "${cubit!["Draws"]}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: 17,
              child: Text(
                "${cubit!["Losses"]}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "${cubit!["Points"]}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
  Color color(cubit) {
    Color color = const Color(0xFF000000);
    if (cubit!["Order"] == 20 ||
        cubit!["Order"] == 19 ||
        cubit!["Order"] == 18) {
      color = Colors.red;
    } else if (cubit!["Order"] == 1 ||
        cubit!["Order"] == 2 ||
        cubit!["Order"] == 3 ||
        cubit!["Order"] == 4) {
      color = Colors.blue;
    }

    return color;
  }
}
