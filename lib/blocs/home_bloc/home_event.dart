import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent(this.type);

  final String type;

  @override
  List<Object> get props => [type];
}

class HomeFetchMovies extends HomeEvent {
  const HomeFetchMovies(super.type);
}

class HomeRefreshMovies extends HomeEvent {
  const HomeRefreshMovies(super.type);
}

class HomeLoadMoreMovies extends HomeEvent {
  const HomeLoadMoreMovies(super.type);
}
