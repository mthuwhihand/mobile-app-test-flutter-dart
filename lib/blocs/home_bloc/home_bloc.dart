import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/movie_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository movieRepository;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMoreMovies = true;

  bool get hasMoreMovies => _hasMoreMovies;

  HomeBloc({required this.movieRepository}) : super(HomeInitial()) {
    on<HomeFetchMovies>(_onFetchMovies);
    on<HomeRefreshMovies>(_onRefreshMovies);
    on<HomeLoadMoreMovies>(_onLoadMoreMovies);
  }

  Future<void> _onFetchMovies(HomeFetchMovies event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final movies = await movieRepository.fetchMovies(type: event.type);
      _hasMoreMovies = movies.length > _pageSize;
      emit(HomeLoaded(movies.take(_pageSize).toList()));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshMovies(HomeRefreshMovies event, Emitter<HomeState> emit) async {
    _currentPage = 1;
    _hasMoreMovies = true;
    try {
      final movies = await movieRepository.fetchMovies(type: event.type);
      _hasMoreMovies = movies.length > _pageSize;
      emit(HomeLoaded(movies.take(_pageSize).toList()));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onLoadMoreMovies(HomeLoadMoreMovies event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded && _hasMoreMovies) {
      final currentState = state as HomeLoaded;
      _currentPage++;
      try {
        final newMovies = await movieRepository.fetchMovies(type: event.type);
        final fetchedMovies = newMovies.skip((_currentPage - 1) * _pageSize).take(_pageSize).toList();

        if (fetchedMovies.isEmpty) {
          _hasMoreMovies = false;
          emit(HomeLoaded(List.from(currentState.movies)..addAll(fetchedMovies)));
        } else {
          emit(HomeLoaded(List.from(currentState.movies)..addAll(fetchedMovies)));
        }
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    }
  }
}
