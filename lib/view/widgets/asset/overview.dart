import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetBloc, AssetState>(builder: (context, state) {
      if (state is AssetLoaded) {
        final asset = state.asset;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const HoverDarken(child: YourPosition()),
            const HoverDarken(child: UpcomingActivity()),
            HoverDarken(child: About(asset: asset)),
            HoverDarken(child: KeyStatistics(asset: asset)),
            HoverDarken(child: ActivityHistory(asset: asset)),
          ]),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
