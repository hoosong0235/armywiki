import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:armywiki/controller/get_thread_answer_controller.dart';
import 'package:armywiki/controller/get_thread_id_controller.dart';
import 'package:armywiki/model/chat_model.dart';
import 'package:armywiki/model/thread_model.dart';
import 'package:armywiki/model/unit_model.dart';
import 'package:armywiki/utility/color.dart';
import 'package:armywiki/utility/constant.dart';
import 'package:armywiki/utility/enum.dart';
import 'package:armywiki/utility/widget.dart';

class AiView extends StatefulWidget {
  const AiView(
    this.unitModel, {
    super.key,
  });

  final UnitModel unitModel;

  @override
  State<AiView> createState() => _AiViewState();
}

class _AiViewState extends State<AiView> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.close,
          ),
        ),
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/armywikiAISmall.svg",
        ),
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: GeminiGradient,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: GetThreadIdController.getThreadId(
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
            ThreadModel threadModel = snapshot.data!;

            return AiChatView(
              widget.unitModel,
              threadModel,
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
}

class AiChatView extends StatefulWidget {
  const AiChatView(
    this.unitModel,
    this.threadModel, {
    super.key,
  });

  final UnitModel unitModel;
  final ThreadModel threadModel;

  @override
  State<AiChatView> createState() => _AiChatViewState();
}

class _AiChatViewState extends State<AiChatView> {
  List<ChatModel> chatModels = [];
  SearchController searchController = SearchController();
  String question = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          ListView(
            children: [
              buildGap(),
              for (var chatModel in chatModels)
                Column(
                  children: [
                    _buildChat(
                      chatModel.text,
                      chatModel.sender,
                    ),
                    buildGap(),
                  ],
                ),
              buildGap(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
            ),
            child: SearchBar(
              controller: searchController,
              hintText: "아미위키 AI에게 물어보세요.",
              onChanged: (value) => question = value,
              onSubmitted: (value) async {
                if (!isLoading && question.isNotEmpty) {
                  isLoading = true;
                  searchController.clear();

                  String questionCopy = question;
                  question = "";

                  chatModels.add(
                    ChatModel(
                      questionCopy,
                      Sender.user,
                    ),
                  );

                  setState(() {});

                  chatModels.add(
                    await GetThreadAnswerController.getThreadAnswer(
                      widget.unitModel.unitId,
                      widget.threadModel.threadId,
                      questionCopy,
                    ),
                  );

                  isLoading = false;

                  setState(() {});
                }
              },
              trailing: [
                isLoading
                    ? CircularProgressIndicator(
                        color: geminiRandom,
                      )
                    : IconButton(
                        onPressed: () async {
                          if (!isLoading && question.isNotEmpty) {
                            isLoading = true;
                            searchController.clear();

                            chatModels.add(
                              ChatModel(
                                question,
                                Sender.user,
                              ),
                            );

                            setState(() {});

                            chatModels.add(
                              await GetThreadAnswerController.getThreadAnswer(
                                widget.unitModel.unitId,
                                widget.threadModel.threadId,
                                question,
                              ),
                            );

                            question = "";
                            isLoading = false;

                            setState(() {});
                          }
                        },
                        icon: Icon(
                          Icons.keyboard_return,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildChat(
    String text,
    Sender sender,
  ) {
    return Row(
      mainAxisAlignment: sender.mainAxisAlignment,
      children: [
        Container(
          padding: chatEdgeInsets,
          constraints: BoxConstraints(
            maxWidth: 288,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: sender.borderRadius,
            boxShadow: kElevationToShadow[1],
          ),
          child: MarkdownBody(
            data: text,
            // style: textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
