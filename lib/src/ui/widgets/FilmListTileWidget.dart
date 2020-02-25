import 'package:app_peliculas/src/blocs/MyFavoritesPageBloc.dart';
import 'package:app_peliculas/src/models/Genre.dart';
import 'package:app_peliculas/src/models/Language.dart';
import 'package:app_peliculas/src/models/Movie.dart';
import 'package:app_peliculas/src/ui/widgets/DataFieldWidget.dart';
import 'package:flutter/material.dart';

class FilmListTileWidget extends StatefulWidget {
  final Movie _movie;
  FilmListTileWidget(this._movie);

  @override
  _FilmListTileWidgetState createState() => _FilmListTileWidgetState(_movie);
}

class _FilmListTileWidgetState extends State<FilmListTileWidget> {
  Size _screenSize;
  final Movie _film;
  final MyFavoritesPageBloc _favoritesPageBloc = MyFavoritesPageBloc();

  _FilmListTileWidgetState(this._film);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _screenSize.width,
      height: 100,
      margin: EdgeInsets.all(5),
      color: Colors.white12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildLeading(),
          SizedBox(width: 10,),
          _buildInfo(),
        ],
      ),
    );
  }

  Widget _buildLeading() {
    return Image.network(_film.getImageUrl);
  }

  Widget _buildInfo() {
    String genre = "";
    String subLanguages = "";
    for (Language item in _film.getSubsLanguage) {
      if (item == _film.getSubsLanguage.last) {
        subLanguages += item.getLanguageName;
      } else {
        subLanguages += item.getLanguageName + " | ";
      }
    }
    for (Genre item in _film.getGenres) {
      if (item == _film.getGenres.last) {
        genre += item.getGenreName;
      } else {
        genre += item.getGenreName + " | ";
      }
    }
    return Container(
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_film.getTittle, style: TextStyle(fontSize: 18)),
          SizedBox(
            height: 5,
          ),
          Text(genre),
          SizedBox(
            height: 5,
          ),
          DataFieldWidget("Idioma", "${_film.getAudioLenguage.getLanguageName}"),
          SizedBox(
            height: 5,
          ),
          DataFieldWidget("Subtítulos", "$subLanguages")
        ],
      ),
    );
  }
}
