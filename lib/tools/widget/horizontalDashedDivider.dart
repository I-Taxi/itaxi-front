import 'package:flutter/material.dart';

class HorizontalDashedDivider extends Divider {
  final double? space; // 디바이더의 높이
  final double? length; // 점선 하나의 길이
  final double? thickness; // 점선의 두께
  final Color? color; // 점선의 색깔
  final double? indent; // 점선이 시작하기 전 빈공간 길이 (좌측 빈 공간)
  final double? endIndent; // 점선이 끝난 후 빈공간 길이 (우측 빈 공간)

  HorizontalDashedDivider({Key? key, this.space, this.length, this.thickness, this.color, this.indent, this.endIndent})
      : assert(space == null || space >= 0.0),
        assert(length == null || length >= 0.0),
        assert(thickness == null || thickness >= 0.0),
        assert(indent == null || indent >= 0.0),
        assert(endIndent == null || endIndent >= 0.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Part1
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    final double space = this.space ?? dividerTheme.space ?? 10.0;
    final double length = this.length ?? 10.0;
    final double thickness = this.thickness ?? dividerTheme.thickness ?? 5.0;
    final Color color = this.color ?? dividerTheme.color ?? Theme.of(context).dividerColor;
    final double indent = this.indent ?? dividerTheme.indent ?? 0.0;
    final double endIndent = this.endIndent ?? dividerTheme.endIndent ?? 0.0;

    // Part2
    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent),
      child: Container(
        height: space,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final boxWidth = constraints.constrainWidth();
            final dashLength = length;
            final dashThickness = thickness;
            final dashCount = (boxWidth / (2 * dashLength)).floor();
            return Flex(
              children: List.generate(dashCount, (_) {
                return SizedBox(
                  width: dashLength,
                  height: dashThickness,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: color),
                  ),
                );
              }),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
            );
          },
        ),
      ),
    );
  }
}
