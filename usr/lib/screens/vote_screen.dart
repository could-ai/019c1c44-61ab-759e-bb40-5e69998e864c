import 'package:flutter/material.dart';
import '../../models/poll.dart';
import '../../services/poll_service.dart';

class VoteScreen extends StatefulWidget {
  final Poll poll;
  const VoteScreen({super.key, required this.poll});

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  String? _selectedOptionId;

  void _submitVote() {
    if (_selectedOptionId != null) {
      PollService().vote(widget.poll.id, _selectedOptionId!);
      
      // Navigate to results instead of just popping, so user sees the impact
      Navigator.pushReplacementNamed(
        context, 
        '/results',
        arguments: widget.poll,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cast Your Vote')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.poll.question,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: widget.poll.options.length,
                itemBuilder: (context, index) {
                  final option = widget.poll.options[index];
                  return RadioListTile<String>(
                    title: Text(option.text),
                    value: option.id,
                    groupValue: _selectedOptionId,
                    onChanged: (value) {
                      setState(() {
                        _selectedOptionId = value;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedOptionId == null ? null : _submitVote,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit Vote'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
