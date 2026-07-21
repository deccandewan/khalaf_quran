import 'package:flutter_test/flutter_test.dart';

import 'package:khalaf_quran/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const QuranApp());
    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pumpAndSettle();

    expect(find.text('Khalaf Quran'), findsWidgets);
  });

  test('surahNameForPage resolves the active surah from a saved page', () {
    expect(surahNameForPage(1), 'Al-Fatihah');
    expect(surahNameForPage(50), "Al-e-'Imran");
    expect(surahNameForPage(128), 'Al-An\'am');
  });
}
