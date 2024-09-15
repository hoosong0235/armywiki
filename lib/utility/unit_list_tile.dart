import 'package:armywiki/controller/cloud_firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/view/unit_view.dart';

class UnitListTile extends StatefulWidget {
  const UnitListTile(
    this.unitModel, {
    this.isLarge = false,
    super.key,
  });

  final UnitModel unitModel;
  final bool isLarge;

  @override
  State<UnitListTile> createState() => _UnitListTileState();
}

class _UnitListTileState extends State<UnitListTile> {
  @override
  Widget build(
    BuildContext context,
  ) {
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return ListTile(
      leading: SizedBox(
        width: 56,
        height: 56,
        child: SvgPicture.network(
          widget.unitModel.imageUrl,
        ),
      ),
      title: Text(
        widget.unitModel.firstName,
        style: textTheme.labelMedium,
      ),
      subtitle: Text(
        widget.unitModel.lastName,
        style: textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: CloudFirestoreController.isFavorite(widget.unitModel.unitId)
          ? IconButton(
              onPressed: () {
                setState(() {
                  CloudFirestoreController.removeUnit(
                    widget.unitModel.unitId,
                  );
                });
              },
              icon: const Icon(
                Icons.bookmark,
              ),
            )
          : IconButton(
              onPressed: () {
                setState(() {
                  CloudFirestoreController.addUnit(
                    widget.unitModel.unitId,
                  );
                });
              },
              icon: const Icon(
                Icons.bookmark_outline,
              ),
            ),
      onTap: () => Get.to(
        UnitView(
          widget.unitModel,
        ),
      ),
      enabled: !widget.isLarge,
    );
  }
}
