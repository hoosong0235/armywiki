import 'dart:async';
import 'dart:math';

import 'package:armywiki/controller/cloud_firestore_controller.dart';
import 'package:armywiki/controller/firebase_auth_controller.dart';
import 'package:armywiki/controller/get_unit_controller.dart';
import 'package:armywiki/controller/get_units_controller.dart';
import 'package:armywiki/controller/state_controller.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/model/user_model.dart';
import 'package:armywiki/utility/unit_list_tile.dart';
import 'package:armywiki/utility/widget.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView(
    this.stateController, {
    super.key,
  });

  final StateController stateController;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final textTheme = Theme.of(context).textTheme;
    DateTime now = DateTime.now();

    return FutureBuilder(
      future: CloudFirestoreController.fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error: ${snapshot.error}",
            ),
          );
        } else if (snapshot.hasData) {
          bool data = snapshot.data!;

          if (data) {
            UserModel userModel = CloudFirestoreController.userModel!;

            return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView(
                  children: [
                    buildGap(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          child: Image.asset(
                            "assets/3d_avatar.png",
                          ),
                        ),
                        const SizedBox(
                          width: 48,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _getCurrStepString(userModel.enlist, now),
                                  style: textTheme.headlineSmall,
                                ),
                                buildSmallGap(),
                                Text(
                                  userModel.name,
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            buildGap(),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "입대",
                                      style: textTheme.labelLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    buildSmallGap(),
                                    Text(
                                      userModel.enlist
                                          .toIso8601String()
                                          .substring(
                                            0,
                                            10,
                                          ),
                                      style: textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "전역",
                                      style: textTheme.labelLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    buildSmallGap(),
                                    Text(
                                      DateTime(
                                        userModel.enlist.year + 1,
                                        userModel.enlist.month + 6,
                                        userModel.enlist.day - 1,
                                      ).toIso8601String().substring(
                                            0,
                                            10,
                                          ),
                                      style: textTheme.labelLarge,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Column(
                      children: [
                        BuildProgress(
                          "전역",
                          "민간인",
                          userModel.enlist,
                          DateTime(
                            userModel.enlist.year + 1,
                            userModel.enlist.month + 6,
                            userModel.enlist.day - 1,
                          ),
                        ),
                        BuildProgress(
                          "다음 계급",
                          _getNextRankString(userModel.enlist, now),
                          _getCurrRankDateTime(userModel.enlist, now),
                          _getNextRankDateTime(userModel.enlist, now),
                        ),
                        BuildProgress(
                          "다음 호봉",
                          _getNextStepString(userModel.enlist, now),
                          DateTime(
                            now.year,
                            now.month,
                            1,
                          ),
                          _getNextStepDateTime(userModel.enlist, now),
                        ),
                      ],
                    ),
                    buildGap(),
                    SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          Text(
                            "내 부대",
                            style: textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    buildGap(),
                    FutureBuilder(
                      future: GetUnitController.getUnit(
                        userModel.unitId,
                      ),
                      builder: (
                        context,
                        snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                            ),
                          );
                        } else if (snapshot.hasData) {
                          UnitModel unitModel = snapshot.data!;

                          return UnitListTile(
                            unitModel,
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "No data",
                            ),
                          );
                        }
                      },
                    ),
                    buildGap(),
                    SizedBox(
                      height: 56,
                      child: Row(
                        children: [
                          Text(
                            "관심 부대",
                            style: textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    buildGap(),
                    FutureBuilder(
                      future: GetUnitsController.getUnits(
                        userModel.unitIds,
                      ),
                      builder: (
                        context,
                        snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                            ),
                          );
                        } else if (snapshot.hasData) {
                          List<UnitModel> unitModels = snapshot.data!;

                          return Column(
                            children: List.generate(
                              unitModels.length,
                              (
                                index,
                              ) =>
                                  UnitListTile(
                                unitModels[index],
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "No data",
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    TextButton(
                      onPressed: () async {
                        if (await FirebaseAuthController.logout()) {
                          widget.stateController.updateSelectedIndex(
                            0,
                          );
                        } else {
                          setState(() {});
                        }
                      },
                      child: const Text(
                        "로그아웃",
                      ),
                    ),
                    buildGap(),
                  ],
                ));
          } else {
            return const Center(
              child: Text(
                "No data",
              ),
            );
          }
        } else {
          return const Center(
            child: Text(
              "No data",
            ),
          );
        }
      },
    );
  }

  int _getServedMonth(DateTime enlist, DateTime now) {
    return max(
      0,
      12 * (now.year - enlist.year) +
          (now.month - enlist.month) -
          (enlist.day == 1 ? 0 : 1),
    );
  }

  DateTime _getCurrRankDateTime(DateTime enlist, DateTime now) {
    int servedMonth = _getServedMonth(enlist, now);
    int currRankMonth = servedMonth < 3
        ? 0
        : servedMonth < 9
            ? 3
            : servedMonth < 15
                ? 9
                : 15;

    return currRankMonth == 0
        ? enlist
        : DateTime(
            enlist.year,
            enlist.month + currRankMonth,
            1,
          );
  }

  DateTime _getNextStepDateTime(DateTime enlist, DateTime now) {
    return DateTime(
      now.year,
      now.month + 1,
      1,
    );
  }

  DateTime _getNextRankDateTime(DateTime enlist, DateTime now) {
    int servedMonth = _getServedMonth(enlist, now);
    int nextRankMonth = servedMonth < 3
        ? 3
        : servedMonth < 9
            ? 9
            : servedMonth < 15
                ? 15
                : 0;

    return nextRankMonth == 0
        ? DateTime(
            enlist.year + 1,
            enlist.month + 6,
            enlist.day - 1,
          )
        : DateTime(
            enlist.year,
            enlist.month + nextRankMonth - (enlist.day == 1 ? 1 : 0),
            1,
          );
  }

  String _getCurrStepString(DateTime enlist, DateTime now) {
    int servedMonth = _getServedMonth(enlist, now);

    return [
      "이병",
      "이병",
      "일병",
      "일병",
      "일병",
      "일병",
      "일병",
      "일병",
      "상병",
      "상병",
      "상병",
      "상병",
      "상병",
      "상병",
      "병장",
      "병장",
      "병장",
      "병장",
    ][servedMonth];
  }

  String _getNextRankString(DateTime enlist, DateTime now) {
    int servedMonth = _getServedMonth(enlist, now);

    return [
      "일병 1호봉",
      "일병 1호봉",
      "상병 1호봉",
      "상병 1호봉",
      "상병 1호봉",
      "상병 1호봉",
      "상병 1호봉",
      "상병 1호봉",
      "병장 1호봉",
      "병장 1호봉",
      "병장 1호봉",
      "병장 1호봉",
      "병장 1호봉",
      "병장 1호봉",
      "민간인",
      "민간인",
      "민간인",
      "민간인",
    ][servedMonth];
  }

  String _getNextStepString(DateTime enlist, DateTime now) {
    int servedMonth = _getServedMonth(enlist, now);

    return [
      "이병 2호봉",
      "일병 1호봉",
      "일병 2호봉",
      "일병 3호봉",
      "일병 4호봉",
      "일병 5호봉",
      "일병 6호봉",
      "상병 1호봉",
      "상병 2호봉",
      "상병 3호봉",
      "상병 4호봉",
      "상병 5호봉",
      "상병 6호봉",
      "병장 1호봉",
      "병장 2호봉",
      "병장 3호봉",
      "병장 4호봉",
      "민간인",
    ][servedMonth];
  }
}

class BuildProgress extends StatefulWidget {
  const BuildProgress(
    this.title,
    this.body,
    this.from,
    this.to, {
    super.key,
  });

  final String title;
  final String body;
  final DateTime from;
  final DateTime to;

  @override
  State<BuildProgress> createState() => _BuildProgressState();
}

class _BuildProgressState extends State<BuildProgress> {
  @override
  void initState() {
    Timer.periodic(
      const Duration(
        microseconds: 1,
      ),
      (timer) {
        setState(
          () {},
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    DateTime now = DateTime.now();
    double perc = now.difference(widget.from).inMicroseconds /
        widget.to.difference(widget.from).inMicroseconds;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.body,
                  style: textTheme.labelSmall,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "D-${widget.to.difference(now).inDays}",
                  style: textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.to.toIso8601String().substring(
                        0,
                        10,
                      ),
                  style: textTheme.labelSmall,
                ),
              ],
            )
          ],
        ),
        LinearProgressIndicator(
          value: perc,
        ),
        Text(
          (perc * 100).toStringAsFixed(
            6,
          ),
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
