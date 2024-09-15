import 'package:flutter/material.dart';
import 'package:armywiki/controller/search_units_controller.dart';
import 'package:armywiki/utility/unit_list_tile.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/utility/widget.dart';

class ArmyWikiView extends StatefulWidget {
  const ArmyWikiView({
    super.key,
  });

  @override
  State<ArmyWikiView> createState() => _ArmyWikiViewState();
}

class _ArmyWikiViewState extends State<ArmyWikiView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: ListView(
        children: [
          buildGap(),
          SearchBar(
            hintText: "부대를 검색하세요.",
            trailing: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
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
                  "전체 부대",
                  style: textTheme.titleSmall,
                ),
              ],
            ),
          ),
          buildGap(),
          FutureBuilder(
            future: SearchUnitsController.searchUnits(
              "",
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
        ],
      ),
    );
  }
}
