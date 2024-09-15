import 'package:armywiki/controller/firebase_auth_controller.dart';
import 'package:armywiki/controller/state_controller.dart';
import 'package:armywiki/utility/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView(
    this.stateController, {
    super.key,
  });

  final StateController stateController;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email = "";
  String password = "";

  bool isEmailValid = true;
  bool isPasswordValid = true;

  bool validate() {
    isEmailValid = email.isNotEmpty && email.endsWith("@narasarang.or.kr");
    isPasswordValid = password.isNotEmpty;

    return isEmailValid && isPasswordValid;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/armywikiLarge.svg",
          ),
          const SizedBox(height: 48),
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
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    if (validate()) {
                      if (await FirebaseAuthController.login(
                        email,
                        password,
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
                    "로그인",
                  ),
                ),
              ),
            ],
          ),
          buildGap(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "아미위키가 처음이신가요?",
                style: textTheme.labelLarge,
              ),
              TextButton(
                onPressed: () => widget.stateController.updateSelectedIndex(
                  1,
                ),
                child: const Text(
                  "회원가입",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
