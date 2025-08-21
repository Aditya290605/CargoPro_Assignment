bool isValidE164(String input) => RegExp(r'^\+\d{10,15}$').hasMatch(input);
