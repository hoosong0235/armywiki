import 'package:flutter/material.dart';
import 'package:armywiki/utility/color.dart';
import 'package:armywiki/utility/constant.dart';
import 'package:armywiki/utility/widget.dart';

class UnitReviewView extends StatefulWidget {
  const UnitReviewView({
    super.key,
  });

  @override
  State<UnitReviewView> createState() => _UnitReviewViewState();
}

class _UnitReviewViewState extends State<UnitReviewView> {
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
            hintText: "리뷰를 검색하세요.",
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
                  "235개 리뷰",
                  style: textTheme.titleSmall,
                ),
              ],
            ),
          ),
          buildGap(),
          ...List.generate(
            16,
            (
              index,
            ) =>
                Padding(
              padding: EdgeInsets.only(
                top: index == 0 ? 0 : 8,
                bottom: index == 16 ? 0 : 8,
              ),
              child: _buildReivewCard(),
            ),
          ),
          buildGap(),
        ],
      ),
    );
  }

  Container _buildReivewCard() {
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return Container(
      padding: cardEdgeInsets,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: cardBorderRadius,
        boxShadow: kElevationToShadow[1],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildChip(
            CircleAvatar(
              child: Image.asset(
                "assets/3d_avatar.png",
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Seungho Jang",
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "777사령부 510부대",
                  style: textTheme.labelLarge,
                ),
              ],
            ),
          ),
          Row(
            children: [
              _buildChip(
                Row(
                  children: [
                    ...List.generate(
                      3,
                      (
                        index,
                      ) =>
                          const Icon(
                        Icons.star,
                        color: Star,
                      ),
                    ),
                    ...List.generate(
                      2,
                      (
                        index,
                      ) =>
                          const Icon(
                        Icons.star_outline,
                        color: Star,
                      ),
                    ),
                  ],
                ),
                Text(
                  "3.5",
                  style: textTheme.labelLarge,
                ),
              ),
              _buildChip(
                const Icon(
                  Icons.today,
                ),
                Text(
                  "2024-03-04",
                  style: textTheme.labelLarge,
                ),
              ),
            ],
          ),
          buildSmallGap(),
          Text(
            "우리는 어둠 속에서 빛을 창조한다!",
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          buildSmallGap(),
          Text(
            "신호정보병은 겉으로 드러나는 화려함은 없지만, 정보전의 최전선에서 묵묵히 임무를 수행하는 숨은 영웅이라고 할 수 있습니다. 복잡한 장비를 다루고, 암호 같은 신호를 분석하는 과정은 결코 쉽지 않지만, 그만큼 보람도 큽니다.",
            style: textTheme.bodySmall,
          ),
          buildSmallGap(),
          Row(
            children: [
              _buildChip(
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.thumb_up,
                  ),
                ),
                Text(
                  "35",
                  style: textTheme.labelSmall,
                ),
              ),
              _buildChip(
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.thumb_down_outlined,
                  ),
                ),
                Text(
                  "2",
                  style: textTheme.labelSmall,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Padding _buildChip(
    Widget leading,
    Widget trailing,
  ) {
    return Padding(
      padding: chipEdgeInsets,
      child: Row(
        children: [
          leading,
          const SizedBox(
            width: 8,
          ),
          trailing,
        ],
      ),
    );
  }
}
