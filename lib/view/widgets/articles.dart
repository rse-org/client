import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rse/all.dart';

class Articles extends StatelessWidget {
  const Articles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                context.l.trending_news,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoaded) {
                final articles = state.articles;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Article(article: articles[index]);
                  },
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  getWidth(context) {
    var w = W(context);
    if (isS(context)) {
      return w;
    } else if (isM(context)) {
      return w * .9;
    } else {
      return w * .6;
    }
  }
}
