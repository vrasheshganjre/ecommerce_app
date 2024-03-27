import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  testWidgets('Test Google Sign-In', (WidgetTester tester) async {
    // Create a mock GoogleSignIn object
    final googleSignIn = GoogleSignIn();

    // Build a test widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () async {
            try {
              // Trigger Google Sign-In
              await googleSignIn.signIn();
              // Check if the user is signed in
              expect(googleSignIn.currentUser, isNotNull);
            } catch (error) {
              // Handle sign-in errors
              print('Error signing in: $error');
            }
          },
          child: Container(),
        ),
      ),
    ));

    // Tap on the container to trigger sign-in
    await tester.tap(find.byType(Container));
    // Rebuild the widget after the tap
    await tester.pump();

    // Check if the user is signed in after tapping
    expect(googleSignIn.currentUser, isNotNull);
  });
}
