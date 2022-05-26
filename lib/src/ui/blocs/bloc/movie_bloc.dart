
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:prueba_omj/src/data/models/movie_model.dart';
import 'package:prueba_omj/src/data/repositories/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {

  //creamos un streamController por si se tiene que utilizar la actualizacion en 
  //infiniteScroll
  MovieBloc() : super(MovieInitial()) {
    
    final ApiRepository _apiRepository = ApiRepository();
    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList = await _apiRepository.fetchMovieList();
        emit(MovieLoaded(mList));
      } on NetworkError {
        emit(MovieError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
