import '../../../core/constants/api_constants.dart';

enum MovieListType {
  category,
  genre,
  similar;

  String url([String? query]) {
    switch (this) {
      case MovieListType.category:
        return '${ApiConstants.movieDBBaseUrl}/movie/$query';
      case MovieListType.genre:
        return '${ApiConstants.movieDBBaseUrl}/discover/movie';
      case MovieListType.similar:
        return '${ApiConstants.movieDBBaseUrl}/movie/$query/similar';
    }
  }

  Map<String, dynamic> queryParams([String? id]) {
    var params = {
      "api_key": ApiConstants.movieApiKey,
    };

    switch (this) {
      case MovieListType.category:
        break;
      case MovieListType.genre:
        if (id != null) {
          params["with_genres"] = id;
        }
        break;
      case MovieListType.similar:
        break;
    }

    return params;
  }
}
