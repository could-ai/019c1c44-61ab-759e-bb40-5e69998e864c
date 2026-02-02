import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voting System'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.how_to_vote, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 40),
            const Text(
              'Select Your Role',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text('Admin'),
                onPressed: () {
                  Navigator.pushNamed(context, '/admin');
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.person),
                label: const Text('Voter'),
                onPressed: () {
                  Navigator.pushNamed(context, '/user');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
