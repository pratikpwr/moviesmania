import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_mania/src/core/enums/http_method.dart';
import 'package:movie_mania/src/core/network/api_client.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../home/models/movie_summary_model.dart';

abstract class SearchMoviesRepository {
  Future<Either<Failure, List<MovieSummary>>> searchMovies(String keyword);
}

class SearchMoviesRepositoryImpl implements SearchMoviesRepository {
  final NetworkInfo networkInfo;
  final ApiClient apiClient;

  const SearchMoviesRepositoryImpl({
    required this.networkInfo,
    required this.apiClient,
  });

  @override
  Future<Either<Failure, List<MovieSummary>>> searchMovies(
      String keyword) async {
    if (await networkInfo.isConnected) {
      final response = await apiClient.request(
        HttpMethod.get,
        '${ApiConstants.movieDBBaseUrl}/search/movie',
        queryParams: {
          "api_key": ApiConstants.movieApiKey,
          'query': keyword,
        },
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
