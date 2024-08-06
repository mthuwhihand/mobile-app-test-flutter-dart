import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/home_bloc/home_bloc.dart';
import '../../../blocs/home_bloc/home_event.dart';
import '../../../blocs/home_bloc/home_state.dart';
import '../../../repositories/movie_repository.dart';
import '../../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/auth_bloc/auth_event.dart';
import '../widgets/network_image_with_fallback.dart';

class HomeView extends StatelessWidget {
  final String type;
  final String placeholderImage = 'assets/imgs/placeholder.jpg';//placeholder Image for error image from url

  const HomeView({super.key, this.type = 'animation'});//Fetch api movie type = animation

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
              tooltip: 'Log out',
              onPressed: () {
                context.read<AuthBloc>().add(const AuthLogoutRequestedEvent());
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
                      if (context.read<HomeBloc>().hasMoreMovies) {
                        context.read<HomeBloc>().add(HomeLoadMoreMovies(type));
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Center(
                          child: Text(
                            '- That\'s all -',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      }
                    }
                    final movie = state.movies[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 80.0),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            NetworkImageWithFallback(
                              // using NetworkImageWithFallback widget to handle image error
                              // when movie.posterURL is error url or not found image or other error
                              imageUrl: movie.posterURL,
                              placeholderAsset: placeholderImage,
                              height: 222,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 12.0),
                            Center(
                              child: Text(
                                movie.title,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
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
