import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_mania/src/core/enums/http_method.dart';
import 'package:movie_mania/src/core/network/api_client.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../horizontal_movies/models/movie_list_type.dart';
import '../models/movie_summary_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MovieSummary>>> popularMovies();
}

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final ApiClient apiClient;

  const HomeRepositoryImpl({
    required this.networkInfo,
    required this.apiClient,
  });

  @override
  Future<Either<Failure, List<MovieSummary>>> popularMovies() async {
    if (await networkInfo.isConnected) {
      final response = await apiClient.request(HttpMethod.get,
          "https://api.themoviedb.org/3/movie/popular?api_key=9e6c3d0546de9eddf6d1152b55d93a23"
          // '${ApiConstants.movieDBBaseUrl}/popular?api_key=${ApiConstants.movieApiKey}',
          // queryParams: {
          //   "api_key": ApiConstants.movieApiKey,
          //   "page": 5,
          // },
          );

      if (response.data["success"] != null && !(response.data["success"])) {
        return const Left(ServerFailure());
      }

      try {
        final result = List<MovieSummary>.from(
          response.data["results"].map(
            (element) {
              return MovieSummary.fromJson(element);
            },
          ),
        );
        return Right(result);
      } catch (e) {
        debugPrint(e.toString());
        return Left(InternalFailure(e.toString()));
      }
    } else {
      return const Left(NoInternetFailure());
    }
  }
}
