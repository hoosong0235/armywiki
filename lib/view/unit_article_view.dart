import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:armywiki/utility/constant.dart';
import 'package:armywiki/utility/widget.dart';

class UnitArticleView extends StatefulWidget {
  const UnitArticleView({
    super.key,
  });

  @override
  State<UnitArticleView> createState() => _UnitArticleViewState();
}

class _UnitArticleViewState extends State<UnitArticleView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    TextTheme textTheme = Theme.of(
      context,
    ).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: ListView(
        children: [
          buildGap(),
          SearchBar(
            hintText: "게시글을 검색하세요.",
            trailing: [
              IconButton(
                onPressed: () {},
                icon: Icon(
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
                  "235개 게시글",
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
                Icon(
                  CupertinoIcons.eye,
                ),
                Text(
                  "235",
                  style: textTheme.labelLarge,
                ),
              ),
              _buildChip(
                Icon(
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
            "신호정보/전자전운용 어떤가요?",
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          buildSmallGap(),
          Text(
            "안녕하세요, 카이스트 전산학부 4학년에 재학중인 대학생입니다. 대학원 진학과 입대 중에 고민하다 결국 입대를 결정하게 되었는데요, 제 주변 지인들이 신호정보/전자전운용이 꿀보직이라고 많이 추천해주셔서 관심이 생겼습니다...",
            style: textTheme.bodySmall,
          ),
          buildSmallGap(),
          Row(
            children: [
              _buildChip(
                IconButton(
                  onPressed: () {},
                  icon: Icon(
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
                  icon: Icon(
                    Icons.thumb_down_outlined,
                  ),
                ),
                Text(
                  "2",
                  style: textTheme.labelSmall,
                ),
              ),
              _buildChip(
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.comment_outlined,
                  ),
                ),
                Text(
                  "5",
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
          SizedBox(
            width: 8,
          ),
          trailing,
        ],
      ),
    );
  }
}
