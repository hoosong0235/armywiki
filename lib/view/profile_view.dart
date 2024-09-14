import 'dart:async';

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
              padding: EdgeInsets.symmetric(
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
                      SizedBox(
                        width: 48,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "일병",
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
                                      userModel.enlist.month + 1,
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
                  SizedBox(
                    height: 48,
                  ),
                  Column(
                    children: [
                      buildProgress(
                        "전역",
                        "민간인",
                        DateTime(
                          2024,
                          3,
                          4,
                        ),
                        DateTime(
                          2025,
                          9,
                          3,
                        ),
                      ),
                      buildProgress(
                        "다음 계급",
                        "상병 1호봉",
                        DateTime(
                          now.year,
                          now.month,
                          1,
                        ),
                        DateTime(
                          2024,
                          12,
                          1,
                        ),
                      ),
                      buildProgress(
                        "다음 호봉",
                        "일병 5호봉",
                        DateTime(
                          now.year,
                          now.month,
                          1,
                        ),
                        DateTime(
                          now.year,
                          now.month + 1,
                          1,
                        ),
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
                  SizedBox(
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
                    child: Text(
                      "로그아웃",
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "No data",
              ),
            );
          }
        } else {
          return Center(
            child: Text(
              "No data",
            ),
          );
        }
      },
    );
  }
}

class buildProgress extends StatefulWidget {
  const buildProgress(
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
  State<buildProgress> createState() => _buildProgressState();
}

class _buildProgressState extends State<buildProgress> {
  @override
  void initState() {
    Timer.periodic(
      Duration(
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
