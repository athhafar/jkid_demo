import 'package:flutter/material.dart';

class LanguageSelectionPage extends StatelessWidget {
  final ValueNotifier<String> selectedLanguage =
      ValueNotifier<String>('en'); // Default language: English

  void _changeLanguage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                onTap: () {
                  selectedLanguage.value = 'en';
                  Navigator.pop(context); // Close bottom sheet
                },
              ),
              ListTile(
                title: Text('Bahasa Indonesia'),
                onTap: () {
                  selectedLanguage.value = 'id';
                  Navigator.pop(context); // Close bottom sheet
                },
              ),
              ListTile(
                title: Text('日本語 (Japanese)'),
                onTap: () {
                  selectedLanguage.value = 'jp';
                  Navigator.pop(context); // Close bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: Center(
        child: ValueListenableBuilder<String>(
          valueListenable: selectedLanguage,
          builder: (context, language, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Selected Language: $language'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _changeLanguage(
                        context); // Show the language selection bottom sheet
                  },
                  child: Text('Change Language'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
