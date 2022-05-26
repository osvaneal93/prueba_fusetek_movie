import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:prueba_omj/src/data/models/movie_model.dart';
import 'package:prueba_omj/src/data/repositories/popular_repository.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  List<MovieModel> movieList = [];
  final PopularRepo _apiRepository = PopularRepo();
  PopularMovieBloc() : super(PopularMovieInitial()) {
    on<GetPopularList>((event, emit) async {
      try {
        List <MovieModel> mList = await _apiRepository.getPopular();
        movieList.addAll(mList);
        emit(PopularMovieLoaded(movieList));
      } on NetworkError {
        emit(PopularMovieError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
