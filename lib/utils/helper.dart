import 'package:flutter/material.dart';

// spacing constants
const gap4 = SizedBox(height: 4);
const gap8 = SizedBox(height: 8);
const gap12 = SizedBox(height: 12);
const gap16 = SizedBox(height: 16);
const gap24 = SizedBox(height: 24);
const gap32 = SizedBox(height: 32);

const gapW4 = SizedBox(width: 4);
const gapW8 = SizedBox(width: 8);
const gapW12 = SizedBox(width: 12);
const gapW16 = SizedBox(width: 16);
const gapW24 = SizedBox(width: 24);

// text styles
const textTitle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Color.fromARGB(221, 29, 13, 79),
);

const textSubtitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: Color.fromARGB(221, 29, 13, 79),
);

const textBody = TextStyle(
  fontSize: 14,
  color: Color.fromARGB(221, 29, 13, 79),
);

const textBtn = TextStyle(
  fontSize: 14,
  color: Colors.white,
);

/// Widget untuk divider tipis antar bagian UI
const divider = Divider(height: 1, color: Colors.black12);

/// Widget placeholder ketika data kosong
Widget emptyState(String message) {
  return Center(
    child: Text(
      message,
      style: const TextStyle(color: Colors.grey),
      textAlign: TextAlign.center,
    ),
  );
}

/// Widget loading bawaan
const loadingIndicator = Center(child: CircularProgressIndicator());
