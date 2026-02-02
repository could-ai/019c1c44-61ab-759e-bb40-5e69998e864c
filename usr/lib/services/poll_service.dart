import 'package:flutter/material.dart';
import '../models/poll.dart';

class PollService extends ChangeNotifier {
  static final PollService _instance = PollService._internal();
  factory PollService() => _instance;

  PollService._internal() {
    // Add some dummy data
    _polls.add(Poll(
      id: '1',
      question: 'What is your favorite mobile framework?',
      options: [
        PollOption(id: 'opt1', text: 'Flutter', voteCount: 15),
        PollOption(id: 'opt2', text: 'React Native', voteCount: 5),
        PollOption(id: 'opt3', text: 'Native (Swift/Kotlin)', voteCount: 8),
      ],
    ));
    
    _polls.add(Poll(
      id: '2',
      question: 'Which AI model do you prefer?',
      options: [
        PollOption(id: 'optA', text: 'GPT-4', voteCount: 12),
        PollOption(id: 'optB', text: 'Claude 3.5', voteCount: 10),
        PollOption(id: 'optC', text: 'Gemini', voteCount: 7),
      ],
    ));
  }

  final List<Poll> _polls = [];

  List<Poll> get polls => List.unmodifiable(_polls);

  void addPoll(String question, List<String> options) {
    final newPoll = Poll(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      question: question,
      options: options.map((opt) => PollOption(
        id: DateTime.now().microsecondsSinceEpoch.toString() + opt.hashCode.toString(),
        text: opt,
      )).toList(),
    );
    _polls.add(newPoll);
    notifyListeners();
  }

  void vote(String pollId, String optionId) {
    final pollIndex = _polls.indexWhere((p) => p.id == pollId);
    if (pollIndex != -1) {
      final optionIndex = _polls[pollIndex].options.indexWhere((o) => o.id == optionId);
      if (optionIndex != -1) {
        _polls[pollIndex].options[optionIndex].voteCount++;
        notifyListeners();
      }
    }
  }
}
