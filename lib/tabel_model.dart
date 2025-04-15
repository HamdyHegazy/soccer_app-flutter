import 'package:flutter/material.dart';

class GoalScorersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> goalscorers = [
    {"time": "90+1", "home_scorer": "M. Rogers"},
    {"time": "84", "away_scorer": "K. Coman"},
    {"time": "63", "away_scorer": "H. Kane"},
  ];

  GoalScorersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Goal Scorers"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: goalscorers.length,
        itemBuilder: (context, index) {
          final goal = goalscorers[index];
          String homeScorer = goal["home_scorer"] ?? "";
          String awayScorer = goal["away_scorer"] ?? "";
          String time = goal["time"] ?? "0";

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Home Scorer (Left)
                Expanded(
                  child: homeScorer.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.sports_soccer,
                                color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              homeScorer,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ),

                // Time (Center)
                Text(
                  "$time'",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),

                // Away Scorer (Right)
                Expanded(
                  child: awayScorer.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              awayScorer,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.sports_soccer,
                                color: Colors.green),
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
