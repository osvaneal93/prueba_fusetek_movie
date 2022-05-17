part of "widgets.dart";
//Generamos nuestro widget en donde mostraremos las portadas de las pelicula
//utilizamos la libreria de swipper para hacer mas dinamico el intercambio en animaciones.
class MoviePageview extends StatelessWidget {
  MoviePageview({
    Key? key,
    required this.sizeDevice,
    required this.peliculas,
  }) : super(key: key);

  final Size sizeDevice;
  final List<MovieModel> peliculas;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeDevice.height * .5,
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(peliculas[index].title!,
                      style: const TextStyle(color: Colors.amber, fontSize: 20),
                      overflow: TextOverflow.ellipsis)),
              SizedBox(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'description/',
                        arguments: peliculas[index]);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: FadeInImage(
                      placeholder: NetworkImage(peliculas[index].getPoster()),
                      image: NetworkImage(
                        peliculas[index].getPoster(),
                      ),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/broken.png',
                            fit: BoxFit.fitWidth);
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        itemCount: peliculas.length,
        itemWidth: sizeDevice.width * .6,
        layout: SwiperLayout.STACK,
        pagination: const SwiperPagination(),
      ),
    );
  }
}
