import 'package:flutter/material.dart';
import 'package:prueba_omj/src/data/models/movie_model.dart';
import 'package:prueba_omj/src/ui/blocs/bloc/movie_bloc.dart';

class DescriptionView extends StatelessWidget {
  DescriptionView({Key? key}) : super(key: key);
  final _blocProvider = MovieBloc();
  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;

    final MovieModel model =
        ModalRoute.of(context)!.settings.arguments as MovieModel;
    return Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            _sliverBarImage(sizeDevice, model),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        height: sizeDevice.height * .2,
                        width: sizeDevice.width * .25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: model.uniqueId!,

                            child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/movieapp.png'),
                              image: NetworkImage(
                                model.getPoster(),
                              ),
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/broken.png',
                                    fit: BoxFit.contain);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            model.title!,
                            style: const TextStyle(
                                color: Colors.amber, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              model.originalLanguage!,
                              style: const TextStyle(color: Colors.amber),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            model.voteAverage.toString(),
                            style: const TextStyle(
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.overview!,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.overview!,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.overview!,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.overview!,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        model.overview!,
                        style:
                            const TextStyle(color: Colors.amber, fontSize: 20),
                      ),)
                  ],
                ),
              ),
            ]))
          ],
        ));
  }

  SliverAppBar _sliverBarImage(Size sizeDevice, MovieModel model) {
    return SliverAppBar(
      centerTitle: true,
      title: Text(
        model.title!,
        style: const TextStyle(color: Colors.white),
      ),
      elevation: 2.0,
      floating: true,
      pinned: true,
      expandedHeight: sizeDevice.height * .25,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          placeholder: const AssetImage("assets/movieapp.png"),
          image: NetworkImage(model.getBackground()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
