import 'package:b2b_mobile_app/l10n/app_localizations.dart';
import 'package:b2b_mobile_app/screens/home/main_home.dart';
import 'package:flutter/material.dart';

class SmsCodeScreen extends StatelessWidget {
  final String phone;
  const SmsCodeScreen({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final ctrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text(t.verifyCode)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(t.enter6digitCode),
            const SizedBox(height: 20),

            TextField(
              controller: ctrl,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomeScreen(),
                  ),
                );
              },
              child: Text(t.confirm),
            ),
          ],
        ),
      ),
    );
  }
}