import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rse/all.dart';

class FetchNews extends NewsEvent {
  final List<NewsArticle> articles;

  FetchNews(this.articles);

  @override
  List<Object?> get props => [articles];
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsService _newsService = NewsService();

  NewsBloc() : super(NewsInitial());

  Future<void> fetchArticles() async {
    try {
      final articles = await _newsService.fetchArticles();
      // ignore: invalid_use_of_visible_for_testing_member
      emit(NewsLoaded(articles));
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching articles: $error');
      }
    }
  }
}

class NewsError extends NewsState {
  final dynamic error;

  NewsError(this.error);
}

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;

  NewsLoaded(this.articles);
}

abstract class NewsState {}
