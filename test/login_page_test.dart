import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:post_recipe/view/login_page.dart';

void main() {
  group("LoginPage Widget Test", () {
    testWidgets("semua widget ada", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      // Verifikasi ada teks "Silahkan Masuk untuk melanjutkan"
      expect(find.text("Silahkan Masuk untuk melanjutkan"), findsOneWidget);

      // Verifikasi adanya key username dan password
      expect(find.byKey(const Key('username')), findsOneWidget);
      expect(find.byKey(const Key('password')), findsOneWidget);

      // Verifikasi adanya tombol "Masuk"
      expect(find.byKey(const Key('login_button')), findsOneWidget);
    });

    testWidgets("dapat menginputkan text pada field",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(),
      ));

      // Mengisi text pada field
      await tester.enterText(find.byKey(const Key('username')), 'testuser');
      await tester.enterText(find.byKey(const Key('password')), 'test123');

      // Verifikasi hasil inputan
      expect(find.text('testuser'), findsOneWidget);
      expect(find.text('test123'), findsOneWidget);
    });
  });
}
