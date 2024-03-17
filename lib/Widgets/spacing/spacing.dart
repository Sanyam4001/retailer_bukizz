import 'package:flutter/widgets.dart';

extension WidgetSpacing on int {
  SizedBox get horizontalSpace => SizedBox(width: toDouble());
  SizedBox get verticalSpace => SizedBox(height: toDouble());
}
