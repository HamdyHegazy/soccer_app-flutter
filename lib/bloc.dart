import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:premier_league_table/dio.dart';
import 'package:premier_league_table/matches.dart';
import 'package:premier_league_table/standings.dart';
import 'package:premier_league_table/states.dart';

class PLCubit extends Cubit<PLStates> {
  PLCubit() : super(PLInitialState());
  static PLCubit get(context) => BlocProvider.of(context);

  List<dynamic>? data = [];
  void getStandingData() async {
    emit(PLLoadingDataState());
    await DioHelper.getData(
        path: "/v4/soccer/scores/json/Standings/EPL/2025",
        params: {
          "key": "80c1bf4f15f946f8bd14317b5bb6aa45",
        }).then((value) {
      data = value.data[0]["Standings"];
      // print(data![0]);
      emit(PLGetDataState());
    }).catchError((e) {
      print(e);
      emit(PLErrorDataState());
    });
  }

  List<dynamic>? fixtureData = [];
  Timer? timer;

  void startFetchingFixtureData() {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getFixtureData();
    });
    getFixtureData();
  }

  DateTime currentDate = DateTime.now();
  void increaseDay() {
    currentDate = currentDate.add(const Duration(days: 1));
    getFixtureData();
    emit(IncreaseDayState());
  }

  void decreaseDay() {
    currentDate = currentDate.subtract(const Duration(days: 1));
    getFixtureData();
    emit(DecreaseDayState());
  }

  void getFixtureData() async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(currentDate);
    emit(PLLoadingFixtureDataState());
    await DioHelperr.getData(path: "/football/", params: {
      "met": "Fixtures",
      "APIkey":
          "7c54b5999093a67cfb5747afb11c3efd6441f22faf2184522d9275511f8add14",
      "from": formattedDate,
      "to": formattedDate,
      "leagueid": "152",
    }).then((value) {
      fixtureData = value.data["result"];
      emit(PLGetFixtureDataState());
    }).catchError((e) {
      print(e);
      emit(PLErrorFixtureDataState());
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  List<Widget> screens = [
    MatcheScreen(),
    const StandingScreen(),
  ];
  int currentIndex = 0;
  void navbarOnTap(int index) {
    currentIndex = index;
    emit(NavBar());
  }
}
