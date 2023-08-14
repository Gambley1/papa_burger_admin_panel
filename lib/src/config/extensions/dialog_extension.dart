import 'package:flutter/material.dart';
import 'package:papa_burger_admin_panel/src/config/extensions/navigator_extension.dart';
import 'package:papa_burger_admin_panel/src/widgets/custom_form_field.dart';
import 'package:papa_burger_admin_panel/src/widgets/k_text.dart';

extension DialogExtension on BuildContext {
  Future<bool?> showConfirmationDialog() async {
    final passwordController = TextEditingController();
    final confirm = await showDialog<bool?>(
      context: this,
      barrierDismissible: false,
      builder: (context) {
        const desiredPassword = 'admin12345';
        var enteredPassword = passwordController.text;
        return AlertDialog(
          title: const KText(
            'Confirmation',
            color: Colors.black,
            size: 22,
            fontWeight: FontWeight.w600,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KText(
                'Please enter the special password:',
                color: Colors.grey.shade600,
              ),
              const SizedBox(height: 6),
              CustomFormField(
                textController: passwordController,
                textInputColor: Colors.black,
                onChanged: (value) {
                  enteredPassword = value;
                },
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.start,
          actions: [
            ElevatedButton(
              child: const KText(
                'Cancel',
              ),
              onPressed: () {
                context.pop<bool>(false);
              },
            ),
            ElevatedButton(
              child: const KText('Confirm'),
              onPressed: () {
                if (enteredPassword == desiredPassword) {
                  context.pop<bool>(true);
                }
              },
            ),
          ],
        );
      },
    );
    return confirm;
  }
}
