import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/movie_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MovieRepository movieRepository;
  int _currentPage = 1;// Tracks the current page number for pagination
  final int _pageSize = 10;// Number of movies per page
  bool _hasMoreMovies = true;// Flag to check if there are more movies to load

  // Getter
  bool get hasMoreMovies => _hasMoreMovies;

  // Initialize HomeBloc with MovieRepository and set up event handlers
  HomeBloc({required this.movieRepository}) : super(HomeInitial()) {
    on<HomeFetchMovies>(_onFetchMovies);
    on<HomeRefreshMovies>(_onRefreshMovies);
    on<HomeLoadMoreMovies>(_onLoadMoreMovies);
  }

  // Handle fetching movies event
  Future<void> _onFetchMovies(HomeFetchMovies event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    // Delay for 50 milliseconds before proceeding
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      // Fetch all movies
      final movies = await movieRepository.fetchMovies(type: event.type);
      _hasMoreMovies = movies.length > _pageSize;// Check if there are more movies to load
      emit(HomeLoaded(movies.take(_pageSize).toList()));// Emit refreshed movies
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  // Handle refreshing movies event
  Future<void> _onRefreshMovies(HomeRefreshMovies event, Emitter<HomeState> emit) async {
    _currentPage = 1;
    _hasMoreMovies = true;
    emit(HomeLoading());
    // Delay for 50 milliseconds before proceeding
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      final movies = await movieRepository.fetchMovies(type: event.type);
      _hasMoreMovies = movies.length > _pageSize; // Check if there are more movies to load
      emit(HomeLoaded(movies.take(_pageSize).toList()));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  // Handle loading more movies event
  Future<void> _onLoadMoreMovies(HomeLoadMoreMovies event, Emitter<HomeState> emit) async {
    if (state is HomeLoaded && _hasMoreMovies) {
      final currentState = state as HomeLoaded;
      _currentPage++;
      try {
        // Fetch all movies
        final newMovies = await movieRepository.fetchMovies(type: event.type);
        // Take additional movies
        /*
        * Ex: all movie we get through api is 45
        * but we are having 40, _currentPage = 4, _pageSize = 10
        * because at the top _currentPage++; =>_currentPage = 5
        * 45 skip about (5 - 1)*_pageSize = 40 first items, and take 10 more => so we will have last 5 items
        * */
        final fetchedMovies = newMovies.skip((_currentPage - 1) * _pageSize).take(_pageSize).toList();

        // Check if the fetched movies are fewer than the page size, indicating no more movies to load
        if (fetchedMovies.length < _pageSize) {
          _hasMoreMovies = false;
        }
        emit(HomeLoaded(List.from(currentState.movies)..addAll(fetchedMovies)));// Emit the updated list of movies
      } catch (e) {
        emit(HomeError(e.toString()));// Emit error state if an exception occurs
      }
    }
  }
}
