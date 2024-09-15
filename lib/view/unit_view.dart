import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/utility/color.dart';
import 'package:armywiki/utility/unit_list_tile.dart';
import 'package:armywiki/view/ai_view.dart';
import 'package:armywiki/view/unit_article_view.dart';
import 'package:armywiki/view/unit_review_view.dart';
import 'package:armywiki/view/unit_rule_view.dart';

class UnitView extends StatefulWidget {
  const UnitView(
    this.unitModel, {
    super.key,
  });

  final UnitModel unitModel;

  @override
  State<UnitView> createState() => _UnitViewState();
}

class _UnitViewState extends State<UnitView> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/armywikiSmall.svg",
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          UnitListTile(
            widget.unitModel,
            isLarge: true,
          ),
          TabBar.secondary(
            controller: tabController,
            tabs: const [
              Tab(
                text: "규정",
              ),
              Tab(
                text: "리뷰",
              ),
              Tab(
                text: "게시글",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                UnitRuleView(
                  widget.unitModel,
                ),
                const UnitReviewView(),
                const UnitArticleView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => Get.to(
          AiView(
            widget.unitModel,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              28,
            ),
            gradient: GeminiGradientDiagonal,
          ),
          child: Center(
            child: SvgPicture.asset(
              "assets/gemini_logo.svg",
            ),
          ),
        ),
      ),
    );
  }
}
