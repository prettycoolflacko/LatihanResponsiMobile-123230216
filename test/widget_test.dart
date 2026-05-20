import 'package:flutter_test/flutter_test.dart';

import 'package:quiz_mobile/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp(isLoggedIn: false));
    // Verify the login page loads
    expect(find.text('ShopApp'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
