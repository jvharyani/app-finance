// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be
// found in the LICENSE file.

import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:app_finance/_classes/app_data.dart';
import 'package:app_finance/_classes/app_locale.dart';
import 'package:app_finance/helpers/theme_helper.dart';
import 'package:app_finance/_classes/app_route.dart';
import 'package:app_finance/routes/abstract_page.dart';
import 'package:app_finance/widgets/home/bill_widget.dart';
import 'package:flutter/material.dart';

class BillPage extends AbstractPage {
  BillPage() : super();

  @override
  BillPageState createState() => BillPageState();
}

class BillPageState extends AbstractPageState<BillPage> {
  @override
  String getTitle() {
    return AppLocale.labels.billHeadline;
  }

  @override
  Widget buildButton(BuildContext context, BoxConstraints constraints) {
    NavigatorState nav = Navigator.of(context);
    return FloatingActionButton(
      heroTag: 'bill_page',
      onPressed: () => nav.pushNamed(AppRoute.billAddRoute),
      tooltip: AppLocale.labels.addMainTooltip,
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget buildContent(BuildContext context, BoxConstraints constraints) {
    var helper = ThemeHelper(windowType: getWindowType(context));
    return Column(
      children: [
        BillWidget(
          margin: EdgeInsets.all(helper.getIndent()),
          title: AppLocale.labels.billHeadline,
          state: super.state.get(AppDataType.bills),
          offset: MediaQuery.of(context).size.width - helper.getIndent() * 2,
        )
      ],
    );
  }
}
