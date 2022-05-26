import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_omj/src/data/models/movie_model.dart';
import 'package:prueba_omj/src/ui/blocs/bloc/movie_bloc.dart';
import 'package:prueba_omj/src/ui/blocs/bloc/popular_movie_bloc.dart';
import 'package:prueba_omj/src/ui/widgets/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PopularMovieBloc? movie;
  MovieBloc? movien;

  PageController _pageController = PageController(viewportFraction: .25);
  @override
  void initState() {
    super.initState();
    movie = BlocProvider.of<PopularMovieBloc>(context);
    movien = BlocProvider.of<MovieBloc>(context);

    movien!.add(GetMovieList());
    movie!.add(GetPopularList());
  }

  //declaramos estancia de blo como proveedor

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 300) {
        setState(() {
          movie!.add(GetPopularList());
        });
      }
    });
    final sizeDevice = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: _customSearchBar(),
      ),
      bottomNavigationBar: _customNavigationBar(),
      backgroundColor: Colors.grey.shade900,
      body: _moviesViewer(sizeDevice),
    );
  }

  //Generamos nuestro bloc provider para traer nuestra lista de peliculas
  Center _moviesViewer(Size sizeDevice) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: sizeDevice.height * .4,
              width: double.infinity,
      
      //El bloc builder tendra condicionales para marcar los estados de la aplicacion
      //dependiendo de ellos los eventos que se lanzaran al bloc
              child:
                  BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
                if (state is MovieInitial) {
                  return _buildLoading();
                } else if (state is MovieLoading) {
                  return _buildLoading();
                } else if (state is MovieLoaded) {
                  return _buildCard(context, state.movieModel);
                } else if (state is MovieError) {
                  return Container();
                } else {
                  return Container();
                }
              }),
            ),
            const SizedBox(height: 20),
            _infiniteScrollMovies(sizeDevice),
          ],
        ),
      ),
    );
  }

  BlocBuilder<PopularMovieBloc, PopularMovieState> _infiniteScrollMovies(
      Size screenSize) {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, state) {
        if (state is PopularMovieLoaded) {
          return Container(
            height: screenSize.height * .25,
            width: double.infinity,
            child: PageView.builder(
              controller: _pageController,
              itemCount: state.movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return _movieCard(screenSize, state.movieList[index]);
              },
            ),
          );
        } else {
          return Container(
            color: Colors.green,
          );
        }
      },
    );
  }

  _movieCard(Size screenSize, MovieModel movie) {
    movie.uniqueId = '${movie.id} - card';
    return Center(
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: movie.uniqueId!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'description/',
                        arguments: movie);
                  },
                  child: SizedBox(
                    height: screenSize.height * .21,
                    width: screenSize.width * .25,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/movieapp.png'),
                      image: NetworkImage(
                        movie.getPoster(),
                      ),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/broken.png',
                            fit: BoxFit.cover);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Un search bar demo para buscar en la base de datos peliculas en especifico
  TextField _customSearchBar() {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.grey.shade900,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        labelText: 'Search',
        icon: Icon(
          Icons.movie,
          color: Colors.amber,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.amber,
        ),
        suffixIcon: Icon(
          Icons.close,
          color: Colors.amber,
        ),
      ),
    );
  }

//Un custom Navigator que nos ayudaria a desplazarnos entre nuestras peliculas guardadas
//como favoritas y la lista general de peliculas
  Container _customNavigationBar() {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(137, 47, 46, 46),
            items:  [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie, color: Colors.white),
                label: 'Movies',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Favourite',
              )
            ],
          ),
        ));
  }
}

//Widget que se encarga de trae nuestro moviePage del widget personalizado, se puede
//omitir pero hace m'as faciles los cambios en caso de crear un widget nuevo para mostrar peliculas
Widget _buildCard(BuildContext context, List<MovieModel> model) {
  final sizeDevice = MediaQuery.of(context).size;
  return MoviePageview(sizeDevice: sizeDevice, peliculas: model);
}

//mostrar en caso de estar crgando la informacion
Widget _buildLoading() => Center(child: CircularProgressIndicator());
