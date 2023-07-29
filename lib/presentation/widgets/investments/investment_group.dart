import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rse/all.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvestmentGroup extends StatefulWidget {
  final int num;
  final String title;
  final List<dynamic> securities;

  const InvestmentGroup({
    Key? key,
    required this.num,
    required this.title,
    required this.securities,
  }) : super(key: key);

  @override
  State<InvestmentGroup> createState() => InvestmentGroupState();
}

class InvestmentGroupState extends State<InvestmentGroup> {
  int explodeIdx = 0;
  int hoveredRowIdx = 0;
  bool shouldExplode = false;
  String _sortField = 'totalValue';
  List<Investment> sortedSecurities = [];
  late ActivationMode activationMode = ActivationMode.none;

  @override
  Widget build(BuildContext context) {
    if (isS(context) || isM(context)) {
      return Column(
        children: [
          Doughnut(
            field: _sortField,
            data: sortedSecurities,
            explodeIdx: explodeIdx,
            shouldExplode: shouldExplode,
            activationMode: activationMode,
            hoveredRowIndex: hoveredRowIdx,
          ),
          SummaryTable(
              num: widget.num,
              title: widget.title,
              items: sortedSecurities,
              sortSecurities: sortSecurities,
              onCategoryHover: (int idx) {
                setState(() {
                  hoveredRowIdx = idx;
                });
                handleHover(idx);
              },
              onCategoryExit: (int idx) {
                resetExplosion(idx);
              }),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SummaryTable(
              num: widget.num,
              title: widget.title,
              items: sortedSecurities,
              sortSecurities: sortSecurities,
              onCategoryHover: (int idx) {
                setState(() {
                  hoveredRowIdx = idx;
                });
                handleHover(idx);
              },
              onCategoryExit: (int idx) {
                resetExplosion(idx);
              }),
        ),
        Expanded(
          flex: 2,
          child: Doughnut(
            field: _sortField,
            data: sortedSecurities,
            explodeIdx: explodeIdx,
            shouldExplode: shouldExplode,
            activationMode: activationMode,
            hoveredRowIndex: hoveredRowIdx,
          ),
        ),
      ],
    );
  }

  getHeight() {
    final h = H(context);
    if (isS(context)) {
      return h * .4;
    } else if (isM(context)) {
      return h * .8;
    } else if (isL(context)) {
      return h * .7;
    }
    return h * .9;
  }

  getWidth() {
    final w = W(context);
    if (isS(context)) {
      return w * .4;
    } else if (isM(context)) {
      return w * .8;
    } else if (isL(context)) {
      return w * .7;
    }
    return w * .9;
  }

  void handleHover(int idx) {
    setState(() {
      explodeIdx = idx;
      shouldExplode = true;
      // activationMode = ActivationMode.singleTap;
    });
  }

  @override
  void initState() {
    super.initState();
    sortedSecurities = widget.securities
        .mapIndexed(
          (idx, s) => Investment(
            idx: idx,
            name: s.symbol,
            value: s.price,
            quantity: s.quantity,
            totalValue: s.totalValue,
            percentage: s.percentOfGroup,
          ),
        )
        .toList();
  }

  void resetExplosion(int idx) {
    setState(() {
      explodeIdx = idx;
      shouldExplode = false;
      activationMode = ActivationMode.none;
    });
  }

  sortSecurities(List<Investment> newOrder, String field) {
    setState(() {
      _sortField = field;
      sortedSecurities = newOrder;
    });
  }
}
