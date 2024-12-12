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
      app.main();
      await tester.pumpAndSettle();

      // Verifikasi halaman login tampil
      expect(find.text("Silahkan Masuk untuk melanjutkan"), findsOneWidget);

      // Mengisi email dan password
      await tester.enterText(
          find.byKey(const Key('username')), 'f415alarr@gmail.com');
      await tester.enterText(find.byKey(const Key('password')), 'faisal123');

      // Verifikasi hasil inputan
      expect(find.text('f415alarr@gmail.com'), findsOneWidget);
      expect(find.text('faisal123'), findsOneWidget);

      // Menekan tombol login (pastikan key tombol sesuai)
      await tester.tap(find.byKey(const Key("login_button")));
      await tester.pumpAndSettle(); // Tunggu navigasi ke halaman HomePage

      // Verifikasi apakah halaman Home sudah dimuat (berdasarkan AppBar atau elemen yang ada di HomePage)
      expect(find.text("Home Page"),
          findsOneWidget); // Verifikasi jika HomePage dimuat
    },
  );
}
