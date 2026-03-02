import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    const String username = '@bob:example.com';
    return ListView(
      children: const [
        ListTile(
          title: Text(username),
        ),
      ],
    );
  }
}
