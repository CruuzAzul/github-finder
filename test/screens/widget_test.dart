import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/main.dart';
import 'package:github_search/modules/profiles/widgets/formTextField.dart';

void main() {
  group('Screens and widgets display test', () {
    testWidgets('Should display FormTextField on screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      var formField = find.byType(SearchField);

      expect(formField, findsOneWidget);
    });

    // testWidgets('Should display description on screen',
    //     (WidgetTester tester) async {
    //   // Build our app and trigger a frame.
    //   await tester.pumpWidget(MyApp());
    //   await tester.pumpAndSettle();

    //   var formField = find.byType(FormTextField);
    //   var textField =
    //       find.descendant(of: formField, matching: find.byType(TextField));
    //   await tester.enterText(textField, 'Test');
    //   // expect(
    //   //     find.byWidgetPredicate((Widget widget) =>
    //   //         widget is RichText &&
    //   //         widget.text.toPlainText() == 'Résultats de recherche pour '
    //   //       ),
    //   //     findsOneWidget);
    //   expect(find.text("Résultats de recherche pour "), findsOneWidget);
    // });
  });
}
