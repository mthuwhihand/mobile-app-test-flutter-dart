import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchMovies extends HomeEvent {
  final String type;

  const HomeFetchMovies(this.type);

  @override
  List<Object> get props => [type];
}

class HomeRefreshMovies extends HomeEvent {
  final String type;

  const HomeRefreshMovies(this.type);

  @override
  List<Object> get props => [type];
}

class HomeLoadMoreMovies extends HomeEvent {
  final String type;

  const HomeLoadMoreMovies(this.type);

  @override
  List<Object> get props => [type];
}