import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_mania/src/core/enums/http_method.dart';
import 'package:movie_mania/src/core/network/api_client.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../models/movie_model.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failure, Movie>> movieDetails(int movieId);
}

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final NetworkInfo networkInfo;
  final ApiClient apiClient;

  const MovieDetailsRepositoryImpl({
    required this.networkInfo,
    required this.apiClient,
  });

  @override
  Future<Either<Failure, Movie>> movieDetails(int movieId) async {
    if (await networkInfo.isConnected) {
      final response = await apiClient.request(
        HttpMethod.get,
        '${ApiConstants.movieDBBaseUrl}/movie/$movieId',
        queryParams: {
          "api_key": ApiConstants.movieApiKey,
        },
      );

      if (response.data["success"] != null && !(response.data["success"])) {
        return const Left(ServerFailure());
      }

      try {
        final result = Movie.fromJson(response.data);
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
