import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MatchEventsScreen extends StatelessWidget {
  const MatchEventsScreen(this.cubit, {super.key});
  final cubit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 220,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image.asset(
                  "assets/images/R.jpeg",
                  width: double.infinity,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      cubit["country_name"],
                      style: const TextStyle(
                          color: Colors.cyanAccent, fontSize: 15),
                    ),
                    Text(
                      cubit["event_date"],
                      style: TextStyle(
                          color: Colors.cyanAccent[100], fontSize: 12),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                cubit["event_home_team"],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              CachedNetworkImage(
                                imageUrl: cubit["home_team_logo"],
                                placeholder: (context, url) =>
                                    Image.asset("assets/images/teamlogo.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/teamlogo.png"),
                                height: 60,
                                width: 60,
                              )
                            ],
                          ),
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
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                cubit["event_away_team"],
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              CachedNetworkImage(
                                imageUrl: cubit["away_team_logo"],
                                placeholder: (context, url) =>
                                    Image.asset("assets/images/teamlogo.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/teamlogo.png"),
                                height: 60,
                                width: 60,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              height: (cubit["goalscorers"].length) * 60.0,
              decoration: BoxDecoration(
                color: const Color(0xFF002E2E),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.separated(
                  reverse: true,
                  itemBuilder: (context, index) =>
                      eventsBox(cubit["goalscorers"][index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 2,
                      ),
                  itemCount: cubit["goalscorers"].length),
            ),
          )
        ],
      ),
    );
  }

  Widget eventsBox(events) => SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: events["home_scorer"] != ""
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                events["home_scorer"],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                events["home_assist"],
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.sports_soccer_outlined,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color.fromARGB(255, 28, 123, 123),
              child: Text(
                events["time"],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: events["away_scorer"] != ""
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.sports_soccer_outlined,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                events["away_scorer"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                events["away_assist"],
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      );
}
