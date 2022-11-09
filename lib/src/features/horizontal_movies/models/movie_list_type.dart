import '../../../core/constants/api_constants.dart';

enum MovieListType {
  category,
  genre,
  similar,
  search;

  String url([String? query]) {
    switch (this) {
      case MovieListType.category:
        return '${ApiConstants.movieDBBaseUrl}/movie/$query';
      case MovieListType.genre:
        return '${ApiConstants.movieDBBaseUrl}/discover/movie';
      case MovieListType.similar:
        return '${ApiConstants.movieDBBaseUrl}/movie/$query/similar';
      case MovieListType.search:
        return '${ApiConstants.movieDBBaseUrl}/search/movie';
    }
  }

  Map<String, dynamic> queryParams([String? query]) {
    var params = {
      "api_key": ApiConstants.movieApiKey,
    };

    switch (this) {
      case MovieListType.category:
        break;
      case MovieListType.genre:
        if (query != null) {
          params["with_genres"] = query;
        }
        break;
      case MovieListType.similar:
        break;
      case MovieListType.search:
        if (query != null) {
          params["query"] = query;
        }
        break;
    }

    return params;
  }
}
