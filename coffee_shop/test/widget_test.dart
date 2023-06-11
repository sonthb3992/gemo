// import 'package:coffee_shop/domain/concrete/drink_order.dart';
// import 'package:coffee_shop/domain/concrete/enums.dart';
// import 'package:coffee_shop/controls/size_selector.dart';
// import 'package:coffee_shop/viewmodels/new_order_viewmodel.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter/material.dart';

// void main() {
//   testWidgets('SizeSelector test', (WidgetTester tester) async {
//     var orderState = NewOrderState(MenuOption.coffee);

//     await tester.pumpWidget(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider<NewOrderState>.value(value: orderState),
//         ],
//         child: MaterialApp(
//           home: SizeSelector(DrinkOrder(MenuOption.coffee)),
//         ),
//       ),
//     );

//     // Test if "Size" title exists.
//     expect(find.text('Size'), findsOneWidget);

//     // Tap on the Size S option and verify the selection.
//     await tester.tap(find.text('Size S'));
//     await tester.pump();
//     expect(orderState.getDrinkSize(), DrinkSizeOption.s);

//     // Tap on the Size M option and verify the selection.
//     await tester.tap(find.text('Size M'));
//     await tester.pump();
//     expect(orderState.getDrinkSize(), DrinkSizeOption.m);
//   });
// }
