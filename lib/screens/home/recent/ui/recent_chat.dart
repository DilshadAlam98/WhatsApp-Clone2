import 'package:flutter/material.dart';

class RecentChat extends StatelessWidget {
  const RecentChat({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      padding: const EdgeInsets.symmetric(vertical: 15),
      itemBuilder: (context, index) {
        return _RecentChatTile(
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _RecentChatTile extends StatelessWidget {
  const _RecentChatTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      dense: true,
      leading: const CircleAvatar(radius: 38),
      title: const Text(
        "Dilshad Alam",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: const Text(
        "Hi, How are you?",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
