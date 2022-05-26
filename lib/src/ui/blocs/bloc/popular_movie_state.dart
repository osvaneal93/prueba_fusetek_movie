part of 'popular_movie_bloc.dart';


@immutable
abstract class PopularMovieState extends Equatable {}

class PopularMovieInitial extends PopularMovieState {


  @override
  List<Object> get props => throw UnimplementedError();
}

class PopularMovieLoaded extends PopularMovieState {
  final List<MovieModel> movieList;
  PopularMovieLoaded(this.movieList);
  List<Object> get props => [movieList];
 
}

class PopularMovieError extends PopularMovieState {
  final String? message;

  PopularMovieError(this.message);
  
  List<Object?> get props => throw UnimplementedError(message);
  
}
