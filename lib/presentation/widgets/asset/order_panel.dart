import 'package:flutter/material.dart';
import 'package:rse/all.dart';

class OrderPanel extends StatefulWidget {
  const OrderPanel({super.key});

  @override
  State<OrderPanel> createState() => OrderPanelState();
}

class OrderPanelState extends State<OrderPanel> {
  @override
  Widget build(BuildContext context) {
    final color = T(context, 'primary');
    final l = context.l;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Container(
            color: T(context, 'secondaryContainer'),
            child: DefaultTabController(
              length: 2,
              animationDuration: const Duration(milliseconds: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: TabBar(
                      labelColor: color,
                      indicatorColor: color,
                      unselectedLabelColor: Theme.of(context).indicatorColor,
                      tabs: [
                        SizedBox(
                          width: 30,
                          child: Tab(text: l.buy),
                        ),
                        SizedBox(
                          width: 30,
                          child: Tab(text: l.sell),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 30,
                          ),
                          child: Column(children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(l.order_type),
                                  const Spacer(),
                                  const Text('0.00000000'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(l.buy_in),
                                  const Spacer(),
                                  const Text('0.00000000'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(l.shares),
                                  const Spacer(),
                                  const Text('0.00000000'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(l.market_price),
                                  const Spacer(),
                                  const Text('0.00000000'),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(l.estimated_cost),
                                  const Spacer(),
                                  const Text('0.00000000'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: color,
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: Text(
                                  l.review_order,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 1,
                              color: Colors.grey[300],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('${l.buying_power} \$100,000'),
                              ],
                            ),
                          ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(l.order_type),
                                    const Spacer(),
                                    const Text('0.00000000'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(l.sell_in),
                                    const Spacer(),
                                    const Text('0.00000000'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(l.shares),
                                    const Spacer(),
                                    const Text('0.00000000'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(l.market_price),
                                    const Spacer(),
                                    const Text('0.00000000'),
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                height: 1,
                                color: Colors.grey[300],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(l.estimated_credit),
                                    const Spacer(),
                                    const Text('0.00000000'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    backgroundColor: color,
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                  ),
                                  child: Text(
                                    l.review_order,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey[300],
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${l.buying_power} \$100,000'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
