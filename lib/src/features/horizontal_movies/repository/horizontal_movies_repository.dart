import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_mania/src/core/enums/http_method.dart';
import 'package:movie_mania/src/core/network/api_client.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../home/models/movie_summary_model.dart';
import '../models/movie_list_type.dart';

abstract class HorizontalMoviesRepository {
  Future<Either<Failure, List<MovieSummary>>> movies({
    required MovieListType type,
    required String params,
  });
}

class HorizontalMoviesRepositoryImpl implements HorizontalMoviesRepository {
  final NetworkInfo networkInfo;
  final ApiClient apiClient;

  const HorizontalMoviesRepositoryImpl({
    required this.networkInfo,
    required this.apiClient,
  });

  @override
  Future<Either<Failure, List<MovieSummary>>> movies({
    required MovieListType type,
    required String params,
  }) async {
    if (await networkInfo.isConnected) {
      final response = await apiClient.request(
        HttpMethod.get,
        type.url(params),
        queryParams: type.queryParams(params),
      );

      if (response.data["success"] != null && !(response.data["success"])) {
        return Left(ServerFailure());
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
