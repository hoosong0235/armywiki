import 'package:flutter/material.dart';
import 'package:armywiki/controller/get_unit_rule_controller.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/model/unit_rule_model.dart';
import 'package:armywiki/utility/widget.dart';

class UnitRuleView extends StatefulWidget {
  const UnitRuleView(
    this.unitModel, {
    super.key,
  });

  final UnitModel unitModel;

  @override
  State<UnitRuleView> createState() => _UnitRuleViewState();
}

class _UnitRuleViewState extends State<UnitRuleView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: FutureBuilder(
        future: GetUnitRuleController.getRule(
          widget.unitModel.unitId,
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
            UnitRuleModel unitRuleModel = snapshot.data!;

            return ListView(
              children: [
                buildGap(),
                for (TitleModel titleModel in unitRuleModel.unitRules)
                  Column(
                    children: [
                      _buildParagraph(
                        titleModel,
                      ),
                      buildLargeGap(),
                    ],
                  ),
                buildGap(),
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
      ),
    );
  }

  Column _buildParagraph(
    TitleModel titleModel,
  ) {
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleModel.title,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "편집",
              ),
            ),
          ],
        ),
        buildSmallGap(),
        Text(
          titleModel.body,
          style: textTheme.bodySmall,
        ),
      ],
    );
  }
}
