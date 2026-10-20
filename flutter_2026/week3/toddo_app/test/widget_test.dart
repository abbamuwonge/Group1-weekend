import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('Add, complete, and delete a task', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('No tasks yet! Add one above.'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.text('Add'));
    await tester.pump();

    expect(find.text('Buy milk'), findsOneWidget);
    expect(find.text('No tasks yet! Add one above.'), findsNothing);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);

    await tester.drag(find.text('Buy milk'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Delete this task?'), findsOneWidget);
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Buy milk'), findsNothing);
    expect(find.text('No tasks yet! Add one above.'), findsOneWidget);
  });

  testWidgets('Counter, priority, and clear completed stay in sync', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('My Tasks (0 left)'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'First task');
    await tester.tap(find.text('Add'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Second task');
    await tester.tap(find.text('Add'));
    await tester.pump();
    expect(find.text('My Tasks (2 left)'), findsOneWidget);

    await tester.longPress(find.text('First task'));
    await tester.pump();
    expect(find.byIcon(Icons.star), findsOneWidget);

    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();
    expect(find.text('My Tasks (1 left)'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear completed'));
    await tester.pumpAndSettle();
    expect(find.text('First task'), findsNothing);
    expect(find.text('Second task'), findsOneWidget);
    expect(find.text('My Tasks (1 left)'), findsOneWidget);

    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();
    expect(find.text('My Tasks (0 left)'), findsOneWidget);
    await tester.tap(find.byTooltip('Clear completed'));
    await tester.pumpAndSettle();
    expect(find.text('No tasks yet! Add one above.'), findsOneWidget);
    expect(
      tester.widget<IconButton>(find.byType(IconButton).first).onPressed,
      isNull,
    );
  });

  testWidgets('Delete asks for confirmation and Undo restores task position', (
    tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    for (final title in ['First task', 'Middle task', 'Last task']) {
      await tester.enterText(find.byType(TextField), title);
      await tester.tap(find.text('Add'));
      await tester.pump();
    }

    await tester.tap(find.byTooltip('Delete task').at(1));
    await tester.pumpAndSettle();
    expect(find.text('Delete this task?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Middle task'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete task').at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Middle task'), findsNothing);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    final taskTitles = tester
        .widgetList<ListTile>(find.byType(ListTile))
        .map((tile) => (tile.title as Text).data)
        .toList();
    expect(taskTitles, ['First task', 'Middle task', 'Last task']);
  });

  testWidgets('Empty or blank input does not add a task', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '   ');
    await tester.tap(find.text('Add'));
    await tester.pump();

    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('Tap a task to edit its title', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Buy milk');
    await tester.tap(find.text('Add'));
    await tester.pump();

    await tester.tap(find.text('Buy milk'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'Buy bread');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Buy bread'), findsOneWidget);
    expect(find.text('Buy milk'), findsNothing);
  });

  testWidgets('Saved tasks are loaded when the app starts', (tester) async {
    SharedPreferences.setMockInitialValues({
      'tasks': '[{"title":"Saved task","isDone":true}]',
    });

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Saved task'), findsOneWidget);
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    expect(find.byIcon(Icons.star), findsNothing);
  });
}
