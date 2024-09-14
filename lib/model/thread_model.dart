class ThreadModel {
  ThreadModel(
    this.threadId,
  );

  final String threadId;

  factory ThreadModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ThreadModel(
      json["thread_id"],
    );
  }
}
