import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/home_bloc/home_bloc.dart';
import '../blocs/home_bloc/home_event.dart';
import '../blocs/home_bloc/home_state.dart';
import '../repositories/movie_repository.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/auth_event.dart';

class HomeView extends StatelessWidget {
  final String type;

  const HomeView({super.key, this.type = 'animation'});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(movieRepository: MovieRepository())..add(HomeFetchMovies(type)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequestedEvent());
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HomeBloc>().add(HomeRefreshMovies(type));
                },
                child: ListView.builder(
                  itemCount: state.movies.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.movies.length) {
                      context.read<HomeBloc>().add(HomeLoadMoreMovies(type));
                      return const Center(child: CircularProgressIndicator());
                    }
                    final movie = state.movies[index];
                    return ListTile(
                      leading: Image.network(movie.posterURL),
                      title: Text(movie.title),
                    );
                  },
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
