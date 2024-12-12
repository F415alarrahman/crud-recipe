import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:post_recipe/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "login test",
    (WidgetTester tester) async {
      // Memulai aplikasi
      app.main(); // atau gunakan tester.pumpWidget(MaterialApp(home: LoginPage()));
      await tester.pumpAndSettle();

      // Verifikasi halaman login tampil
      expect(find.text("Silahkan Masuk untuk melanjutkan"),
          findsOneWidget); // Sesuaikan dengan teks di halaman login

      // Mengisi email dan password
      await tester.enterText(find.byKey(const Key('username')), 'testuser');
      await tester.enterText(find.byKey(const Key('password')), 'test123');

      // Verifikasi hasil inputan
      expect(find.text('testuser'), findsOneWidget);
      expect(find.text('test123'), findsOneWidget);

      // Menekan tombol login (pastikan key tombol sesuai)
      await tester.tap(find.byKey(const Key(
          "login_button"))); // Sesuaikan dengan key tombol login di LoginPage

      // Tunggu aplikasi memproses dan settle
      await tester.pumpAndSettle();

      // Verifikasi apakah halaman Home muncul setelah login berhasil
      expect(find.text("Home"),
          findsOneWidget); // Sesuaikan dengan teks atau widget yang ada pada halaman Home
    },
  );
}
