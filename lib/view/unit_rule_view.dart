import 'dart:ui';

import 'package:armywiki/controller/cloud_firestore_controller.dart';
import 'package:armywiki/controller/firebase_auth_controller.dart';
import 'package:armywiki/controller/update_unit_rule_controller.dart';
import 'package:flutter/material.dart';
import 'package:armywiki/controller/get_unit_rule_controller.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/model/unit_rule_model.dart';
import 'package:armywiki/utility/widget.dart';
import 'package:get/get.dart';

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
  bool isUpdating = false;
  bool isAdding = false;
  bool isTitleValid = true;
  bool isBodyValid = true;

  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController bodyTextEditingController = TextEditingController();
  TitleModel updatingTitleModel = TitleModel(
    null,
    null,
  );

  bool validate() {
    isTitleValid = titleTextEditingController.text.isNotEmpty;
    isBodyValid = bodyTextEditingController.text.isNotEmpty;

    return isTitleValid && isBodyValid;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
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
            bool isBelongedTo = CloudFirestoreController.isBelongedTo(
              widget.unitModel.unitId,
            );

            return Stack(
              alignment: Alignment.center,
              children: [
                _buildListView(
                  snapshot,
                ),
                if (!isBelongedTo) _buildBackdropFilter(),
                if (!isBelongedTo) _buildColumn(),
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

  Column _buildColumn() {
    bool authenticated = FirebaseAuthController.authenticated;
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.lock,
          size: 96,
        ),
        buildGap(),
        Text(
          authenticated
              ? "소속되지 않은 부대의 규정은\n열람할 수 없습니다."
              : "부대 코드를 인증하고\n아미위키 AI를 이용해보세요!",
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        if (!authenticated) buildGap(),
        if (!authenticated)
          FilledButton(
            onPressed: () => Get.back(),
            child: const Text(
              "로그인",
            ),
          ),
      ],
    );
  }

  BackdropFilter _buildBackdropFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        color: Colors.black.withOpacity(
          0,
        ),
      ),
    );
  }

  ListView _buildListView(AsyncSnapshot<UnitRuleModel> snapshot) {
    UnitRuleModel unitRuleModel = snapshot.data!;

    return ListView(
      children: [
        buildGap(),
        for (TitleModel titleModel in unitRuleModel.unitRules)
          Column(
            children: [
              isUpdating && titleModel == updatingTitleModel
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildUpdateParagraph(),
                        buildSmallGap(),
                        Row(
                          children: [
                            Expanded(
                              child: _buildCancelButton(),
                            ),
                            buildGap(),
                            Expanded(
                              child: _buildSaveButton(
                                unitRuleModel,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : _buildParagraph(
                      titleModel,
                    ),
              buildLargeGap(),
            ],
          ),
        isAdding
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildUpdateParagraph(),
                  buildSmallGap(),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCancelButton(),
                      ),
                      buildGap(),
                      Expanded(
                        child: _buildSaveButton(
                          unitRuleModel,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : _buildAddButton(),
        buildGap(),
      ],
    );
  }

  TextButton _buildUpdateButton(TitleModel titleModel) {
    return TextButton(
      onPressed: () {
        setState(() {
          updatingTitleModel = titleModel;
          titleTextEditingController.text = updatingTitleModel.title;
          bodyTextEditingController.text = updatingTitleModel.body;
          isTitleValid = true;
          isBodyValid = true;
          isUpdating = true;
          isAdding = false;
        });
      },
      child: const Text(
        "편집",
      ),
    );
  }

  FilledButton _buildAddButton() {
    return FilledButton(
      onPressed: () {
        setState(() {
          updatingTitleModel = TitleModel(
            null,
            null,
          );
          titleTextEditingController.text = updatingTitleModel.title;
          bodyTextEditingController.text = updatingTitleModel.body;
          isTitleValid = true;
          isBodyValid = true;
          isUpdating = false;
          isAdding = true;
        });
      },
      child: const Text(
        "추가",
      ),
    );
  }

  OutlinedButton _buildCancelButton() {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          isTitleValid = true;
          isBodyValid = true;
          isUpdating = false;
          isAdding = false;
        });
      },
      child: const Text(
        "취소",
      ),
    );
  }

  FilledButton _buildSaveButton(UnitRuleModel unitRuleModel) {
    return FilledButton(
      onPressed: () async {
        if (validate()) {
          if (isUpdating) {
            unitRuleModel.unitRules[unitRuleModel.unitRules.indexOf(
              updatingTitleModel,
            )] = TitleModel(
              titleTextEditingController.text,
              bodyTextEditingController.text,
            );
          }

          if (isAdding) {
            unitRuleModel.unitRules.add(
              TitleModel(
                titleTextEditingController.text,
                bodyTextEditingController.text,
              ),
            );
          }

          await UpdateUnitRuleController.updateRule(
            widget.unitModel.unitId,
            unitRuleModel,
          );

          isTitleValid = true;
          isBodyValid = true;
          isUpdating = false;
          isAdding = false;
        }

        setState(() {});
      },
      child: const Text(
        "저장",
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
            _buildUpdateButton(titleModel),
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

  Column _buildUpdateParagraph() {
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return Column(
      children: [
        TextField(
          controller: titleTextEditingController,
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            labelText: '제목',
            errorText: isTitleValid ? null : '제목을 입력해주세요.',
            border: const OutlineInputBorder(),
          ),
        ),
        buildSmallGap(),
        TextField(
          controller: bodyTextEditingController,
          style: textTheme.bodySmall,
          decoration: InputDecoration(
            labelText: '내용',
            errorText: isBodyValid ? null : '내용을 입력해주세요.',
            border: const OutlineInputBorder(),
          ),
          maxLines: 8,
        ),
      ],
    );
  }
}
