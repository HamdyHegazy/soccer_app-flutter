import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premier_league_table/bloc.dart';
import 'package:premier_league_table/matchevents.dart';
import 'package:premier_league_table/states.dart';

class MatcheScreen extends StatelessWidget {
  MatcheScreen({super.key});

  final List<String> targetLeagues = [
    "La Liga",
    "Seria A",
    "Premier League - Regular Season",
    "FA Cup",
    "UEFA Europa League - League Stage",
    "UEFA Champions League - League Stage",
    "Saudi League",
    "Bundesliga",
    "Ligue 1",
    "Premier League",
    "CAF Champions League - Group Stage",
    "Liga 1 - Regular Season",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PLCubit, PLStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = PLCubit.get(context);
        List<dynamic> list = [];
        for (var fixture in cubit.fixtureData ?? []) {
          String league = fixture["league_name"];
          String country = fixture["country_name"];

          if (targetLeagues.contains(league)) {
            // Additional country checks for specific leagues
            if ((league == "Ligue 1" && country != "France") ||
                (league == "Premier League" && country != "England") ||
                (league == "Premier League - Regular Season" &&
                    country != "Egypt")) {
              continue;
            }
            list.add(fixture);
          }
        }
        // for (int i = 0; i < cubit.fixtureData!.length; i++) {
        //   if (cubit.fixtureData![i]["league_name"] == "La Liga" ||
        //       cubit.fixtureData![i]["league_name"] == "Serie A" ||
        //       cubit.fixtureData![i]["league_name"] == "FA Cup" ||
        //       cubit.fixtureData![i]["league_name"] ==
        //           "UEFA Europa League - League Stage" ||
        //       cubit.fixtureData![i]["league_name"] ==
        //           "UEFA Champions League - League Stage" ||
        //       cubit.fixtureData![i]["league_name"] == "Saudi League" ||
        //       cubit.fixtureData![i]["league_name"] == "Bundesliga" ||
        //       cubit.fixtureData![i]["league_name"] == "Ligue 1" &&
        //           cubit.fixtureData![i]["country_name"] == "France" ||
        //       cubit.fixtureData![i]["league_name"] == "Premier League" &&
        //           cubit.fixtureData![i]["country_name"] == "England" ||
        //       cubit.fixtureData![i]["league_name"] ==
        //               "Premier League - Regular Season" &&
        //           cubit.fixtureData![i]["country_name"] == "Egypt") {
        //     list.add(cubit.fixtureData![i]);
        //   } else {
        //     continue;
        //   }
        // }
        return Scaffold(
            backgroundColor: const Color(0xFF000000),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: bodyBuilder(cubit.fixtureData, list)));
      },
    );
  }

  Widget MatchBuilder(cubit, context) => Column(
        children: [
          Container(
            height: 35,
            decoration: const BoxDecoration(
              color: Color(0xFF002E2E),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                CachedNetworkImage(
                  fit: BoxFit.contain,
                  height: 30,
                  width: 30,
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/teamlogo.png"),
                  imageUrl: cubit["league_logo"] ?? cubit["country_logo"],
                  placeholder: (context, url) =>
                      Image.asset("assets/images/teamlogo.png"),
                ),
                // Image(
                //   fit: BoxFit.contain,
                //   height: 30,
                //   width: 30,
                //   image: NetworkImage(
                //       cubit["league_logo"] ?? cubit["country_logo"]),
                // ),

                Text(
                  cubit["league_name"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MatchEventsScreen(cubit),
                  ));
            },
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF002E2E),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            cubit["event_home_team"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        CachedNetworkImage(
                          imageUrl: cubit["home_team_logo"],
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/teamlogo.png"),
                          placeholder: (context, url) =>
                              Image.asset("assets/images/teamlogo.png"),
                          width: 30,
                          height: 30,
                        ),
                        // Image.network(
                        //   cubit["home_team_logo"],
                        //   width: 30,
                        //   height: 30,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  cubit["event_live"] == "1"
                      ? Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cubit["event_status"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                cubit["event_final_result"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          cubit["event_status"] == "Finished"
                              ? cubit["event_final_result"]
                              : cubit["event_time"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: cubit["away_team_logo"],
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/teamlogo.png"),
                          placeholder: (context, url) =>
                              Image.asset("assets/images/teamlogo.png"),
                          width: 30,
                          height: 30,
                        ),
                        // Image.network(
                        //   cubit["away_team_logo"],
                        //   width: 30,
                        //   height: 30,
                        // ),
                        const SizedBox(
                          width: 6,
                        ),
                        Flexible(
                          child: Text(
                            // maxLines: 2,
                            // overflow: TextOverflow.ellipsis,
                            cubit["event_away_team"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Widget bodyBuilder(List<dynamic>? fixtureList, List<dynamic> list) {
    Widget widget;
    if (fixtureList!.isEmpty) {
      widget = const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    } else if (list.isEmpty) {
      widget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/sad.webp"),
            const Text(
              "No Important Matches For ToDay",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      );
    } else {
      widget = ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => MatchBuilder(list[index], context),
          separatorBuilder: (context, index) => const SizedBox(
                height: 15,
              ),
          itemCount: list.length);
    }
    return widget;
  }
}
