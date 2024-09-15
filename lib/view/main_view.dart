import 'package:armywiki/controller/state_controller.dart';
import 'package:armywiki/view/profile_view.dart';
import 'package:armywiki/view/register_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:armywiki/view/army_wiki_view.dart';
import 'package:armywiki/view/login_view.dart';
import 'package:armywiki/view/rule_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({
    super.key,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

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
      body: [
        const ArmyWikiView(),
        const RuleView(),
        GetBuilder<StateController>(
          init: StateController(),
          builder: (StateController stateController) => [
            LoginView(
              stateController,
            ),
            RegisterView(
              stateController,
            ),
            ProfileView(
              stateController,
            ),
          ][stateController.selectedIndex],
        ),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(
              CupertinoIcons.globe,
            ),
            label: "아미위키",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.article_outlined,
            ),
            selectedIcon: Icon(
              Icons.article,
            ),
            label: "육군규정",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
            ),
            selectedIcon: Icon(
              Icons.person,
            ),
            label: "프로필",
          )
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (
          value,
        ) =>
            setState(
          () => _selectedIndex = value,
        ),
      ),
    );
  }
}
