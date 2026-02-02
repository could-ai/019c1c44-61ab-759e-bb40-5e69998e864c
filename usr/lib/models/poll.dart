class PollOption {
  final String id;
  final String text;
  int voteCount;

  PollOption({required this.id, required this.text, this.voteCount = 0});
}

class Poll {
  final String id;
  final String question;
  final List<PollOption> options;
  bool isClosed;

  Poll({
    required this.id,
    required this.question,
    required this.options,
    this.isClosed = false,
  });

  int get totalVotes => options.fold(0, (sum, item) => sum + item.voteCount);
}
