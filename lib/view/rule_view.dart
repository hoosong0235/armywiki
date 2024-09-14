import 'package:flutter/material.dart';
import 'package:armywiki/controller/get_rule_controller.dart';
import 'package:armywiki/model/rule_model.dart';
import 'package:armywiki/utility/color.dart';
import 'package:armywiki/utility/widget.dart';

class RuleView extends StatefulWidget {
  const RuleView({
    super.key,
  });

  @override
  State<RuleView> createState() => _RuleViewState();
}

class _RuleViewState extends State<RuleView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return FutureBuilder(
      future: GetRuleController.getRule(),
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
          RuleModel ruleModel = snapshot.data!;

          return ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: ROKAGradient,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 64,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ruleModel.headline,
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ruleModel.label,
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchBar(
                      hintText: "검색어를 입력하세요.",
                      trailing: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                          ),
                        ),
                      ],
                    ),
                    buildLargeGap(),
                    for (DisplayModel displayModel in ruleModel.displays)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayModel.display,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          buildSmallGap(),
                          for (HeadlineModel headlineModel
                              in displayModel.headlines)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  headlineModel.headline,
                                  style: textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                buildSmallGap(),
                                for (TitleModel titleModel
                                    in headlineModel.titles)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        titleModel.title,
                                        style: textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      buildSmallGap(),
                                      Text(
                                        titleModel.body,
                                        style: textTheme.bodySmall,
                                      ),
                                      buildSmallGap(),
                                    ],
                                  ),
                                buildGap(),
                              ],
                            ),
                          buildLargeGap(),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
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
}
