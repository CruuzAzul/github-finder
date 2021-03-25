import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/main.dart';

void main() {
  group('GitHub Finder App', () {
    testWidgets('should display GitHub Finder MyApp() widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      expect(tester.takeException(), null);
    });
  });
}
