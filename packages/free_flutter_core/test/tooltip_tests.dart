import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_flutter_core/core.dart';

///This method runs the test scenarios for sftooltip widget.
void tooltipTest() {
  group('Tooltip position', () {
    _TooltipContainer? tooltipContainer;
    FfTooltipRenderBox? renderBox;
    FfTooltipState tooltipState;
    testWidgets('tooltip show position', (WidgetTester tester) async {
      tooltipContainer = _TooltipContainer('category_default');
      await tester.pumpWidget(tooltipContainer!);
      final FfTooltip tooltip = tooltipContainer!.tooltip;
      tooltipState =
          // ignore: avoid_as
          (tooltip.key! as GlobalKey).currentState! as FfTooltipState;
      tooltipState.renderBox?.stringValue = 'test';
      tooltipState.renderBox?.boundaryRect = Rect.fromLTWH(0, 0, 400, 300);
      tooltip.show(Offset(0, 100), 100);
      renderBox = tooltipState.renderBox;
      await tester.pump(const Duration(seconds: 3));
    });

    test('to test tooltip position', () {
      expect(renderBox?.x, 0);
      expect(renderBox?.y, 100);
    });

    test('to test tooltip direction', () {
      expect(renderBox?.isLeft, true);
      expect(renderBox?.isOutOfBoundInTop, false);
      expect(renderBox?.isRight, false);
      expect(renderBox?.isTop, true);
    });

    tooltipContainer = renderBox = null;
    testWidgets('tooltip show position', (WidgetTester tester) async {
      tooltipContainer = _TooltipContainer('category_default');
      await tester.pumpWidget(tooltipContainer!);
      final FfTooltip tooltip = tooltipContainer!.tooltip;
      tooltipState =
          // ignore: avoid_as
          (tooltip.key! as GlobalKey).currentState! as FfTooltipState;
      tooltipState.renderBox?.stringValue = 'test';
      tooltipState.renderBox?.boundaryRect = Rect.fromLTWH(0, 0, 400, 300);
      tooltip.show(Offset(100, 100), 100);
      renderBox = tooltipState.renderBox;
      await tester.pump(const Duration(seconds: 3));
    });

    test('to test tooltip position', () {
      expect(renderBox?.x, 100);
      expect(renderBox?.y, 100);
    });

    test('to test tooltip direction', () {
      expect(renderBox?.isLeft, false);
      expect(renderBox?.isOutOfBoundInTop, false);
      expect(renderBox?.isRight, false);
      expect(renderBox?.isTop, true);
    });

    tooltipContainer = renderBox = null;
    testWidgets('tooltip show position', (WidgetTester tester) async {
      tooltipContainer = _TooltipContainer('category_default');
      await tester.pumpWidget(tooltipContainer!);
      final FfTooltip tooltip = tooltipContainer!.tooltip;
      tooltipState =
          // ignore: avoid_as
          (tooltip.key! as GlobalKey).currentState! as FfTooltipState;
      tooltipState.renderBox?.stringValue = 'test';
      tooltipState.renderBox?.inversePadding = 0.0;
      tooltipState.renderBox?.boundaryRect = Rect.fromLTWH(0, 0, 400, 300);
      tooltip.show(Offset(100, 0), 100);
      renderBox = tooltipState.renderBox;
      await tester.pump(const Duration(seconds: 3));
    });

    test('to test tooltip position', () {
      expect(renderBox?.x, 100);
      expect(renderBox?.y, 0);
    });

    test('to test tooltip direction', () {
      expect(renderBox?.isLeft, false);
      expect(renderBox?.isOutOfBoundInTop, false);
      expect(renderBox?.isRight, false);
      expect(renderBox?.isTop, false);
    });

    tooltipContainer = renderBox = null;
    testWidgets('tooltip show position', (WidgetTester tester) async {
      tooltipContainer = _TooltipContainer('category_default');
      await tester.pumpWidget(tooltipContainer!);
      final FfTooltip tooltip = tooltipContainer!.tooltip;
      tooltipState =
          // ignore: avoid_as
          (tooltip.key! as GlobalKey).currentState! as FfTooltipState;
      tooltipState.renderBox?.stringValue = 'test';
      tooltipState.renderBox?.inversePadding = 0.0;
      tooltipState.renderBox?.boundaryRect = Rect.fromLTWH(0, 0, 400, 300);
      tooltip.show(Offset(0, 0), 100);
      renderBox = tooltipState.renderBox;
      await tester.pump(const Duration(seconds: 3));
    });

    test('to test tooltip position', () {
      expect(renderBox?.x, 0);
      expect(renderBox?.y, 0);
    });

    test('to test tooltip direction', () {
      expect(renderBox?.isLeft, true);
      expect(renderBox?.isOutOfBoundInTop, false);
      expect(renderBox?.isRight, false);
      expect(renderBox?.isTop, false);
    });
    tooltipContainer = renderBox = null;
    testWidgets('tooltip show position', (WidgetTester tester) async {
      tooltipContainer = _TooltipContainer('category_default');
      await tester.pumpWidget(tooltipContainer!);
      final FfTooltip tooltip = tooltipContainer!.tooltip;
      tooltipState =
          // ignore: avoid_as
          (tooltip.key! as GlobalKey).currentState! as FfTooltipState;
      tooltipState.renderBox?.stringValue = 'test';
      tooltipState.renderBox?.inversePadding = 0.0;
      tooltipState.renderBox?.boundaryRect = Rect.fromLTWH(0, 0, 400, 300);
      tooltip.show(Offset(10, 0), 00);
      renderBox = tooltipState.renderBox;
      await tester.pump(const Duration(seconds: 3));
    });

    test('to test tooltip position', () {
      expect(renderBox?.x, 10);
      expect(renderBox?.y, 0);
    });

    test('to test tooltip direction', () {
      expect(renderBox?.isLeft, true);
      expect(renderBox?.isOutOfBoundInTop, false);
      expect(renderBox?.isRight, false);
      expect(renderBox?.isTop, false);
    });

    tooltipContainer = renderBox = null;
    testWidgets('tooltip show position', (WidgetTester tester) async {
      tooltipContainer = _TooltipContainer('category_default');
      await tester.pumpWidget(tooltipContainer!);
      final FfTooltip tooltip = tooltipContainer!.tooltip;
      tooltipState =
          // ignore: avoid_as
          (tooltip.key! as GlobalKey).currentState! as FfTooltipState;
      tooltipState.renderBox?.stringValue = 'test';
      tooltipState.renderBox?.header = 'test';
      tooltipState.renderBox?.inversePadding = 0.0;
      tooltipState.renderBox?.boundaryRect = Rect.fromLTWH(0, 0, 400, 300);
      tooltip.show(Offset(399, 100), 00);
      renderBox = tooltipState.renderBox;
      await tester.pump(const Duration(seconds: 3));
    });

    test('to test tooltip position', () {
      expect(renderBox?.x, 399);
      expect(renderBox?.y, 100);
    });

    test('to test tooltip direction', () {
      expect(renderBox?.isLeft, false);
      expect(renderBox?.isOutOfBoundInTop, false);
      expect(renderBox?.isRight, true);
      expect(renderBox?.isTop, true);
    });

    tooltipContainer = renderBox = null;
    testWidgets('tooltip show position with  template',
        (WidgetTester tester) async {
      tooltipContainer = _TooltipContainer('template');
      await tester.pumpWidget(tooltipContainer!);
      final FfTooltip tooltip = tooltipContainer!.tooltip;
      tooltipState =
          // ignore: avoid_as
          (tooltip.key! as GlobalKey).currentState! as FfTooltipState;
      final Widget template = Container(
          height: 30, width: 50, color: Colors.red, child: Text('test'));
      tooltipState.renderBox?.stringValue = 'test';
      tooltipState.renderBox?.inversePadding = 0.0;
      tooltipState.renderBox?.boundaryRect = Rect.fromLTWH(0, 0, 400, 300);
      tooltip.show(Offset(100, 100), 100, template);
      renderBox = tooltipState.renderBox;
      await tester.pump(const Duration(seconds: 3));
    });

    test('to test tooltip position', () {
      expect(renderBox?.x, 100);
      expect(renderBox?.y, 100);
    });

    test('to test tooltip direction', () {
      expect(renderBox?.isLeft, false);
      expect(renderBox?.isOutOfBoundInTop, false);
      expect(renderBox?.isRight, false);
      expect(renderBox?.isTop, false);
    });
  });
}

// ignore: must_be_immutable
class _TooltipContainer extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  _TooltipContainer(String sampleName) {
    tooltip = FfTooltip(
      shouldAlwaysShow: true,
      key: GlobalKey(),
      builder: sampleName == 'template'
          ? () {
              print('building');
            }
          : null,
    );
  }
  late FfTooltip tooltip;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tooltip test',
      home: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
          // appBar: AppBar(
          //   title: const Text('Test Chart Widget'),
          // ),
          body: Center(
              child: Container(
            // color: Colors.blue,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            // height: 300,
            // width: 400,
            child: Stack(children: [
              Container(
                color: Colors.orange,
              ),
              tooltip
            ]),
          ))),
    );
  }
}
