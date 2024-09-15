import 'package:armywiki/controller/firebase_auth_controller.dart';
import 'package:armywiki/controller/get_unit_controller.dart';
import 'package:armywiki/controller/state_controller.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/utility/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(
    this.stateController, {
    super.key,
  });

  final StateController stateController;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String name = "";
  String email = "";
  String password = "";
  String passwordCheck = "";
  DateTime? enlist;
  String unitId = "";

  bool isNameValid = true;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isPasswordCheckValid = true;
  bool isEnlistValid = true;
  bool isUnitIdValid = true;

  UnitModel? unitModel;
  bool? isUnitIdVerified;

  bool validate() {
    isNameValid = name.isNotEmpty;
    isEmailValid = email.isNotEmpty && email.endsWith("@narasarang.or.kr");
    isPasswordValid = password.isNotEmpty;
    isPasswordCheckValid = password == passwordCheck;
    isEnlistValid = enlist != null;
    isUnitIdValid = unitId.isNotEmpty && (isUnitIdVerified ?? false);

    return isNameValid &&
        isEmailValid &&
        isPasswordValid &&
        isPasswordCheckValid &&
        isEnlistValid &&
        isUnitIdValid;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(
        16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextField(
                onChanged: (value) => name = value,
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: '홍길동',
                  errorText: isNameValid ? null : '이름을 입력해주세요.',
                  border: const OutlineInputBorder(),
                ),
              ),
              buildGap(),
              TextField(
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                  labelText: '나라사랑포털 이메일',
                  hintText: '@narasarang.or.kr',
                  errorText: isEmailValid ? null : '나라사랑포털 이메일을 입력해주세요.',
                  border: const OutlineInputBorder(),
                ),
              ),
              buildGap(),
              TextField(
                onChanged: (value) => password = value,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  errorText: isPasswordValid ? null : '비밀번호를 입력해주세요.',
                  border: const OutlineInputBorder(),
                ),
              ),
              buildGap(),
              TextField(
                onChanged: (value) => passwordCheck = value,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  errorText: isPasswordCheckValid ? null : '비밀번호가 일치하지 않습니다.',
                  border: const OutlineInputBorder(),
                ),
              ),
              buildGap(),
              TextField(
                controller: TextEditingController.fromValue(
                  enlist != null
                      ? TextEditingValue(
                          text: enlist!.toIso8601String().substring(
                                0,
                                10,
                              ),
                        )
                      : null,
                ),
                onTap: () async {
                  enlist = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020, 1, 1),
                        lastDate: DateTime(2029, 12, 31),
                        initialDate: enlist,
                      ) ??
                      enlist;

                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: '입대일',
                  errorText: isEnlistValid ? null : '입대일을 선택해주세요.',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      enlist = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2000, 1, 1),
                        lastDate: DateTime(2029, 12, 31),
                        initialDate: enlist,
                      );

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.today,
                    ),
                  ),
                ),
              ),
              buildGap(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    onChanged: (value) => unitId = value,
                    decoration: InputDecoration(
                      labelText: '부대코드',
                      errorText: isUnitIdValid ? null : '부대코드를 인증해주세요.',
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        isUnitIdVerified != null
                            ? isUnitIdVerified!
                                ? "${unitModel!.firstName} ${unitModel!.lastName}"
                                : "인증 실패"
                            : "",
                        style: textTheme.labelLarge?.copyWith(
                          color: isUnitIdVerified != null
                              ? isUnitIdVerified!
                                  ? colorScheme.onSurface
                                  : colorScheme.error
                              : null,
                        ),
                      ),
                      buildSmallGap(),
                      TextButton(
                        onPressed: () async {
                          UnitModel? unitModel =
                              await GetUnitController.getUnitNullable(
                            unitId,
                          );

                          setState(
                            () {
                              isUnitIdVerified = unitModel != null;
                              this.unitModel = unitModel;
                            },
                          );
                        },
                        child: const Text(
                          "인증",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    if (validate()) {
                      if (await FirebaseAuthController.register(
                        name,
                        email,
                        password,
                        Timestamp.fromDate(
                          enlist!,
                        ),
                        unitId,
                      )) {
                        widget.stateController.updateSelectedIndex(
                          2,
                        );
                      } else {
                        setState(() {});
                      }
                    } else {
                      setState(() {});
                    }
                  },
                  child: const Text(
                    "회원가입",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
