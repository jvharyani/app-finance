// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:app_finance/_classes/herald/app_locale.dart';
import 'package:app_finance/charts/interface/ohlc_data.dart';
import 'package:app_finance/charts/painter/foreground_chart_painter.dart';
import 'package:app_finance/charts/painter/ohlc_chart_painter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OhlcChart extends StatelessWidget {
  final double width;
  final double height;
  final double indent;
  final DateTime xMin;
  final String tooltip;
  final List<OhlcData> data;

  const OhlcChart({
    super.key,
    required this.data,
    required this.width,
    required this.height,
    required this.xMin,
    this.indent = 0.0,
    this.tooltip = '',
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final size = Size(width, height);
    final bgColor = Theme.of(context).colorScheme.onBackground;
    final xMax = DateTime(now.year, now.month + 1);
    double yMin = 0.0;
    double yMax = 0.0;
    for (int i = 0; i < data.length; i++) {
      if (data[i].low < yMin) yMin = data[i].low;
      if (data[i].high > yMax) yMax = data[i].high;
    }
    yMax *= 1.25;
    final bg = ForegroundChartPainter(
      size: size,
      color: bgColor,
      lineColor: bgColor,
      background: bgColor.withOpacity(0.1),
      yMin: yMin,
      yMax: yMax,
      xType: DateTime,
      xMin: xMin.microsecondsSinceEpoch.toDouble(),
      xMax: xMax.microsecondsSinceEpoch.toDouble(),
      xDivider: 6,
      xTpl: DateFormat.Md(AppLocale.code),
    );
    return SizedBox(
      height: size.height,
      width: size.width,
      child: CustomPaint(
        size: size,
        painter: OhlcChartPainter(
          indent: bg.shift,
          color: bgColor,
          size: size,
          data: data,
          yMax: yMax,
          xMin: xMin.microsecondsSinceEpoch.toDouble(),
          xMax: xMax.microsecondsSinceEpoch.toDouble(),
        ),
        foregroundPainter: bg,
        willChange: false,
        child: Padding(
          padding: EdgeInsets.only(top: indent / 4),
          child: Text(tooltip),
        ),
      ),
    );
  }
}
